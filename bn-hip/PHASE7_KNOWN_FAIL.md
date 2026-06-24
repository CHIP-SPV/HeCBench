# bn-hip — OCL_PARTIAL_FAIL (L0 passes)

`make smoke` fails on OpenCL backend but **passes on Level Zero**.

## Symptom before fix

OCL (SIGABRT, rc=134):
```
clEnqueueSVMMemFill: CL_OUT_OF_RESOURCES → std::abort()
```

OCL (after chipStar error-table fix, rc=124 timeout):
```
CHIP error: hipErrorOutOfMemory (CL_OUT_OF_RESOURCES) in finish
[loops indefinitely ~every 500ms repeating this error]
```

L0:
```
Initialization...
Average execution time of genScoreKernel: 1.813294 (s)
Find best graph time 0.489077 (s)
rc=0  (PASS)
```

## Root cause

Two issues interact:

**1. chipStar missing error-table entries (fixed in 2026-06-24-chipstar-ocl-svm-memcpy-fix)**

`clEnqueueSVMMemFill`, `clSetKernelArg`, `clEnqueueMarker`, and
`clEnqueueMarkerWithWaitList` lacked `CL_OUT_OF_RESOURCES` entries in the
OCL error-conversion table.  When the Intel Arc B570 driver returned that
error, `CHIPERR_CHECK_LOG_AND_THROW_TABLE` mapped it to `hipErrorTbd`,
which unconditionally called `std::abort()`.  Fixed: all four functions now
map `CL_OUT_OF_RESOURCES` to `hipErrorOutOfMemory` so callers receive a
proper throw instead of an abort.

**2. Intel Arc B570 OCL driver — permanent GPU error state after complex kernels (bench-side / driver bug)**

After `genScoreKernel` (1.84 s, writes ~26 MB SVM on every invocation),
the Intel Arc B570 OCL driver enters a permanent GPU-level error state: ALL
subsequent OpenCL commands — on the same queue OR on newly-created
replacement queues — return `CL_OUT_OF_RESOURCES`.  The only recovery is
process exit.  This is reproducible on L0/SYCL with the equivalent kernel
and is an Intel driver bug, not chipStar.

`bn-hip` ignores all HIP error return codes, so after the abort fix it
loops forever through 100 × 45 graph iterations printing the error every
~500 ms until `timeout` sends SIGTERM.

## chipStar fixes applied

Worktree: `2026-06-24-chipstar-ocl-svm-memcpy-fix`

- `clHipErrorConversion.hh`: added `CL_OUT_OF_RESOURCES` to all four missing entries
- `CHIPBackendOpenCL.cc`: IntelUSM staging buffer for D2H/H2D to unregistered host ptrs
- `CHIPBackendOpenCL.cc`: `recreateQueues()` after `clFinish → CL_OUT_OF_RESOURCES`
- Regression test: `TestFixSVMMemcpyToHostPtr.hip`

These fixes prevent abort (rc=134) and convert the Intel driver bug into a
recoverable error for benchmarks that check return codes.  bn-hip itself
remains a BENCH_SIDE fail on OCL (driver bug + benchmark ignores errors).

## Status

| Backend | Result | Reason |
|---------|--------|--------|
| OCL     | FAIL   | Intel Arc B570 driver GPU error state after genScoreKernel |
| L0      | PASS   | Uses different memory path; not affected |
