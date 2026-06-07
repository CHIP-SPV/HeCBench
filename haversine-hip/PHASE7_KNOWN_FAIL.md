# haversine-hip — BENCH_SIDE_REF_MISMATCH (+ teardown OOM)

## Symptom

`make smoke` runs the kernels successfully, prints a verification result
of "The maximum error in distance is 19692.39" (≈ 20 km), then exits with
SIGABRT from a `clFinish` `CL_OUT_OF_RESOURCES` at teardown.

## Root cause

1. Verification mismatch is bench-side. SYCL on the same input reports
   "The maximum error in distance is 19636.25 km" — essentially the same
   answer as chipStar. The bench's CPU `expected_output` array does not
   appear to be populated before the verify loop, so the very large error
   is an artefact of comparing GPU output against uninitialised memory.

2. Teardown `CL_OUT_OF_RESOURCES` on `clFinish` is the same family of
   chipStar OpenCL backend stress as `ans-hip` / `pad-hip` — the queue
   `finish()` errors out on the iGPU after a large workload completes.
   Not benign, but does not affect the kernel timing already printed.

## Status

- Bench-side verify is broken; not a chipStar correctness issue.
- The teardown OOM is a chipStar OpenCL backend / driver edge case worth
  filing once a minimal reproducer is isolated. Not addressed here.
