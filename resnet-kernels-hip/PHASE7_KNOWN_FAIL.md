# resnet-kernels-hip — FIXED in chipStar 2026.06.23

`make smoke` now passes on both OCL and L0 backends (rc=0).

## Previous symptom

OCL: PASS
L0:
```
zeCommandListHostSynchronize: ZE_RESULT_ERROR_DEVICE_LOST
Aborted
rc=2
```

## Root cause (resolved)

The L0 `ZE_RESULT_ERROR_DEVICE_LOST` was caused by chipStar's L0 event
handling creating excessive immediate command lists per kernel submission,
overflowing the Intel Arc B570 driver's context limit.  Fixed in chipStar
by the shared immediate CL pool (`SharedImmCLs_` commit series, included in
the 2026.06.23 install).

## Current status

All 5 modes (0-4), both backends, rc=0:

| Backend | Mode 0 | Mode 1 | Mode 2 | Mode 3 | Mode 4 |
|---------|--------|--------|--------|--------|--------|
| L0      | PASS   | PASS   | PASS   | PASS   | PASS   |
| OCL     | PASS   | PASS   | PASS   | PASS   | PASS   |

Note: `./main <mode> 1` (smoke repeat=1) prints `[-0.000000 us]` timing
because the code averages over `(repeat-2)` runs, which is -1 for repeat=1.
Use repeat >= 3 for meaningful timing numbers.
