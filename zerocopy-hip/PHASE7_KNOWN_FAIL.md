# zerocopy-hip — BENCH_SIDE FIX (smoke repeat count reduced)

`make smoke` was timing out (rc=124) because the original target ran `./main 10`
(10 repeats × 4 eval paths × 7 vector sizes up to 64M elements = ~5 minutes).

## Root cause

The smoke target used `./main 10` which runs 10 kernel repeats per size.  The
largest size (67M float elements × 3 arrays = ~768 MB mapped memory) takes ~1s
per kernel call on Intel Arc B570 via zero-copy.  With 4 eval paths and 10
repeats, the 64M element case alone requires ~40s.  Total smoke time: ~5 minutes,
well over the 60s limit.

This is not a chipStar bug. Both `hipHostMalloc(hipHostMallocMapped)` and
`hipHostRegister(hipHostRegisterMapped)` work correctly on OCL and L0.

## Previous misdiagnosis

The prior analysis assumed OCL hangs and L0 event-polling stalls.  Both were
artifacts of the 30s timeout catching the benchmark mid-run.  With stdbuf line
buffering, the OCL output appears normally; `zeEventQueryStatus` warnings are
benign slow-poll messages that don't prevent completion.

## Fix

Changed smoke target from `./main 10` to `./main 1` (1 repeat instead of 10).

With 1 repeat:
- All 7 vector sizes (1M–64M), both memory modes (hipHostMalloc + hipHostRegister)
  all complete with SUCCESS
- Total runtime: ~32 seconds on Intel Arc B570 (fits within 60s smoke limit)
- rc=0

## Verification

```
$ time ./main 1
> Using Host Allocated (hipHostMalloc)
Warmup...
SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS
Done.
...
SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS
real  0m32.399s
rc=0
```
