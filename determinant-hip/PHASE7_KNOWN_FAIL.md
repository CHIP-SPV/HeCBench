# determinant-hip — BUILD_FAIL_THRUST_CPP_BACKEND

Build fails because the benchmark uses `THRUST_DEVICE_SYSTEM_CPP` which
chipStar's bundled Thrust does not support.

## Symptom

```
thrust/detail/type_traits.h:736:1: error: expected a type
thrust/detail/type_traits.h:725:24: error: expected ';' after alias declaration
```

## Root cause

Same as `nosync-hip`, `coordinates-hip`, `sortKV-hip`, `kurtosis-hip`,
`remap-hip`, `scan3-hip`, `segment-reduce-hip`: uses Thrust with
`THRUST_DEVICE_SYSTEM_CPP` which is not supported by chipStar's Thrust.
