# gc-hip — BENCH_SIDE_DIVERGENT_SPINWAIT

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
