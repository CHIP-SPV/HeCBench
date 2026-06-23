# norm2-hip — CHIPSTAR_HIPBLAS_SNRM2_WRONG_RESULT

`make smoke` (hardcoded `CHIP_BE=level0`) runs but reports wrong numerical
results and then crashes with `ZE_RESULT_ERROR_DEVICE_LOST`.

## Symptom

```
./main 100
# elements = 256.00 M: hipblasSnrm2 = 23731us, 22.62 Gop/s
# elements = 512.00 M: hipblasSnrm2 = 47439us, 22.63 Gop/s
FAIL at iteration 0: gold=83542.335938 actual=83551.507812 for 536870912 elements
Error: zeCommandListHostSynchronize: ZE_RESULT_ERROR_DEVICE_LOST
Aborted
```

OCL backend also aborts (smoke target hardcodes `CHIP_BE=level0` but OCL
produces the same DEVICE_LOST after the wrong result).

## Root cause

`hipblasSnrm2` (Euclidean norm reduction) in chipStar's hipBLAS implementation
produces numerically incorrect results for large element counts (512M elements).
The error margin (83542 vs 83551) is 0.01% — likely a floating-point
reduction ordering issue specific to Intel GPU's execution model.

After reporting the wrong result, the benchmark aborts (`exit(1)`), which
causes `zeCommandListHostSynchronize` to return `DEVICE_LOST` as the command
list is torn down mid-execution.

The smoke target hardcodes `CHIP_BE=level0` (`$(LAUNCHER)` not prepended),
so switching backends requires modifying the Makefile.
