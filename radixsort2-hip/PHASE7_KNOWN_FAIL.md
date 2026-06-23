# radixsort2-hip — BUILD_FAIL_CUB_MISSING

Build fails because the benchmark includes CUB headers from the system CUDA
installation which are not present.

## Symptom

```
/usr/include/thrust/system/cuda/config.h:42:10: fatal error: 'cub/util_namespace.cuh' file not found
```

## Root cause

The benchmark's `main.cu` pulls in CUDA system headers that require CUB
(CUDA Unbound). CUB is part of CUDA Toolkit and is not available in the
chipStar/LLVM environment. Same class of failure as `minmax-hip`, `mtf-hip`,
`warpselect-hip`.
