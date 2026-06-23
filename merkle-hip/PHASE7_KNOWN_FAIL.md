# merkle-hip — CHIPSTAR_UMUL64HI_HANG

`make smoke` hangs immediately on both OCL and L0 backends, even with the
smallest DEBUG build (256 leaves, 1 round).

## Symptom

```
./main           # debug binary (256 leaves)
Merklize ( approach 1 ) using Rescue Prime on F(2**64 - 2**32 + 1) elements
      leaves             total
(hangs here indefinitely)
rc=124
```

## Root cause

The `rescue_prime.cu` kernels perform finite-field arithmetic over
`F(2^64 - 2^32 + 1)` using `__umul64hi` for 64-bit multiply-high operations:

```c
inline __device__ ulong4 mul_hi(const ulong4 &a, const ulong4 &b) {
  return { __umul64hi(a.x, b.x), ... };
}
```

`__umul64hi` may not be available or correctly lowered in chipStar's
SPIR-V translation on Intel GPU. If the intrinsic is emulated incorrectly
or causes a compilation path that hangs the kernel, all computation stalls.

This hang occurs at the first kernel invocation (`benchmark_merklize_approach_1`)
before any output is printed to stdout.
