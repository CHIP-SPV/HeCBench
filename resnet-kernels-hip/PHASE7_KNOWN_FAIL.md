# resnet-kernels-hip — L0_DEVICE_LOST (OCL passes)

`make smoke` fails on L0 backend with `ZE_RESULT_ERROR_DEVICE_LOST`.
OpenCL backend PASSES.

## Symptom

OCL: PASS

L0:
```
zeCommandListHostSynchronize: ZE_RESULT_ERROR_DEVICE_LOST
Aborted
rc=2
```

## Root cause

Unknown. One of the ResNet convolution kernels triggers an L0 device reset
on Intel Arc B570. OCL executes the same kernels correctly.

This is a chipStar/L0 backend issue affecting this specific kernel workload.
