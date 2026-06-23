# assert-hip — CHIPSTAR_DEVICE_ASSERT

`make smoke` hangs indefinitely on both OCL and L0 backends.

The benchmark is designed to trigger a device-side `assert()` failure and
expects a non-zero exit code (`! ./main` in the smoke target). However,
chipStar fails to compile the kernel due to a missing SPIR-V extension,
then hangs rather than returning an error.

## Symptom

```
./main
Launch kernel to evaluate the impact of assertion on performance
Each thread in the kernel executes threadID + 1 assertions
InvalidModule: Invalid SPIR-V module: input SPIR-V module uses extension
'SPV_EXT_relaxed_printf_string_address_space' which were disabled by --spirv-ext option
CHIP error: Program build failed.
(hangs indefinitely — never exits)
rc=124 (timeout)
```

## Root cause

Device `assert()` in CUDA lowers to a call that uses a string literal
(the assertion message) which requires `SPV_EXT_relaxed_printf_string_address_space`
to represent in SPIR-V. chipStar disables this extension, so the module is
rejected at runtime. Instead of cleanly returning an error, the program hangs
after the build failure.

Two issues:
1. chipStar does not support `SPV_EXT_relaxed_printf_string_address_space`
2. After `hipErrorNotInitialized` from `compile()`, the program should abort
   but instead hangs (chipStar bug — unhandled error path after failed JIT compile)
