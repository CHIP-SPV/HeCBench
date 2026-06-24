# laplace-hip — BENCH_SIDE FAIL (CPU reference loop too slow)

`make smoke` times out on all backends. **Not a chipStar bug.**

## Symptom

```
./main
...
Total time for 27121 iterations: 2.244 s
(no further output — killed after timeout)
rc=124
```

## Root cause

The benchmark has two phases:

1. **GPU SOR loop** — converges in 2.25 s (27121 iterations, 1024×1024 grid).
   `hipcub::DeviceReduce::Sum` works correctly on chipStar (OCL and L0).
   D2H copies of `temp_red`/`temp_black` (~2 MB each) complete normally.

2. **CPU reference loop** — identical SOR algorithm running single-threaded
   on CPU, up to `it_max = 1000000` iterations.  Needs the same ~27121
   iterations to converge but at CPU speed (~96% of one core, no SIMD).
   Estimated runtime: **5–15 minutes**.  Any test timeout <= 5 min kills the
   process during this phase.

Process state during post-GPU hang: `wchan=0, State=R, %CPU=96.1`.
This is pure userspace computation, not any blocked GPU or chipStar call.

## Original misdiagnosis

Prior PHASE7 entry: "hipcub DeviceReduce::Sum kernel hangs".

This was wrong in two ways:
- `stdout` is fully buffered when redirected to a file; all 27000 iteration
  print lines are lost when the process is killed.  With `stdbuf -oL`, the
  full convergence output appears, confirming the GPU phase works normally.
- The actual slow path is the CPU reference loop, not any GPU kernel.

## Verification

```bash
# Shows full GPU convergence output — hipcub works correctly:
CHIP_LOGLEVEL=err stdbuf -oL timeout 30 ./main

# Process state immediately after GPU phase:
# wchan=0 (user-space), State=R, %CPU=96.1 -- running CPU reference loop
```

## Status

| Backend | Result | Reason |
|---------|--------|--------|
| OCL | FAIL (rc=124) | CPU reference loop: ~27121 SOR iterations on 1024x1024 CPU grid |
| L0  | FAIL (rc=124) | Same -- CPU phase is independent of GPU backend |

chipStar fix required: **none**.  The benchmark verification loop is too slow
for the problem size (NUM=1024, it_max=1e6) with any realistic smoke timeout.
