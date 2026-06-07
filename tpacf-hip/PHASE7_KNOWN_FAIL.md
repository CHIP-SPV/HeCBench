# tpacf-hip — DATA_MISSING (silently runs on empty input)

`make smoke` exits with status 0 but is computing on **empty** input
because the upstream dataset is missing. The kernel timings and bin
output that get printed are not a meaningful result.

## Symptom

```
Unable to open data file ../tpacf-cuda/data/small/Datapnts.1 for reading
Unable to open data file ../tpacf-cuda/data/small/Randompnts.1 for reading
...
data file: ../tpacf-cuda/data/small/Datapnts.1
number of data points: 4096        <-- requested, but file did not exist
...
Time to load data files: 0.0001 sec  <-- because there was nothing to load
DONE! after 7.314665
```

Exit status is 0; an automated sweep that looks only at the exit code
counts this as PASS.

## Root cause

The benchmark requires astronomical datapoints distributed as a separate
tarball. Per `tpacf-cuda/README`:

> Before running the program, the dataset must be downloaded from
> https://users.ncsa.illinois.edu/kindr/projects/hpca/files/data.tgz

That URL is no longer serving the dataset (returns an HTML page rather
than the tarball — checked 2026-06-07).

The bench's `read_datafile()` warns on open-failure but does not abort;
the subsequent kernels run on whatever was in the buffers, which is why
the program completes cleanly with garbage results.

## Status

- Not a chipStar or HIP-source bug.
- Real fix needs either a working mirror of the dataset, or an `abort()`
  in `read_datafile()` on missing input so the failure is visible.
