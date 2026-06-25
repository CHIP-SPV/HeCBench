# bn-hip — FIXED (Makefile shipped with OPTIMIZE = no)

`make smoke` failed on the OpenCL backend until the Makefile's
`OPTIMIZE = no` was changed to `OPTIMIZE = yes`. One-line bench-side fix; no
chipStar change required.

## Symptom (before fix)

OCL, default backend, deterministic 5/5:
```
NODE_N=45
Average execution time of genScoreKernel: 1.82 (s)
hipErrorOutOfMemory (CL_OUT_OF_RESOURCES) in ...CHIPBackendOpenCL.cc:finish
clEnqueueSVMMemFill: CL_OUT_OF_RESOURCES
Aborted (rc=134)
```
L0 passed (its kernel-submit path tolerates the longer-running kernel).

## Root cause

bn-hip's Makefile shipped with `OPTIMIZE = no` (line 7), so `main.cu` was
compiled at `-O0`. At `-O0` chipStar does not inline the HIP device-library
helpers into the kernel, so `genScoreKernel` — a heavy kernel (45 nodes x
combinatorial inner loops x DATA_N=600) — runs about **2x slower (~1.8 s vs
~0.97 s)**. At ~1.8 s a single launch exceeds the Intel Arc B570 GPU
hang-check (TDR) window; the driver returns `CL_OUT_OF_RESOURCES` from
`clFinish`, poisons the queue, and the next `clEnqueueSVMMemFill` also fails.

It is **not** an OCL runtime bug: the device image is 37,132 B at `-O0`
(helpers called) vs 48,548 B at `-O3` (helpers inlined). Pass/fail tracks the
compiled kernel's runtime against the hang-check threshold, nothing else.

`bn-hip` was one of only 5 of 1595 HecBench Makefiles shipping `OPTIMIZE =
no` (the standard default is `yes`) — an upstream anomaly. A perf benchmark
built unoptimized is not meaningful anyway.

### Ruled out (controlled experiments)

- **Not the OCL memcpy/SVM path.** Hot-swapping libCHIP under a fixed binary
  changed nothing; kernel time tracks the binary, not the runtime.
- **Not the chipStar version.** With `-O3`, bn-hip passes on both the
  2026.06.23 and a freshly built 2026.06.25 install.
- **Not `-c` separate compilation.** Single-step and separate compile both
  pass at `-O3` and both fail at `-O0`.
- **Not thermal/order/module-cache.** Alternating A/B and cache clears
  reproduced the split cleanly along `-O0` vs `-O3`.

## Fix

`Makefile`: `OPTIMIZE = no` -> `OPTIMIZE = yes`.

## Verification

| Build | backend | kernel | result |
|-------|---------|--------|--------|
| OPTIMIZE=no  (-O0) | OCL | ~1.82 s | FAIL (TDR), 5/5 |
| OPTIMIZE=yes (-O3) | OCL | ~0.97 s | PASS, 5/5 |
| OPTIMIZE=yes (-O3) | L0  | ~0.97 s | PASS, 2/2 |

Confirmed on both chipStar 2026.06.23 and 2026.06.25.

## Related

frechet-hip also ships `OPTIMIZE = no`; its IGC JIT crash may share this
root cause (unoptimized device code). Worth re-checking with `OPTIMIZE = yes`.
