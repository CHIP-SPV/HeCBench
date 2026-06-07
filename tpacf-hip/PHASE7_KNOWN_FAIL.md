# tpacf-hip — DATA_MISSING

`make smoke` cannot run because the input data is not available.

## Symptom

```
Unable to open data file ../tpacf-cuda/data/small/Datapnts.1 for reading
CHIP error: Caught Error: hipErrorNotInitialized
```

## Root cause

The benchmark requires astronomical datapoints distributed as a separate
tarball. Per `tpacf-cuda/README`:

> Before running the program, the dataset must be downloaded from
> https://users.ncsa.illinois.edu/kindr/projects/hpca/files/data.tgz

That URL is no longer serving the dataset (returns an HTML error / redirect
page, not the tarball — checked 2026-06-07).

## Status

- Not a chipStar or HIP-source issue.
- No alternative public host has been identified.
- Skip in any HecBench triage until the dataset is mirrored somewhere
  reachable.
