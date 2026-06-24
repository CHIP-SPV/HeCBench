# norm2-hip — BENCH_SIDE FAIL (oneMKL float32 nrm2 precision at 512M elements)

`make smoke` fails with wrong numerical result at n=512M (536870912) elements,
then crashes with `ZE_RESULT_ERROR_DEVICE_LOST` on L0.

## Symptom

```
./main 1
# elements = 256.00 M: ... 20.00 Gop/s    (PASS)
# elements = 512.00 M: ... 20.25 Gop/s
FAIL at iteration 0: gold=83542.335938 actual=83556.312500 for 536870912 elements
```

L0 (100 repeats, from smoke):
```
FAIL at iteration 0: gold=83542.335938 actual=83551.507812 for 536870912 elements
Error: zeCommandListHostSynchronize: ZE_RESULT_ERROR_DEVICE_LOST
Aborted
```

## Root cause

`hipblasSnrm2` routes through oneMKL's `mkl::blas::column_major::nrm2`.  For
n=512M (= 536870912) float32 elements, oneMKL produces a result that differs
from the double-precision reference by ~9–14.  The benchmark tolerance is 8.45
(`1e-4 * 83542 + 0.1`), so the test fails.

The SYCL version (`norm2-sycl`) calling `mkl::blas::column_major::nrm2` directly
also fails with the **identical result** (83551.507812):

```
#elements = 512.00 M: 22.61 Gop/s
FAIL at iteration 0: gold=83542.335938 actual=83551.507812 for 536870912 elements
```

This confirms the issue is in oneMKL's float32 nrm2 algorithm on Intel Arc B570,
not in chipStar's hipBLAS wrapper.

## Why the error is larger than expected

For n=512M elements with values a[i]=(i+1)%7 (range 0-6), sum-of-squares ≈ 6.979B.
The theoretical minimum float32 tree-reduction error is ~0.14 in the norm, but
oneMKL's internal algorithm accumulates ~9–14 (100x the theoretical bound).
The specific summation order in oneMKL's GPU kernel has sub-optimal floating-point
properties for this input pattern and size.

## DEVICE_LOST

After the wrong result, the benchmark calls `exit(1)`, which tears down L0
command lists mid-execution → `zeCommandListHostSynchronize` returns
`ZE_RESULT_ERROR_DEVICE_LOST`.  This is a secondary consequence, not the root cause.

## Status

| Backend | Result | Reason |
|---------|--------|--------|
| L0  | FAIL | oneMKL nrm2 precision + exit(1) → DEVICE_LOST |
| OCL | FAIL | oneMKL nrm2 precision (same algorithm) |

chipStar fix required: **none**.  The bug is in oneMKL's float32 nrm2 algorithm
on Intel Arc; the benchmark tolerance is too tight for this problem size on Intel hardware.
