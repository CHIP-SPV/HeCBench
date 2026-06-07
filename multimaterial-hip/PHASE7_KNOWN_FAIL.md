# multimaterial-hip — BENCH_SIDE_VERIFY_FAIL

## Symptom

`make smoke` (`./multimat_FL 1000 1000 0.3 0.05 0.05`) builds and runs all
three algorithms cleanly, prints kernel timings, then fails verification:

```
Checking results of compact representation... 3. full matrix and compact
cell-centric values are not equal! (0.000000, inf, 64, 0, 2)
```

## Root cause

Bench-side. multimaterial-sycl (Intel DPC++) on the same args produces an
analogous error: `(inf, 0.000000, 1, 1, 2)`. Both stacks complete the
kernels and disagree with the reference in the same way (one of the
values is `inf`), so the verifier is comparing against a malformed
"expected" computation rather than detecting a HIP/SYCL miscompile.

## Status

- Not a chipStar bug. SYCL fails identically.
- Fix requires investigating the bench's reference computation (likely an
  uninitialised cell or division-by-zero in the compact-storage path) —
  out of scope for HecBench triage.
