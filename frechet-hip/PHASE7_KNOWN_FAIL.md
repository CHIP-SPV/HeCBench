# frechet-hip — CHIPSTAR_PROGRAM_BUILD_FAIL_CRASH

`make smoke` exits with segfault (rc=139) on both OCL and L0.
OCL backend logs `Program build failed` then segfaults.

## Symptom

```
./main 4 4 1000
CHIP error: Program build failed (hipErrorNotInitialized)
Segmentation fault (core dumped)
rc=139
```

## Root cause

chipStar fails to compile the kernel JIT and then crashes (segfault) instead
of returning an error. The root cause of the JIT compilation failure is unknown
— likely an unsupported language feature or intrinsic in the kernel.

This is a chipStar bug (should return an error, not segfault).
