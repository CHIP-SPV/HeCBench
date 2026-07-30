# gc-hip — BENCH_SIDE_DIVERGENT_SPINWAIT — FIXED

RESOLVED 2026-07-22: the convergence spins were hoisted to the host (see
"Fix" section at the bottom). `make smoke` now passes: rc=0, bench prints
PASS, 8 distinct colors on internet.egr, avg runtime 0.039 s/repeat.

Original analysis below.

`make smoke` hangs indefinitely on both OCL and L0 backends.

## Symptom

```
./main 100
(kernel never completes)
rc=124
```

## Root cause

The graph coloring kernels use `__ballot` in a spin-wait loop:

```c
int bal = __ballot(cond);
while (bal != 0) {
  const int who = __ffs(bal) - 1;
  bal &= bal - 1;
  ...
}
```

`__ballot` queries which threads in the warp satisfy a condition; `while (bal != 0)`
then iterates over those threads. On Intel GPU, threads in a "warp" (subgroup)
can diverge, and `__ballot` may not reflect cross-subgroup state, causing
the loop to never terminate.

Also contains: `} while (again)` where `again` depends on warp votes — same
class of divergent-termination problem.

This is a CUDA warp-execution model assumption that does not hold on Intel GPU.
The SYCL variant (`gc-sycl`) also fails identically.

## Fix (2026-07-22)

The `__ballot` bit-iteration loops (`while (bal != 0) { who = __ffs(bal)-1;
bal &= bal-1; ... }`) are actually bounded (each pass clears one bit of a
32-bit mask) and were kept unchanged. The real unbounded constructs were the
grid-wide convergence spins:

- `runLarge`: `do { ... } while (__any(again))` — repeats until *other*
  work-groups' `color[]` updates (read through `volatile`) let this warp's
  vertices finish. Requires whole-grid co-residency + cross-workgroup
  visibility while spinning.
- `runSmall`: `do { ... } while (again)` — same class, per-thread flag fed by
  `posscol[]` values other threads write concurrently.

Both loops were hoisted to the host: each kernel launch now performs one
sweep and sets a device `*again` flag; the host memsets the flag, launches,
copies the flag back (`hipMemcpy` D2H, synchronizing), and re-launches while
it is nonzero. Algorithm, timing scope (whole iterative phase inside the
`repeat` loop), and the bench's adjacency verification are unchanged. A
convergence-iteration cap (`nodes + 32`) aborts with exit(1) instead of
spinning forever if the algorithm ever fails to make progress.

`gc-sycl` kept the same in-kernel spin and would need the same restructure.
