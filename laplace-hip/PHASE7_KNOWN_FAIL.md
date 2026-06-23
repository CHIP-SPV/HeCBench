# laplace-hip — CHIPSTAR_HIPCUB_HANG

`make smoke` hangs immediately on both OCL and L0 backends (0 output lines after 60s).

## Symptom

```
./main 32 32 10
(no output, kernel never returns)
rc=124
```

## Root cause

The benchmark calls `hipcub::DeviceReduce::Sum` for L2 norm reduction
after each Laplacian iteration. On chipStar (both OCL and L0 backends),
the hipcub `DeviceReduce::Sum` kernel hangs indefinitely.

This is a chipStar/hipcub integration issue, not a benchmark code defect.
Other benchmarks that use `hipcub::DeviceScan`, `hipcub::BlockReduce`,
etc. may be affected similarly.
