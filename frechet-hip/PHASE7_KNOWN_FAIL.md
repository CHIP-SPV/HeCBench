# frechet-hip — CHIPSTAR_PROGRAM_BUILD_FAIL_CRASH — FIXED

RESOLVED 2026-07-30: the memoized recursive `__device__` DP was rewritten
iteratively (bottom-up) in the shared `../frechet-cuda/norm{1,2,3}.h`
headers. `make smoke` now passes on both OCL and L0: rc=0, and all three
checkSum values (107113.842791 / 1311.516599 / 31.849837 for 4 4 1000)
match an independent host-side DP reference exactly.

Original analysis below.

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

The kernels called `recursive_norm{1,2,3}`, a multi-way memoized recursive
`__device__` function (up to 3 self-calls per branch, memoized through
global memory). Device-side recursion is not legal OpenCL/SPIR-V, and
Intel IGC crashes on it ("Internal Compiler Error: Segmentation
violation") at any -O level — chipStar issue #1362 covers chipStar
segfaulting instead of returning the JIT build error.

## Fix (2026-07-30)

The discrete Frechet DP has a natural bottom-up formulation:

```
ca[i][j] = max(dist(i,j), min(ca[i-1][j], ca[i-1][j-1], ca[i][j-1]))
```

Each thread (i, j) now fills its prefix rectangle [1..i] x [1..j] of the
shared `ca` table in row-major order — no recursion, no memo checks. A
thread only ever reads cells it has already written itself, and every
thread computes identical values from identical inputs, so concurrent
stores to a cell always carry the same value (same benign-overlap
character as the original memo table, minus the memo-check races).
Norm semantics (1/2/3), kernel launch geometry, and output values are
unchanged. The iterative form is the correct portable shape, not a
workaround: the CUDA variant shares the same headers and benefits
equally.
