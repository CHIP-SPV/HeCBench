# resnet-kernels-hip — RESOLVED (bench-side OOB fixed, 2026-07-30)

`make smoke` and all modes 0-5 pass on both OCL and L0 backends (rc=0)
on chipStar 2026.07.20.

## History

1. Original L0 `ZE_RESULT_ERROR_DEVICE_LOST` was chipStar-side (excessive
   immediate command lists per submission), fixed by the `SharedImmCLs_`
   series in the 2026.06.23 install.
2. On chipStar 2026.06.25+ mode 0 regressed with
   `hipErrorOutOfMemory (CL_OUT_OF_RESOURCES)` on OCL (abort, rc=134).
   Root cause was a genuine bench bug (chipStar issue #1361 context):
   out-of-bounds reads in the winograd input-transform kernels.

## Root cause (bench bug, UB on every platform)

`kernel_128_winograd_BtdB` (mode 0) and `kernel_256_winograd_BtdB`
(mode 1) tile the 16x16 zero-padded image with 6x6 winograd tiles on a
stride-4 grid; the edge blocks (blockIdx 3) read tile rows/cols
16-17, past the end of the input buffer:

| Kernel | Alloc (floats) | Max index read | Derivation |
|--------|---------------|----------------|------------|
| kernel_128_winograd_BtdB | 16\*16\*128 = 32768 | 37119 | 17\*2048 + 17\*128 + 127 |
| kernel_256_winograd_BtdB | 16\*16\*256 = 65536 | 74239 | 17\*4096 + 17\*256 + 127 + 128 (Part) |

The halo values only feed transformed outputs that `*_winograd_AtIA`
discards (Tilex==3/Tiley==3 edge clamps), so they never affect results —
but the reads themselves are UB and fault on chipStar 2026.06.25+.

## Fix

Size the device input allocation to the real access bound (`nInputHalo` =
37120 / 74240 floats) and zero-fill the halo tail, which merely extends
the image's zero padding.  See the bound-derivation comments in
`Kernel128_winograd.cu` and `Kernel256_winograd.cu`.  All other buffers
in modes 0-5 were audited and are exactly in-bounds.

## Current status (chipStar 2026.07.20, Intel Arc B570, repeat=3)

| Backend | Mode 0 | Mode 1 | Mode 2 | Mode 3 | Mode 4 | Mode 5 |
|---------|--------|--------|--------|--------|--------|--------|
| OCL     | PASS   | PASS   | PASS   | PASS   | PASS   | PASS   |
| L0      | PASS   | PASS   | PASS   | PASS   | PASS   | PASS   |

DEBUG-build checksums are identical across both backends per mode
(mode 0: 4540.304732, mode 1: 10643.089135, mode 2: 86168633.920740,
mode 3: 1242321.673480, mode 4: 230325236.635787, mode 5: 2407772.420437).

Note: `./main <mode> 1` (smoke repeat=1) prints `[-0.000000 us]` timing
because the code averages over `(repeat-2)` runs, which is -1 for repeat=1.
Use repeat >= 3 for meaningful timing numbers.
