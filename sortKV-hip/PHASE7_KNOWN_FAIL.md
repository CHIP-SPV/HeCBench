# sortKV-hip — BUILD_FAIL_THRUST_CPP_BACKEND

Build fails because the benchmark uses `THRUST_DEVICE_SYSTEM_CPP` which
chipStar's bundled Thrust does not support.

## Symptom

```
hipcc: error: expected a type (thrust/detail/type_traits.h:736:1)
hipcc: error: no template named 'invoke_result_t'; did you mean 'std::invoke_result_t'?
```

## Root cause

`sortKV-hip/Makefile` passes `-DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CPP`.
chipStar's bundled Thrust (HIP version) has `invoke_result_t` only defined
for HIP/CUDA backends; the CPP system path is missing the `#else` branch.
`trivial_copy.h` also uses `NV_IF_TARGET`/`NV_IS_HOST` macros which are
CUDA-only and unavailable in CPP mode.

Same root cause as `nosync-hip` and `coordinates-hip`.
