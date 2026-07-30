# merkle-hip — FIXED (umul64hi devicelib fix, upstream since 2026-06-25)

`make smoke` passes on both backends with the current installed suite.

## Was (hang)

`__chip_umul64hi/__chip_mul64hi` in the device library computed the high 64
bits via UB (`(64-bit x*y) >> 64`), which LLVM folded to a plain low-bits
multiply — the rescue-prime finite-field arithmetic then never converged and
the kernel hung (and the pre-fix binary reliably wedged the GPU with ccs/bcs
engine resets). Fixed upstream (devicelib now uses OpenCL `mul_hi`, plus a
known-answer regression test), merged 2026-06-25 and present in installs
>= 2026.07.20.

## Sweep false-negative caveat

The 2026-07-30 sweep still marked merkle TIMEOUT on 2026.07.20: cold-cache IGC
JIT of the rescue-prime kernels takes 55–120+ s (main thread inside libigc),
and the benchmark's own timer includes it — any smoke timeout <= 120 s then
mimics the old hang. Warm-cache the run completes in ~34 ms with bit-identical
hashes across OCL and L0. Give merkle a >= 300 s timeout on a cold module
cache (or pre-warm), and never re-run pre-2026-06-25 builds on shared machines
(GPU wedge risk).
