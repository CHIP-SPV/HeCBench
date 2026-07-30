# mis-hip — FIXED (was BENCH_SIDE_CUDA_MEMMODEL)

Previously `make smoke` hung indefinitely (kernel never completed) on both OCL
and L0 backends. Fixed 2026-07-22 by restructuring the convergence loop to the
host; see "Fix" below.

## Original symptom

```
./main ../mis-cuda/internet.egr 1
(no output after 5s, timeout at 30s)
rc=124
```

## Root cause

The `findmins` kernel implemented maximal independent set via a convergence
loop inside the GPU kernel:

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

The SYCL variant (`mis-sycl`) kept the identical in-kernel spin and fails
identically on Intel hardware.

## Fix

Hoisted the convergence loop to the host: `findmins` now performs a single
grid-strided pass per launch and raises a device-side `missing` flag if any
undecided node remains; the host clears the flag (`hipMemset`), launches the
kernel, copies the flag back (`hipMemcpy`, which synchronizes), and relaunches
until the flag stays 0. Kernel-launch boundaries guarantee global-memory
visibility, which is all the ECL-MIS priority-selection algorithm needs — the
per-pass selection logic and the bench's verification are unchanged.

On `internet.egr` (124651 nodes, 387240 edges) convergence takes 4 host-loop
passes. `make smoke` (repeat=100):

```
compute time: 0.000417 s
throughput: 299.030220 Mnodes/s
throughput: 928.965370 Medges/s
PASS
```

rc=0, no verification errors. (A `PASS`/`FAIL` summary print was added after
the pre-existing verification loop, which previously computed `err` but never
reported it.)
