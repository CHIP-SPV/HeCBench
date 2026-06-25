# bn-hip -O0 OCL failure — root-cause isolation

## Question
Is bn-hip's `-O0` OpenCL failure (CL_OUT_OF_RESOURCES) an Intel **OpenCL
driver** difference vs Level Zero (both share the i915/xe kernel driver)?

## Answer: NO — it was chipStar enabling NEO debug-key mode.

Root cause: chipStar's large-allocation workaround set, unconditionally at
library load (src/CHIPDriver.cc):

    setenv("NEOReadDebugKeys", "1");
    setenv("AllowUnrestrictedSize", "1");

`NEOReadDebugKeys=1` switches the Intel NEO OpenCL driver into debug-key mode
globally. In that mode, high register-pressure / high-scratch kernels (e.g.
unoptimized -O0 kernels like bn-hip's genScoreKernel/computeKernel) fail at
execution with CL_OUT_OF_RESOURCES, even though they run correctly without it.

Fix: the escalation is now opt-in via `CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1`
(default off). Level Zero large allocations use ze_relaxed_allocation_limits
and are unaffected.

## Evidence

1. `chipstar_genscore_O0.spv` — the EXACT processed SPIR-V chipStar feeds the
   driver for the failing -O0 genScoreKernel (CHIP_DUMP_PROCESSED_SPIRV).

2. Pure-OpenCL hosts running that exact SPIR-V — all PASS, proving the kernel
   and the driver are fine:
   - `ocl_genscore`      : cl_mem buffers                              => PASS
   - `ocl_genscore_usm`  : Intel USM device mem + indirect-access flags => PASS
   - `ocl_genscore_usm_loop` : 20x (memfill + kernel + finish)          => PASS 20/20
   - `ocl_compute`       : the computeKernel, 100 iters                 => PASS

3. On the installed chipStar, the same kernel fails — and the on/off switch is
   exactly the NEO debug keys:
   - `CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1` (keys ON)  => bn-hip -O0 FAILS
   - default (keys OFF, after fix)                   => bn-hip -O0 PASSES 5/5,
     score matches the Level Zero oracle (-11080.462891).

## Disproven theories (earlier hypotheses, all wrong)
- NOT a GPU/OCL timeout: a 30s scratch-free kernel passes on OpenCL.
- NOT a 64KB scratch cap: a 25s kernel with 192KB/WI private memory passes;
  the failing -O0 kernel only needs 8KB/thread scratch (driver allocates 10MB
  fine).
- NOT the memcpy/memfill SVM-vs-USM API path (the "staging" idea): a libCHIP
  built without the NEO keys passes with the unchanged memcpy/memfill code.
- NOT DisableRecompilation or group_collectives: toggling each off does not
  help; toggling the NEO keys does.

## Reproduce
    module load llvm/22.0-native oneapi
    gcc ocl_genscore_usm.c -o ocl_genscore_usm -I/usr/local/include -L/usr/local/lib -lOpenCL
    LD_LIBRARY_PATH=/usr/local/lib ./ocl_genscore_usm_loop chipstar_genscore_O0.spv _Z14genScoreKerneliPfPKiPKf 20
    # => PASS (driver + kernel are fine)
    # On chipStar: CHIP_OCL_UNRESTRICTED_ALLOC_SIZE=1 ./main result 1  => fails
    #              ./main result 1                                     => passes (fixed)

## Note
The `.spv` binaries are not committed (regenerable). To recreate
`chipstar_genscore_O0.spv`:
    CHIP_DUMP_PROCESSED_SPIRV=. ./main result 1   # writes processed_0.spv
And `genscore_O0.spv` / `scratchhog.spv` from the `.cl` files via the build
commands above.
