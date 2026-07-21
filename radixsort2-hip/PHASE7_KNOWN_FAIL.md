# radixsort2-hip — FIXED (rocThrust HIP backend)

`make smoke` builds and runs rc=0 on chipStar 2026.07.20.

## Was (BUILD_FAIL)

The Makefile forced `-DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CPP`, a legacy
workaround for "thrust CUDA backend needs CUB, which is unavailable." But
rocThrust's inherited CPP (host-sequential) backend is unported and does not
compile: `invoke_result_t` is defined only for the HIP/CUDA branches (no
`#else` for CPP), and the sequential copy path uses undefined NVIDIA
`NV_IS_HOST`/`NV_IS_DEVICE` macros.

```
thrust/detail/type_traits.h:725:24: error: expected ';' after alias declaration
thrust/system/detail/sequential/trivial_copy.h:47: use of undeclared identifier 'NV_IS_HOST'
```

## Fix

chipStar 2026.07.20 ships rocThrust with a real HIP device backend (→ rocPRIM),
so the Makefile now selects `-DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP` and
runs the `thrust::sort` / `sort_by_key` on the GPU — matching the SYCL variant's `make_device_policy`. It
also pins chipStar's rocThrust ahead of the apt `/usr/include/thrust` shadow
(upstream NVIDIA thrust, no HIP backend) via `-isystem $(CHIPSTAR_ROOT)/include`.
Commit f14a3a00e.

Note: the earlier "cub/util_namespace.cuh not found" symptom was the same
`/usr/include/thrust` shadow (the apt thrust defaulting to the CUDA backend),
resolved by the `-isystem` pin. A smoke target and an exit-code fix
(`exit(bTestResult?0:1)`) were also added (commits f5857cf20, fdcfc22b7).
