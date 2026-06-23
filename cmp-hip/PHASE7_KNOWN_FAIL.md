# cmp-hip — MISSING_DATA_FILE

`make smoke` fails because the required seismic data file is missing.

## Symptom

```
main: ../cmp-cuda/su_trace.cpp:38: bool su_trace::fgettr(std::ifstream &): Assertion `f != NULL' failed.
Aborted
```

## Root cause

The benchmark reads seismic survey data from a file (passed via stdin or
hardcoded path). The data file is not bundled in the HecBench repository.
The SEGY/SU seismic trace format file needs to be downloaded separately.

Same class of failure as `mpc-hip` (missing data file).
