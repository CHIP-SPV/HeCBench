# zerocopy-hip — CHIPSTAR_HIPHOST_MALLOC_MAPPED

`make smoke` hangs on both backends. OCL never produces any output.
L0 shows `zeEventQueryStatus took 37832us, exceeded 100us threshold` and
times out.

## Symptom

OCL:
```
./main 10
(no output after 5s, timeout at 30s)
rc=124
```

L0:
```
./main 10
CHIP warning: zeEventQueryStatus took 37832us, exceeded 100us threshold
(repeats indefinitely, times out)
rc=124
```

## Root cause

The benchmark uses `hipHostMalloc` with `hipHostMallocMapped` flag for
zero-copy (host-mapped) memory:

```c
hipHostMalloc((void **)&a, bytes, hipHostMallocMapped);
```

On Intel Arc B570 with chipStar:
- OCL backend: `hipHostMalloc` with mapped flag hangs during allocation or
  the subsequent kernel launch.
- L0 backend: `zeEventQueryStatus` polling takes ~38ms per call instead of
  the expected <100µs, causing the event wait loop to run indefinitely.

The L0 event polling slowness is consistent with the B570 BCS (blitter engine)
wedge issue. Zero-copy memory on B570 may require the BCS engine.
