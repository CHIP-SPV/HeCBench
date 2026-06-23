# mis-hip — BENCH_SIDE_CUDA_MEMMODEL

`make smoke` hangs indefinitely (kernel never completes) on both OCL and L0 backends.

## Symptom

```
./main ../mis-cuda/internet.egr 1
(no output after 5s, timeout at 30s)
rc=124
```

## Root cause

The `findmins` kernel implements maximum independent set via a convergence loop
inside the GPU kernel:

```c
int missing;
do {
  missing = 0;
  for (int v = from; v < nodes; v += incr) {
    const stattype nv = nstat[v];   // volatile read
    ...
    nstat[nlist[i]] = out;           // volatile store (cross-thread write)
  }
} while (missing != 0);
```

`nstat` is `volatile stattype*` — threads read and write each other's entries
without any memory fence (`__threadfence`). On NVIDIA this works because CUDA
volatile semantics flush per-thread store buffers to L2, making stores visible
to all threads in the grid. Intel GPU (OpenCL/L0) does not provide this
guarantee: without an explicit `atomic_work_item_fence` or
`__threadfence_system`, a thread's stores may never become visible to other
threads' volatile reads, causing an infinite convergence loop.

This is an inherent CUDA memory model assumption; fixing it requires replacing
the volatile-based convergence with `__threadfence` + atomics, which would
change the algorithm non-trivially.

The SYCL variant (`mis-sycl`) fails identically on Intel hardware.
