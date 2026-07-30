# bh-hip — FIXED (host-iterated tree build + drnd UB fix)

## Original failure (2026-06)

`make smoke` (`./main 100000 100`, Barnes-Hut N-body) hung indefinitely on
Intel Arc B570 / UHD 770 (OpenCL backend: TDR + `CL_OUT_OF_RESOURCES`;
Level Zero: indefinite hang). See git history of this file for the full
original analysis.

## Root causes (two, both benchmark-side)

1. **NaN bodies from `drnd()` signed-overflow UB** — `1103515245 * randx`
   overflows `int`; clang-22 `-O3` exploits the UB and the RNG returns
   *negative* draws, so `pow(negative, -2/3)` = NaN and ~half the bodies get
   NaN positions (36/64 at n=64). Two NaN bodies can never be separated by
   octree subdivision (`x < p.x` is always false), so the tree-building
   kernel's subdivision loop is *unconditionally infinite* — on any GPU where
   the compiler exploits the UB, independent of the lockstep-spin issue.
   The SYCL variant had already fixed this (`1103515245L`); the fix is
   mirrored here. The 64-bit product masked with `0x7FFFFFFF` produces the
   identical intended LCG sequence.

2. **In-kernel spin/retry constructs broken on lockstep SIMT** (the
   originally documented issue):
   - `TreeBuildingKernel`: losers of the child-slot `atomicCAS` lock retried
     without advancing while the lock owner shares their subgroup, plus a
     `__syncthreads()` inside a loop that threads exit at different times
     (divergent barrier).
   - `SummarizationKernel`: after 3 wait-free pre-passes, spun in-kernel
     until children's masses became ready (requires cross-workgroup
     co-residency).
   - `SortKernel`: spun until the parent published `startd[k]`, with another
     divergent `__syncthreads()`.

## Fix (2026-07-22)

All three convergence loops hoisted to the host, one bounded pass per kernel
launch, repeat flag (`d_repeat`) copied back per launch:

- **TreeBuildingKernel**: one bounded insertion attempt per still-pending
  body per launch (`d_inserted` tracks placed bodies). A lock winner always
  completes its subdivision and releases within the same launch (the new
  subtree is private until the release store, now preceded by
  `__threadfence()`), so no `-2` lock survives a launch boundary and every
  launch inserts at least one body. Livelock-free on lockstep hardware.
  Typical: ~11 launches/step at n=512, converging geometrically.
- **SummarizationKernel**: each launch is one wait-free pass (the original
  pre-pass body verbatim); unready cells set the repeat flag. Bottom-up
  progress guaranteed (deepest unready cell always has all children ready).
- **SortKernel**: each launch is one top-down pass; cells without a start
  index yet set the repeat flag; `d_sdone` marks processed cells.
  Divergent barrier removed.

Guard counters turn any non-convergence into a clean `exit(-1)` instead of a
GPU hang. Timing semantics preserved: the host loops sit inside the original
`gettimeofday` region.

## Verification

- `make smoke` (100000 bodies, 100 steps): rc=0, 23.05 s on UHD 770
  (chipStar 2026.07.20, OpenCL). The B570 was wedged by earlier spin-bench
  runs on this machine at the time of the fix (even a trivial 64-thread
  kernel hung on both backends before this rewrite was first executed), so
  the fix was validated on the UHD 770 — the same lockstep-SIMT class the
  original kernel hung on.
- Numerical check against an exact serial host reference (same float
  arithmetic incl. 32-lane warp-vote force walk): n=512/2 steps —
  4607/4608 printed values identical, worst |diff| 1e-6; n=2000/3 steps —
  17991/18000 identical, worst |diff| 1e-4, none outside 2% tolerance.
- DEBUG output: 0 NaN/inf.

## Related divergent-spinlock benches

- ans-hip, sad-hip, qtclustering-hip, wyllie-hip — same class
