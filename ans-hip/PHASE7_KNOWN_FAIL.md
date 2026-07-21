# ans-hip — FIXED (chipStar 2026.07.20)

`make smoke` (`./bin/main 1`) now builds and runs rc=0 on both OpenCL and Level
Zero (~0.5s, "Total elapsed time" prints; verified 3/3 consecutive runs, no
errors). The failure below no longer reproduces on chipStar 2026.07.20.

## Was (CL_OUT_OF_RESOURCES / DEVICE_LOST)

```
CHIP error: hipErrorOutOfMemory (CL_OUT_OF_RESOURCES) in CHIPBackendOpenCL.cc:2060:finish
0.1  Error: clSetKernelArg returns CL_OUT_OF_RESOURCES at CHIPBackendOpenCL.cc:2441
```
On Level Zero: `ZE_RESULT_ERROR_DEVICE_LOST` then `ZE_RESULT_ERROR_OUT_OF_DEVICE_MEMORY`.

`phase1_decode_subseq` (kernels_compact_storage.h) inlines the ANS decoder four
times inside a loop, keeping very large per-thread state. The SPIR-V compiled and
passed discovery, but at launch (`<<<num_sequences, 128>>>`) Intel IGC/NEO
allocated per-thread private-memory backing for the spilled state that exceeded
device limits, and the next queue op failed with CL_OUT_OF_RESOURCES / DEVICE_LOST.

## What fixed it

Resolved in the chipStar/IGC toolchain by 2026.07.20 — the high-register-spill
kernel now launches fine on both backends. **Not** the NEO debug-key issue that
affected bn-hip: re-running with `CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1` (which
re-enables `NEOReadDebugKeys`) still passes, so the debug-key mode is ruled out.
The exact fix (IGC codegen reducing the spill, a driver update handling the
private-memory backing, or a chipStar launch/codegen change) was not bisected;
empirically the register-pressure launch failure is gone. Pinpointing the precise
commit would need install-by-install bisection and is not needed now that it works.
