# hungarian-hip — FIXED (was BENCH_SIDE_DIVERGENT_TERMINATION)

`make smoke` used to hang indefinitely on both OCL and L0 backends.
Fixed 2026-07-22 by restructuring the bench (main.cu); two independent
bench-side portability bugs were found. A third latent bug (an upstream
step-4 priming race) surfaced on the Arc B570 on 2026-07-30 and was fixed
the same day.

## Root cause 1: in-kernel convergence spins (the documented hang)

`step_2()` used a `do {} while (repeat)` loop and `step_4()` a
`do {} while (s_found && !s_goto_5)` loop, where the `__shared__` bool
loop flags are written non-atomically by arbitrary threads between
barriers. On chipStar/Intel the block-side spin does not terminate
reliably.

Fix: the convergence loops were hoisted to the host. Each launch performs
exactly one pass over the zeros list and raises the global `repeat_kernel`
/ `goto_5` flags; the host relaunches while the flags demand it. This is
exactly the mechanism the original code already used for cross-block
convergence (the in-kernel loop was only an intra-block optimization), so
the algorithm is unchanged. The `__managed__` flags were converted to
plain `__device__` globals accessed with explicit
`hipMemcpyToSymbol/FromSymbol` around each launch.

## Root cause 2: CUDA warp-synchronous reductions (silent wrong answers + livelock)

`min_in_rows_warp_reduce`, `min_in_cols_warp_reduce` and
`min_warp_reduce` were warp-synchronous (no barriers, called under
`if (tid < 32)`), which requires 32-wide lockstep execution. OpenCL
devices do not guarantee that; on the chipStar CPU device the step-6
minimum reduction returned MAX_DATA regardless of input. Consequences:

- wrong (non-optimal) assignment costs, e.g. test 0 cost 2090 instead of
  the optimal 1289;
- a host-side livelock: step_4 finds no uncovered zero while
  `d_min_in_mat == MAX_DATA` makes step_6 wreck `slack` via signed
  overflow without ever creating a new zero, so the step-4/6 loop spins
  forever (observed 310k+ iterations with the zeros count frozen).

Fix: the three tail reductions are now barrier-synchronized loops
executed by ALL threads of the block (no barrier in divergent control
flow), with identical math.

## Root cause 3: step-4 priming race (upstream, exposed by the B570)

On the Arc B570 the restructured bench hung INSIDE `step_5a` (steps-3..6
outer iteration ~28): the augmenting-path chase
`while ((r = row_of_star_at_column[c]) >= 0) c = column_of_prime_at_row[r];`
spun forever, i.e. step 4 had produced a cyclic priming state.

The acyclicity of that chase rests on a temporal invariant: a starred
column only becomes uncovered after its star row was primed and covered,
so every chase hop lands on a strictly earlier-primed row. That requires
`column_of_prime_at_row[l]` to be immutable once `cover_row[l] == 1` is
observable. The upstream CUDA `step_4` enforces this only
probabilistically — the non-atomic check-then-act
`if (!cover_column[c] && !cover_row[l]) { prime; cover_row[l] = 1; }`
lets two threads both pass the `!cover_row[l]` test and one of them
overwrite the row's prime after its cover/uncover side effects were
already consumed by other threads, cross-linking primes into a cycle
(e.g. `prime[r1]=c2`, `prime[r2]=c1` with stars `c1@r1`, `c2@r2`).
Narrow schedulers (UHD 770 iGPU, typical CUDA runs) keep the check-act
window effectively closed; the B570's wide concurrent execution exposed
it.

Fix (main.cu `step_4`): the row cover is now an `atomicExch` claim —
exactly one thread wins the 0->1 transition and only the winner primes
the row; losers do nothing (their zero is covered and the winner raised
`repeat_kernel`). Rows without a star are never covered, so their
last-write-wins priming remains valid (any uncovered zero column is a
valid chase entry). `step_5a` additionally gained a fail-loudly backstop:
the chase is bounded by n hops and a missing prime on a chased row is
detected; either sets a device `step5_error` flag, and the host aborts
with exit code 2 instead of hanging. With the atomic claim it must never
trigger.

## Verification

All 10 default-size tests (user_n=1000, n=1024) produce costs
1289 1189 1193 1167 1222 1269 1286 1187 1224 1218, which match an
independent O(n^3) Hungarian reference solver (JV/e-maxx formulation,
64-bit arithmetic) run on bit-identical matrices exactly (ALL MATCH).

- chipStar OpenCL on Intel UHD 770 (iGPU): `make smoke` rc=0 in 10.7 s.
- chipStar OpenCL on Intel CPU device: rc=0, identical costs.
- Intel Arc B570 (default device, chipStar 2026.07.20, OpenCL backend),
  2026-07-30 after the root-cause-3 fix: `make smoke` rc=0 in ~1.3 s,
  4 consecutive runs, identical optimal costs every time; no step_5a
  backstop trigger. (Before the fix the B570 hung inside step_5a.)

The SYCL variant (`hungarian-sycl`) kept the same in-kernel spins and the
same warp-synchronous reductions and still fails on Intel hardware; the
same two restructures apply.
