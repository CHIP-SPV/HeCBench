# dxtc1-hip — BENCH_SIDE_REF_MISMATCH

`make smoke` reports `FAIL` because the bench's host/C++ reference for DXT1
compression does not agree with the GPU kernel output. The discrepancy is
not chipStar-specific: dxtc1-sycl (Intel DPC++) on the same data produces
the same magnitude of RMS error.

## Symptom

```
RMS(reference, result) = 1365.053101
FAIL
```

On the SYCL variant with identical args: `RMS = 1389.388306, FAIL`.

## Root cause

The bench's CPU reference path computes block-compressed values via a
different quantisation/dithering than the GPU kernel. Both stacks (chipStar
and Intel SYCL) produce close-to-identical GPU output (the two RMS values
differ by less than 2 %), so the FAIL reflects a stale reference rather
than a HIP/SYCL correctness bug.

## Status

- Not a chipStar bug.
- Fixing requires rewriting the host reference to match the kernel's
  quantisation, which is out of scope for HecBench triage.
