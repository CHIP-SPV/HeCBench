# tpacf-hip — FIXED (dataset located; false-pass and histogram bug fixed)

`make smoke` passes with real data: Parboil 2.5 tpacf large dataset (UIUC
IMPACT), fetched from the palmer-dabbelt/parboil GitHub mirror into
tpacf-cuda/data/small/ (102 ASCII files, 10391 "ra dec" points each; the
original NCSA URL is dead). Kept untracked — re-fetch on a fresh checkout.

Two real bugs were fixed along the way (commits bb989eed9, 7784999d4):
- The program silently exited 0 on missing/short input (garbage histogram);
  readdatafile() call sites now abort with FATAL + rc=1.
- The shared main.c zeroBin scan landed on -5.0 filler bins, subtracting the
  GPU padding correction from the underflow bin instead of the zero-dot bin.

GPU DD histogram verified bit-exact against a CPU all-pairs reimplementation.
Verified on chipStar 2026.07.20.
