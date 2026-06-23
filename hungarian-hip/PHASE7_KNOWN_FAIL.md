# hungarian-hip — BENCH_SIDE_DIVERGENT_TERMINATION

`make smoke` hangs indefinitely on both OCL and L0 backends, even with
the smallest supported input (8×8 matrix).

## Symptom

```
./main 8 100
(kernel never completes, or loops indefinitely)
rc=124
```

## Root cause

The `step_2()` kernel uses a `do {} while (repeat)` loop where `repeat` is a
`__shared__` bool:

```c
do {
  __syncthreads();
  if (i == 0) repeat = false;
  __syncthreads();
  ...
  if (condition) {
    repeat = true;  // non-atomic write by any thread
  }
  __syncthreads();
} while (repeat);
```

`repeat` is written non-atomically by multiple threads. In CUDA, writes to
shared memory between two `__syncthreads()` barriers are safe because all
threads in the block see a consistent view of shared memory after a barrier.
On Intel GPU (chipStar OpenCL/L0 backend), `__syncthreads()` maps to
`barrier(CLK_LOCAL_MEM_FENCE)`, but convergence of the `while (repeat)`
condition after the barrier may not reflect all threads' writes, causing
infinite looping.

Also, the Hungarian algorithm steps are iterated host-side with `repeat_kernel`
as a global bool — device-to-host flag polling without explicit stream
synchronization.

The SYCL variant (`hungarian-sycl`) also fails identically on Intel hardware.
