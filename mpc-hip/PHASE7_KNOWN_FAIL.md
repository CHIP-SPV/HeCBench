# mpc-hip — MISSING_DATA_FILE

`make run` fails immediately because the required input trace file is missing.

## Symptom

```
./main ../mpc-cuda/msg_sp.trace.out 1
main: ../mpc-cuda/utils.h:3: long *readFile(const char *, int &): Assertion `f != NULL' failed.
Aborted
```

## Root cause

The benchmark requires `../mpc-cuda/msg_sp.trace.out` — a communication
trace file for the MPC (Multi-Party Computation) algorithm. This file is
not bundled in the HecBench repository (it's a large binary dataset).

No smoke target can be added without the data file. The benchmark is
functionally correct but requires the dataset to be downloaded separately.
