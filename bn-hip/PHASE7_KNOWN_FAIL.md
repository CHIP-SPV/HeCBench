# bn-hip — FIXED (chipStar OCL fix + Makefile OPTIMIZE)

`make smoke` passes on OCL and L0 at both `OPTIMIZE=yes` and `OPTIMIZE=no`.
Two independent issues were involved; the root chipStar bug is now fixed.

## Symptom (before fix)

OCL, `OPTIMIZE=no` (-O0), deterministic:
```
Average execution time of genScoreKernel: 1.8 (s)
hipErrorOutOfMemory (CL_OUT_OF_RESOURCES) in CHIPBackendOpenCL.cc:finish
clEnqueueSVMMemFill: CL_OUT_OF_RESOURCES
Aborted (rc=134)
```
L0 passed; `OPTIMIZE=yes` (-O3) passed.

## Root cause (chipStar OCL backend)

chipStar's large-allocation workaround set, unconditionally at library load:
```
setenv("NEOReadDebugKeys", "1");
setenv("AllowUnrestrictedSize", "1");
```
to permit >4 GiB single OpenCL allocations. But **`NEOReadDebugKeys=1`
switches the Intel NEO OpenCL driver into debug-key mode globally**, which
makes high register-pressure / high-scratch kernels — notably unoptimized
`-O0` kernels like bn-hip's `genScoreKernel`/`computeKernel` — fail at
execution with `CL_OUT_OF_RESOURCES`, even though they run correctly without
it. `OPTIMIZE=yes` (-O3) produced a lighter kernel that stayed under the
threshold, which is why only `-O0` failed; L0 was unaffected (these keys are
NEO/OpenCL-only).

### How it was isolated

The exact processed SPIR-V chipStar feeds the driver (`CHIP_DUMP_PROCESSED_SPIRV`)
was run through **pure OpenCL** (cl_mem and Intel USM, repeated launches +
memfills) — all passed. So neither the kernel, the driver, nor chipStar's
memcpy/memfill path was at fault. A controlled libCHIP swap and a source diff
narrowed it to these two setenv calls; toggling
`CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1` (which re-enables the keys) reproduces
the failure on demand. See `reproducer/scratch-driver/`.

## chipStar fix

`src/CHIPDriver.cc`: the NEO debug-key escalation is now **opt-in** via
`CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1` (default off). High-footprint kernels are
far more common than >4 GiB single OpenCL allocations; Level Zero large
allocations use `ze_relaxed_allocation_limits` and are unaffected.

## Bench-side fix (separate, still correct)

`Makefile`: `OPTIMIZE = no -> yes`. bn-hip was 1 of only 5/1595 HecBench
Makefiles shipping `OPTIMIZE=no`; a perf benchmark should build optimized.
This is independent of the chipStar fix and remains the right default.

## Verification

| Build | backend | result |
|-------|---------|--------|
| OPTIMIZE=yes (-O3) | OCL | PASS (~0.97s) |
| OPTIMIZE=yes (-O3) | L0  | PASS |
| OPTIMIZE=no  (-O0) | OCL | PASS (5/5, after chipStar fix) |
| OPTIMIZE=no  (-O0) | L0  | PASS |

OCL `-O0` results (score -11080.462891) match the L0 oracle exactly.
Confirmed on chipStar 2026.06.25 (with the CHIPDriver.cc fix).
