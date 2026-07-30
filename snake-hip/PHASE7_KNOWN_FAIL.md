# snake-hip — FIXED (chipStar __clz header UB, upstream fix 2026-07-22)

`make smoke` passes on both backends when built with a chipStar toolchain
>= 2026.07.29.

## Was (wrong results at -O1/-O2/-O3, correct at -O0)

chipStar's devicelib header defined `__clz(x)` as `__builtin_clz(x)`, which
lowers to `llvm.ctlz(x, i1 true)` — poison at x==0. sneaky_snake computes
`__clz(DiagonalResult)` where 0 means "window matches perfectly"; at -O1+
InstCombine assumed the result <= 31 and folded the
`(Max_leading_zeros/2) < 16` guard to always-true, so every perfectly matching
window incremented the error count and all acceptable reads were rejected
(Accepted=0). -O0 passed because nothing folds and SPIR-V clz(0) is a defined
32. Not an IGC bug: the emitted SPIR-V control flow was itself wrong (swapping
IGC builds changed nothing).

## Fix

Upstream chipStar 3a7963b086db "make __clz/__clzll well-defined at 0"
(2026-07-22, from issue #1360), in installs >= 2026.07.29. The miscompile is
baked in at COMPILE time — rebuilding with the fixed toolchain is required;
re-running an old binary on a new runtime does not help.
