# bn-hip — OCL_PARTIAL_FAIL (L0 passes)

`make smoke` fails on OpenCL backend with `CL_OUT_OF_RESOURCES` but
**passes on Level Zero**.

## Symptom

OCL:
```
clEnqueueSVMMemFill: CL_OUT_OF_RESOURCES
Aborted
rc=2
```

L0:
```
Initialization...
Average execution time of genScoreKernel: 1.813294 (s)
Find best graph time 0.489077 (s)
rc=0  (PASS)
```

## Root cause

The benchmark uses `clEnqueueSVMMemFill` (OpenCL SVM memory fill) which
fails with `CL_OUT_OF_RESOURCES` on the Intel Arc B570 OCL runtime.
This is a chipStar/Intel OCL SVM integration issue — the L0 backend uses
a different memory path and succeeds.

No fix possible at the benchmark level without restructuring SVM usage.
The benchmark is recorded as OCL=FAIL, L0=PASS.
