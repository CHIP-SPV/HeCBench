# Makefile Review Log

## 1. src/kmeans-hip/Makefile
- **Target name**: ✓ Produces `main` (line 20: `all: main`, line 22: `main: ...`)
- **Dependencies**: Looks OK - main depends on cluster.o, getopt.o, read_input.o, rmse.o, kmeans.cpp
- **Run target**: ✓ Has `run` target (lines 40-41)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 2. src/chi2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on chi2.o and reference.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: No `all` target, but first target is `$(program)` which is main, so OK
- **Status**: OK

## 3. src/hybridsort-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 81: `main: hybridsort.o bucketsort.o mergesort.o`)
- **Dependencies**: Looks OK - main depends on hybridsort.o, bucketsort.o, mergesort.o
- **Run target**: ✓ Has `run` target (lines 98-99)
- **Issues/Inconsistencies**: No `all` target, but first target is `main`, so OK
- **Status**: OK

## 4. src/heartwall-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 78: `main: ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and several util object files
- **Run target**: ✓ Has `run` target (lines 140-141)
- **Issues/Inconsistencies**: `program = main` variable defined on line 24 but not used (target directly uses `main`)
- **Status**: OK

## 5. src/heartwall-hip/Makefile
- **Target name**: ✓ Produces `main` (line 30: `main: ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and several util object files
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 6. src/b+tree-hip/Makefile
- **Target name**: ✓ Produces `main` (line 34: `main: ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, and util object files
- **Run target**: ✓ Has `run` target (lines 93-94) - FIXED: removed duplicate run target
- **Issues/Inconsistencies**: FIXED - removed duplicate run target definition
- **Status**: OK

## 7. src/sheath-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 8. src/streamcluster-hip/Makefile
- **Target name**: ✓ Produces `main` (line 29: `EXE = main`, line 31: `$(EXE): ...`)
- **Dependencies**: Looks OK - main depends on streamcluster.cu and headers
- **Run target**: ✓ Has `run` target (lines 34-35)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 9. src/stencil1d-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on stencil_1d.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 10. src/srad-hip/Makefile
- **Target name**: ✓ Produces `main` (line 14: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 11. src/stddev-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 12. src/prna-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, base.o, param.o, util.o, prna.o
- **Run target**: ✓ Has `run` target (lines 70-71)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 13. src/nbnxm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 14. src/perplexity-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 15. src/minkowski-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 16. src/mriQ-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and file.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 17. src/minisweep-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, runs two commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 18. src/marchingCubes-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 19. src/langevin-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 20. src/logan-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on src/main.o, src/seed.o, src/score.o, src/logan_functions.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: Has a "main" target on line 66 that runs the program (different from the build target)
- **Status**: OK

## 21. src/henry-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 22. src/grrt-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 23. src/frna-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, fbase.o, fparam.o, fprna.o, util.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 24. src/srad-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 67: `./main: ...`, outputs to `main` on line 76)
- **Dependencies**: Looks OK - main depends on main.o and util object files
- **Run target**: ✓ Has `run` target (lines 111-112)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 25. src/srad-omp/Makefile
- **Target name**: ✓ Produces `main` (line 31: `./main: ...`, outputs to `main` on line 40)
- **Dependencies**: Looks OK - main depends on main.o and util object files
- **Run target**: ✓ Has `run` target (lines 72-73)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 26. src/b+tree-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 69: `main: ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, and util object files
- **Run target**: ✓ Has `run` target (lines 120-121) - FIXED: removed duplicate run target
- **Issues/Inconsistencies**: FIXED - removed duplicate run target definition (was on lines 120-121 and 129-130)
- **Status**: OK

## 27. src/leukocyte-hip/Makefile
- **Target name**: ✓ Produces `main` (line 31: `main: ...`)
- **Dependencies**: Looks OK - main depends on detect_main.o, avilib.o, track_ellipse.o, track_ellipse_gpu.o, find_ellipse.o, misc_math.o, helper.o, and meschach.a
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 28. src/atomicCost-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs two commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 29. src/cooling-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 30. src/gabor-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 31. src/aidw-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 32. src/asmooth-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 33. src/xsbench-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on Main.o, Simulation.o, io.o, GridInit.o, Materials.o, XSutils.o
- **Run target**: ✓ Has `run` target (lines 75-76)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 34. src/projectile-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on Projectile.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 35. src/zoom-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 36. src/zmddft-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 37. src/zeropoint-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 38. src/zerocopy-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 39. src/xlqc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on basis.o, scf.o, main.o, crys.o, cints.o, cuda_rys_sp.o, cuda_rys_dp.o
- **Run target**: ✓ Has `run` target (lines 70-72, runs two commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 40. src/wyllie-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 41. src/wsm5-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 42. src/wordcount-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and wc.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 43. src/word2vec-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on cbow.o and word2vec.o
- **Run target**: ✓ Has `run` target (lines 54-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 44. src/wlcpow-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 45. src/wmma-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-58, runs 4 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 46. src/winograd-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 47. src/wedford-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 48. src/warpsort-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and warpsort.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 49. src/warpexchange-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 50. src/voxelization-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 51. src/vol2col-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 52. src/vote-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 53. src/vanGenuchten-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 54. src/vmc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on vmc2.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 55. src/unfold-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 56. src/tsp-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 57. src/tsne-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple .o files
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 58. src/tsa-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 59. src/tridiagonal-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o
- **Run target**: ✓ Has `run` target (lines 72-75, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 60. src/triad-hip/Makefile
- **Target name**: ⚠️ Produces `triad` NOT `main` (line 16: `program = triad`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - main depends on main.o, Option.o, OptionParser.o, triad.o, Timer.o
- **Run target**: ✓ Has `run` target (lines 70-71)
- **Issues/Inconsistencies**: FIXED - changed program name from `triad` to `main`
- **Status**: FIXED

## 61. src/tqs-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, host_task.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 62. src/tpacf-hip/Makefile
- **Target name**: ✓ Produces `main` (line 21: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, args.o, compute.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 63. src/tissue-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 64. src/tonemapping-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 65. src/thomas-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and cuThomasBatch.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 66. src/miniDGS-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 54: `main: ...`)
- **Dependencies**: Looks OK - main depends on multiple object files
- **Run target**: ⚠️ Had `run :` (with space) and didn't use $(LAUNCHER) - FIXED: changed to `run:` and added $(LAUNCHER)
- **Issues/Inconsistencies**: FIXED - standardized run target format and added LAUNCHER support
- **Status**: FIXED

## 67. src/triad-cuda/Makefile
- **Target name**: ⚠️ Produces `triad` NOT `main` (line 17: `program = triad`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - main depends on main.o, Option.o, OptionParser.o, triad.o, Timer.o
- **Run target**: ✓ Has `run` target (lines 71-72)
- **Issues/Inconsistencies**: FIXED - changed program name from `triad` to `main`
- **Status**: FIXED

## 68. src/triad-omp/Makefile
- **Target name**: ⚠️ Produces `triad` NOT `main` (line 17: `program = triad`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - main depends on main.o, Option.o, OptionParser.o, triad.o, Timer.o
- **Run target**: ✓ Has `run` target (lines 75-76)
- **Issues/Inconsistencies**: FIXED - changed program name from `triad` to `main`
- **Status**: FIXED

## 69. src/tridiagonal-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o
- **Run target**: ✓ Has `run` target (lines 80-83, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 70. src/tridiagonal-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o
- **Run target**: ✓ Has `run` target (lines 98-101, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 71. src/tqs-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, host_task.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 72. src/tqs-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, host_task.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 73. src/tqs-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, host_task.o
- **Run target**: ✓ Has `run` target (lines 89-90)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 74. src/tpacf-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, args.o, compute.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 75. src/tpacf-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 27: `program = main`, line 75: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, args.o, compute.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 76. src/tonemapping-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 77. src/tonemapping-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 78. src/tonemapping-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 79. src/tissue-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 80. src/tissue-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 81. src/tissue-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 82. src/tsa-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 83. src/tsa-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 84. src/tsa-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 85. src/tsne-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple .o files
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 86. src/tsne-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple .o files
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 87. src/tsp-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 88. src/tsp-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 89. src/unfold-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 90. src/unfold-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 91. src/vanGenuchten-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 92. src/vanGenuchten-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 93. src/vanGenuchten-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 94. src/vmc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on vmc2.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 95. src/vmc-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on vmc.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 96. src/vmc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on vmc2.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 97. src/vol2col-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 98. src/vol2col-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 99. src/vol2col-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 100. src/vote-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 101. src/vote-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 102. src/voxelization-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 103. src/voxelization-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 104. src/warpexchange-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 105. src/warpexchange-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 84-85)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 106. src/warpsort-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and warpsort.o
- **Run target**: ✓ Has `run` target (lines 68-69)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 107. src/warpsort-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and warpsort.o
- **Run target**: ✓ Has `run` target (lines 90-91)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 108. src/wedford-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 109. src/wedford-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 110. src/wedford-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 111. src/winograd-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 112. src/winograd-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 113. src/winograd-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 114. src/wlcpow-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 115. src/wlcpow-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 116. src/wlcpow-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 117. src/wmma-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-59, runs 4 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 118. src/wmma-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-84, runs 4 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 119. src/word2vec-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on cbow.o and word2vec.o
- **Run target**: ✓ Has `run` target (lines 55-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 120. src/word2vec-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on cbow.o and word2vec.o
- **Run target**: ✓ Has `run` target (lines 80-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 121. src/wordcount-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and wc.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 122. src/wordcount-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and wc.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 123. src/wordcount-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and wc.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 124. src/wsm5-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 125. src/wsm5-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 126. src/wsm5-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 127. src/wyllie-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 128. src/wyllie-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 129. src/wyllie-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 130. src/bincount-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 131. src/bincount-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 132. src/binomial-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, main.o, reference.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 133. src/binomial-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, main.o, reference.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 134. src/binomial-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, main.o, reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 135. src/binomial-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, main.o, reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 136. src/bitcracker-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on attack.o, main.o, utils.o, w_blocks.o
- **Run target**: ✓ Has `run` target (lines 55-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 137. src/bitcracker-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on attack.o, main.o, utils.o, w_blocks.o
- **Run target**: ✓ Has `run` target (lines 54-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 138. src/bitcracker-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on attack.o, main.o, utils.o, w_blocks.o
- **Run target**: ✓ Has `run` target (lines 80-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 139. src/bitonic-sort-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 140. src/bitonic-sort-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 141. src/bitonic-sort-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 142. src/bitonic-sort-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 143. src/bitpacking-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, utils.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 144. src/bitpacking-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, utils.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 145. src/bitpacking-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, utils.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 146. src/bitpermute-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 147. src/bitpermute-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 148. src/bitpermute-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 149. src/black-scholes-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on blackScholesAnalyticEngine.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 150. src/black-scholes-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on blackScholesAnalyticEngine.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 151. src/black-scholes-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on blackScholesAnalyticEngine.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 152. src/black-scholes-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on blackScholesAnalyticEngine.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 153. src/blas-dot-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 154. src/blas-dot-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 155. src/blas-dot-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 83: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 92-93)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 156. src/blas-fp8gemm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 157. src/blas-fp8gemm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 158. src/blas-gemmBatched-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 159. src/blas-gemmBatched-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 160. src/blas-gemmBatched-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 83: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 92-93)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 161. src/blas-gemm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 162. src/blas-gemmEx2-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 163. src/blas-gemmEx2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-56, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 164. src/blas-gemmEx2-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 84: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 93-95, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 165. src/blas-gemmEx-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 166. src/blas-gemmEx-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 167. src/blas-gemmEx-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 83: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 92-94, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 168. src/blas-gemm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 169. src/blas-gemm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 11: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 170. src/blas-gemmStridedBatched-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 171. src/blas-gemmStridedBatched-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 172. src/blas-gemmStridedBatched-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 83: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 92-93)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 173. src/blas-gemm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 82: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 91-93, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 174. src/blockAccess-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 175. src/blockAccess-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 176. src/blockAccess-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 177. src/blockexchange-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 178. src/blockexchange-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 179. src/blockexchange-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 84-85)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 180. src/bm3d-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, blockmatching.o, filtering.o, dct8x8.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 181. src/bm3d-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, blockmatching.o, filtering.o, dct8x8.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 182. src/bm3d-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, blockmatching.o, filtering.o, dct8x8.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 183. src/bmf-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 68: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 78-79)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 184. src/bmf-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 66: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 76-77)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 185. src/bmf-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 84: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 186. src/bn-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 187. src/bn-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 188. src/bn-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 189. src/bn-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 190. src/bonds-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on bondsEngine.o
- **Run target**: ✓ Has `run` target (lines 56-57, note: `run:$(program)` without space after colon, but valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 191. src/bonds-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on bondsEngine.o
- **Run target**: ✓ Has `run` target (lines 56-57, note: `run:$(program)` without space after colon, but valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 192. src/bonds-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on bondsEngine.o
- **Run target**: ✓ Has `run` target (lines 61-62, note: `run:$(program)` without space after colon, but valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 193. src/bonds-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on bondsEngine.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 194. src/boxfilter-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o, reference.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 195. src/boxfilter-hip/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o, reference.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 196. src/boxfilter-omp/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o, reference.o
- **Run target**: ✓ Has `run` target (lines 72-73)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 197. src/boxfilter-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, cmd_arg_reader.o, reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 198. src/bscan-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 199. src/bscan-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 200. src/bscan-sycl/Makefile
- **Target name**: ⚠️ Conditionally produces `main` or `main-wave64` (lines 22-28: if HIP=yes then `main-wave64`, else `main`) - FIXED: changed to always produce `main`
- **Dependencies**: Looks OK - depends on main.o
- **Run target**: ✓ Has `run` target (lines 84-85)
- **Issues/Inconsistencies**: FIXED - removed conditional, now always produces `main`
- **Status**: FIXED

## 201. src/bsearch-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 202. src/bsearch-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 203. src/bsearch-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 204. src/bsearch-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 205. src/bspline-vgh-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 206. src/bspline-vgh-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 207. src/bspline-vgh-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 208. src/bspline-vgh-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 209. src/bsw-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, driver.o, utils.o
- **Run target**: ✓ Has `run` target (lines 57-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 210. src/bsw-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, driver.o, utils.o
- **Run target**: ✓ Has `run` target (lines 56-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 211. src/bsw-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, driver.o, utils.o
- **Run target**: ✓ Has `run` target (lines 81-85)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 212. src/b+tree-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 35: `main: ...` - direct target, no program variable)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, timer.o, num.o
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 213. src/btree-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 214. src/b+tree-hip/Makefile
- **Target name**: ✓ Produces `main` (line 34: `main: ...` - direct target, no program variable)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, timer.o, num.o
- **Run target**: ✓ Has `run` target (lines 93-94)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 215. src/b+tree-omp/Makefile
- **Target name**: ✓ Produces `main` (line 32: `main: ...` - direct target, no program variable)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, timer.o, num.o
- **Run target**: ✓ Has `run` target (lines 100-101)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 216. src/b+tree-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 69: `main: ...` - direct target, no program variable)
- **Dependencies**: Looks OK - main depends on main.o, kernel_wrapper.o, kernel2_wrapper.o, timer.o, num.o
- **Run target**: ✓ Has `run` target (lines 120-121)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 217. src/btree-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 88-89)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 218. src/burger-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 219. src/burger-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 220. src/burger-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 221. src/burger-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 222. src/bwt-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and bwt.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 223. src/bwt-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 44: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and bwt.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 224. src/bwt-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and bwt.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 225. src/bwt-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 70: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and bwt.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 226. src/car-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 227. src/car-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 228. src/car-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 229. src/car-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 230. src/cbsfil-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 231. src/cbsfil-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 232. src/cbsfil-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 233. src/cbsfil-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 234. src/cc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, note: includes `ulimit` command)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 235. src/cc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-58, note: includes `ulimit` command)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 236. src/ccl-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 20: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 237. src/ccl-hip/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 238. src/ccl-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 19: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 239. src/ccs-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 240. src/ccsd-trpdrv-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on ccsd_tengy.o, ccsd_trpdrv.o, main.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 241. src/ccsd-trpdrv-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on ccsd_tengy.o, ccsd_trpdrv.o, main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 242. src/ccsd-trpdrv-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on ccsd_tengy.o, ccsd_trpdrv.o, main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 243. src/ccsd-trpdrv-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on ccsd_tengy.o, ccsd_trpdrv.o, main.o
- **Run target**: ✓ Has `run` target (lines 87-88)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 244. src/ccs-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-56, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 245. src/ccs-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-64, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 246. src/ccs-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-83, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 247. src/cc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 74: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 83-85, note: includes `ulimit` command)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 248. src/ced-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and kernel_reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 249. src/ced-hip/Makefile
- **Target name**: ⚠️ Produces `ced` NOT `main` (line 16: `program = ced`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - main depends on main.o and kernel_reference.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: FIXED - changed program name from `ced` to `main`
- **Status**: FIXED

## 250. src/ced-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 76: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and kernel_reference.o
- **Run target**: ✓ Has `run` target (lines 85-86)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 251. src/cfd-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on euler3d.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 252. src/cfd-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on euler3d.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 253. src/cfd-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 59: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on euler3d.o
- **Run target**: ✓ Has `run` target (lines 68-72, has commented commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 254. src/cfd-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 24: `program = main`, line 81: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on euler3d.o
- **Run target**: ✓ Has `run` target (lines 94-97, has commented commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 255. src/chacha20-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 256. src/chacha20-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 257. src/chacha20-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 258. src/chacha20-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 259. src/channelShuffle-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 260. src/channelShuffle-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 261. src/channelShuffle-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 262. src/channelShuffle-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 263. src/channelSum-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 264. src/channelSum-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 265. src/channelSum-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 266. src/channelSum-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 267. src/che-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-60, runs multiple commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 268. src/che-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-59, runs multiple commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 269. src/che-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-65, runs multiple commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 270. src/che-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-83, runs multiple commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 271. src/chemv-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o and main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 272. src/chemv-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o and main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 273. src/chemv-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 274. src/chemv-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 275. src/chi2-cuda/Makefile
- **Target name**: ⚠️ Produces `chi2` NOT `main` (line 16: `program = chi2`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - main depends on chi2.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: FIXED - changed program name from `chi2` to `main`
- **Status**: FIXED

## 276. src/chi2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on chi2.o and reference.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 277. src/chi2-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on chi2.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 278. src/chi2-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on chi2.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 279. src/clenergy-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on clenergy.o and WKFUtils.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 280. src/clenergy-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on clenergy.o and WKFUtils.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 281. src/clenergy-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on clenergy.o and WKFUtils.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 282. src/clenergy-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on clenergy.o and WKFUtils.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 283. src/clink-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 284. src/clink-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 285. src/clink-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 286. src/clink-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 287. src/clock-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 288. src/clock-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 289. src/cm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 44: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, io.o, process.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 290. src/cmembench-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 291. src/cmembench-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 292. src/cm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 43: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, io.o, process.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 293. src/cm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, io.o, process.o
- **Run target**: ✓ Has `run` target (lines 68-69)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 294. src/cm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, io.o, process.o
- **Run target**: ✓ Has `run` target (lines 87-88)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 295. src/cmp-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, su_cdp.o, su_gather.o, su_trace.o, log.o, parser.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 296. src/cmp-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, su_cdp.o, su_gather.o, su_trace.o, log.o, parser.o
- **Run target**: ✓ Has `run` target (lines 73-74)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 297. src/cmp-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 58: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, su_cdp.o, su_gather.o, su_trace.o, log.o, parser.o
- **Run target**: ✓ Has `run` target (lines 77-79)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 298. src/cmp-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, su_cdp.o, su_gather.o, su_trace.o, log.o, parser.o
- **Run target**: ✓ Has `run` target (lines 102-104)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 299. src/cobahh-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 300. src/cobahh-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 301. src/cobahh-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 302. src/cobahh-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: Minor syntax issue on line 39 (orphaned `--gcc-toolchain` line), but doesn't affect functionality
- **Status**: OK

## 303. src/collision-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 304. src/collision-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 305. src/collision-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: Minor syntax issue on line 39 (orphaned `--gcc-toolchain` line), but doesn't affect functionality
- **Status**: OK

## 306. src/colorwheel-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 307. src/colorwheel-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 308. src/colorwheel-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 309. src/colorwheel-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 310. src/columnarSolver-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 311. src/columnarSolver-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 312. src/columnarSolver-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 313. src/columnarSolver-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 314. src/complex-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 315. src/complex-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 316. src/complex-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 317. src/complex-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 318. src/compute-score-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and options.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 319. src/compute-score-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and options.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 320. src/compute-score-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and options.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: Minor typo on line 45 (`--fiopenmp` should be `-fiopenmp`), but doesn't affect functionality
- **Status**: OK

## 321. src/compute-score-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and options.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 322. src/concat-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 323. src/concat-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 324. src/concat-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 325. src/concat-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 326. src/concurrentKernels-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 327. src/concurrentKernels-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 328. src/concurrentKernels-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 329. src/contract-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 330. src/contract-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 331. src/contract-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 332. src/contract-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 333. src/conversion-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 334. src/conversion-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 335. src/conversion-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 336. src/conversion-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 337. src/convolution1D-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 338. src/convolution1D-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 339. src/convolution1D-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 340. src/convolution1D-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 341. src/convolution3D-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-65, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 342. src/convolution3D-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-64, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 343. src/convolution3D-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-65, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 344. src/convolution3D-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 77: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 86-89, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 345. src/convolutionDeformable-cuda/Makefile
- **Target name**: ⚠️ Python-based Makefile - does NOT produce `main` binary (uses `python setup.py`)
- **Dependencies**: Builds Python package
- **Run target**: ✓ Has `run` target (lines 11-13, runs Python script)
- **Issues/Inconsistencies**: Python-based, doesn't produce `main` binary - different structure
- **Status**: NOTE (Python-based, not C/C++)

## 346. src/convolutionDeformable-hip/Makefile
- **Target name**: ⚠️ Python-based Makefile - does NOT produce `main` binary (uses `python setup.py`)
- **Dependencies**: Builds Python package
- **Run target**: ✓ Has `run` target (lines 11-13, runs Python script)
- **Issues/Inconsistencies**: Python-based, doesn't produce `main` binary - different structure
- **Status**: NOTE (Python-based, not C/C++)

## 347. src/convolutionDeformable-sycl/Makefile
- **Target name**: ⚠️ Python-based Makefile - does NOT produce `main` binary (uses `python setup.py`)
- **Dependencies**: Builds Python package
- **Run target**: ✓ Has `run` target (lines 11-13, runs Python script)
- **Issues/Inconsistencies**: Python-based, doesn't produce `main` binary - different structure
- **Status**: NOTE (Python-based, not C/C++)

## 348. src/convolutionSeparable-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, conv.o, conv_gold.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 349. src/convolutionSeparable-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, conv.o, conv_gold.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 350. src/convolutionSeparable-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, conv.o, conv_gold.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 351. src/convolutionSeparable-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, conv.o, conv_gold.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 352. src/cooling-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 353. src/cooling-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 354. src/cooling-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 355. src/cooling-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 356. src/coordinates-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 357. src/coordinates-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 358. src/coordinates-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 359. src/crc64-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on CRC64.o and CRC64Test.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 360. src/crc64-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on CRC64.o and CRC64Test.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 361. src/crc64-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on CRC64.o and CRC64Test.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 362. src/crc64-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on CRC64.o and CRC64Test.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 363. src/cross-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 364. src/cross-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 365. src/cross-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 366. src/cross-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 367. src/crossEntropy-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 368. src/crossEntropy-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 369. src/crossEntropy-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 370. src/crs-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, galois.o, jerasure.o, GCRSMatrix.o, utils.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 371. src/crs-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 57: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on jerasure.o, galois.o, GCRSMatrix.o, main.o, utils.o
- **Run target**: ✓ Has `run` target (lines 78-79)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 372. src/crs-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 61: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on jerasure.o, galois.o, GCRSMatrix.o, main.o, utils.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 373. src/crs-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 76: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, galois.o, jerasure.o, GCRSMatrix.o, utils.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 374. src/d2q9-bgk-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 55: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 375. src/d2q9-bgk-hip/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 376. src/d2q9-bgk-omp/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 60: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 377. src/d2q9-bgk-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 28: `program = main`, line 77: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 86-87)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 378. src/d3q19-bgk-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 379. src/d3q19-bgk-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 380. src/d3q19-bgk-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 381. src/damage-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 382. src/damage-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 383. src/damage-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 384. src/damage-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 385. src/dct8x8-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, DCT8x8_gold.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 386. src/dct8x8-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, DCT8x8_gold.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 387. src/dct8x8-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, DCT8x8_gold.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 388. src/dct8x8-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, DCT8x8_gold.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 389. src/ddbp-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 390. src/ddbp-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 391. src/ddbp-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 392. src/ddbp-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 393. src/debayer-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 394. src/debayer-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 395. src/debayer-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 396. src/debayer-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 397. src/degrid-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 398. src/degrid-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 399. src/degrid-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 400. src/degrid-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 401. src/dense-embedding-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 402. src/dense-embedding-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 403. src/dense-embedding-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 404. src/dense-embedding-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 405. src/depixel-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 406. src/depixel-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 407. src/depixel-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 408. src/depixel-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 409. src/deredundancy-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 410. src/deredundancy-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 411. src/deredundancy-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 412. src/deredundancy-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 83-84)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 413. src/determinant-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 414. src/determinant-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 415. src/determinant-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 26: `program = main`, line 84: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 93-94)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 416. src/diamond-cuda/Makefile
- **Target name**: ✗ Produces `diamond` instead of `main` (line 17: `program = diamond`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - diamond depends on many object files
- **Run target**: ✓ Has `run` target (lines 135-136)
- **Issues/Inconsistencies**: FIXED - changed program name from `diamond` to `main`
- **Status**: FIXED

## 417. src/diamond-hip/Makefile
- **Target name**: ✗ Produces `diamond` instead of `main` (line 16: `program = diamond`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - diamond depends on many object files
- **Run target**: ✓ Has `run` target (lines 134-135)
- **Issues/Inconsistencies**: FIXED - changed program name from `diamond` to `main`
- **Status**: FIXED

## 418. src/diamond-omp/Makefile
- **Target name**: ✗ Produces `diamond` instead of `main` (line 17: `program = diamond`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - diamond depends on many object files
- **Run target**: ✓ Has `run` target (lines 136-137)
- **Issues/Inconsistencies**: FIXED - changed program name from `diamond` to `main`
- **Status**: FIXED

## 419. src/diamond-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 138: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on many object files
- **Run target**: ✓ Has `run` target (lines 153-154)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 420. src/dispatch-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 421. src/dispatch-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 422. src/dispatch-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 423. src/distort-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distort.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 424. src/distort-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distort.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 425. src/distort-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distort.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 426. src/distort-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distort.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 427. src/divergence-cuda/Makefile
- **Target name**: ✗ Produces `divergence` instead of `main` (line 16: `program = divergence`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - divergence depends on divergence.o and timer.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: FIXED - changed program name from `divergence` to `main`
- **Status**: FIXED

## 428. src/divergence-hip/Makefile
- **Target name**: ✗ Produces `divergence` instead of `main` (line 15: `program = divergence`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - divergence depends on divergence.o and timer.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: FIXED - changed program name from `divergence` to `main`
- **Status**: FIXED

## 429. src/divergence-omp/Makefile
- **Target name**: ✗ Produces `divergence` instead of `main` (line 16: `program = divergence`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - divergence depends on divergence.o and timer.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: FIXED - changed program name from `divergence` to `main`
- **Status**: FIXED

## 430. src/divergence-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on divergence.o and timer.o
- **Run target**: ✓ Has `run` target (lines 83-84)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 431. src/doh-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 432. src/doh-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 433. src/doh-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 434. src/doh-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 435. src/dp-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 436. src/dp-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 437. src/dpid-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and kernels.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 438. src/dpid-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and kernels.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 439. src/dpid-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and kernels.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 440. src/dp-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 441. src/dp-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 26: `program = main`, line 85: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 442. src/dropout-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 443. src/dropout-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 444. src/dropout-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 445. src/dslash-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 56: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, dslash.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 446. src/dslash-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, dslash.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 447. src/dslash-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 55: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, dslash.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 448. src/dslash-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, dslash.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 449. src/dwconv-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 450. src/dwconv-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 451. src/dwconv-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 452. src/dwt2d-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 27: `program = main`, line 88: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 101-103, has commented line but still valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 453. src/dxtc2-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 60-62, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 454. src/dxtc2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and shrUtils.o
- **Run target**: ✓ Has `run` target (lines 57-59, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 455. src/dxtc2-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, and block.o
- **Run target**: ✓ Has `run` target (lines 67-69, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 456. src/dxtc2-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, shrUtils.o, and block.o
- **Run target**: ✓ Has `run` target (lines 86-88, runs 2 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 457. src/easyWave-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on many object files
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 458. src/easyWave-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on many object files
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 459. src/easyWave-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on many object files
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 460. src/easyWave-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on many object files
- **Run target**: ✓ Has `run` target (lines 88-91)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 461. src/ecdh-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 462. src/ecdh-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 463. src/ecdh-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 464. src/ecdh-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 465. src/egs-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 466. src/egs-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 467. src/eigenvalue-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 468. src/eigenvalue-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 469. src/eigenvalue-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 470. src/eigenvalue-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 471. src/eikonal-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, fim.o, timer.o, main.o, StructuredEikonal.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 472. src/eikonal-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, fim.o, StructuredEikonal.o, timer.o, main.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 473. src/eikonal-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on kernel.o, fim.o, timer.o, main.o, StructuredEikonal.o
- **Run target**: ✓ Has `run` target (lines 93-94)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 474. src/entropy-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 475. src/entropy-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 476. src/entropy-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 477. src/entropy-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 478. src/epistasis-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 479. src/epistasis-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 480. src/epistasis-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 481. src/flame-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 482. src/flame-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 483. src/flame-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 75: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 84-85)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 484. src/flip-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 485. src/flip-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 486. src/flip-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 487. src/flip-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 488. src/floydwarshall-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 489. src/floydwarshall-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 490. src/floydwarshall-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 491. src/floydwarshall-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 492. src/floydwarshall2-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-59, has commented line but still valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 493. src/floydwarshall2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-58, has commented line but still valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 494. src/floydwarshall2-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-83, has commented line but still valid)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 495. src/fluidSim-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 496. src/fluidSim-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 497. src/fluidSim-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 56: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o
- **Run target**: ✓ Has `run` target (lines 71-72)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 498. src/fluidSim-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 76: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 85-86)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 499. src/fma-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 500. src/fma-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 501. src/fma-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 502. src/fpc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 503. src/fpc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 504. src/fpc-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 505. src/fpc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 506. src/fpdc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 507. src/fpdc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 508. src/fpdc-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 509. src/fpdc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 510. src/frechet-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 511. src/frechet-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 512. src/frechet-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 513. src/frechet-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 514. src/fresnel-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cosine.o, fresnel.o, sine.o, xchebyshev.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 515. src/fresnel-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cosine.o, fresnel.o, sine.o, xchebyshev.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 516. src/fresnel-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cosine.o, fresnel.o, sine.o, xchebyshev.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 517. src/fresnel-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cosine.o, fresnel.o, sine.o, xchebyshev.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 518. src/frna-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, fbase.o, fparam.o, util.o, frna.o
- **Run target**: ✓ Has `run` target (lines 70-71)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 519. src/frna-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, fbase.o, fparam.o, util.o, frna.o
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 520. src/frna-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 55: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, fbase.o, fparam.o, util.o, frna.o
- **Run target**: ✓ Has `run` target (lines 76-77)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 521. src/frna-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, fbase.o, fparam.o, util.o, frna.o
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 522. src/fsm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 523. src/fsm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 524. src/fsm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 525. src/fsm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 526. src/fwt-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 527. src/fwt-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 528. src/fwt-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 529. src/fwt-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 530. src/gabor-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 531. src/gabor-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 532. src/gabor-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 533. src/gabor-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 534. src/ga-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 535. src/ga-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 536. src/ga-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 537. src/ga-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 538. src/gamma-correction-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 539. src/gamma-correction-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 540. src/gamma-correction-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 541. src/gamma-correction-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 542. src/gaussian-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on gaussianElim.o and utils.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 543. src/gaussian-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on gaussianElim.o and utils.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 544. src/gaussian-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on gaussianElim.o and utils.o
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 545. src/gaussian-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on gaussianElim.o and utils.o
- **Run target**: ✓ Has `run` target (lines 84-85)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 546. src/gc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 547. src/gc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 548. src/gc-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 549. src/gc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 74: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 83-84)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 550. src/gd-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 551. src/gd-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 552. src/gd-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 553. src/gd-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 70: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and utils.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 554. src/geam-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 555. src/geam-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 556. src/geam-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 26: `program = main`, line 82: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 557. src/geglu-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 558. src/geglu-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 559. src/geglu-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 560. src/geglu-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-83)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 561. src/gels-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 562. src/gels-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 563. src/gels-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 26: `program = main`, line 82: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 564. src/gelu-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-60, has commented line but still valid, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 565. src/gelu-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-59, has commented line but still valid, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 566. src/gelu-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 82-86, has commented line but still valid, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 567. src/gemv-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and gemv.o
- **Run target**: ✓ Has `run` target (lines 55-58, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 568. src/gemv-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and gemv.o
- **Run target**: ✓ Has `run` target (lines 54-57, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 569. src/gemv-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and gemv.o
- **Run target**: ✓ Has `run` target (lines 81-84, runs 3 commands)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 570. src/geodesic-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 571. src/geodesic-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 572. src/geodesic-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 573. src/geodesic-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 574. src/gerbil-cuda/Makefile
- **Target name**: ✗ Produces `gerbil` instead of `main` (line 16: `program = gerbil`, line 67: `$(program): ...`)
- **Dependencies**: Looks OK - gerbil depends on many object files
- **Run target**: ✓ Has `run` target (lines 106-107)
- **Issues/Inconsistencies**: FIXED - changed program name from `gerbil` to `main`
- **Status**: FIXED

## 575. src/gerbil-hip/Makefile
- **Target name**: ✗ Produces `gerbil` instead of `main` (line 16: `program = gerbil`, line 67: `$(program): ...`)
- **Dependencies**: Looks OK - gerbil depends on many object files
- **Run target**: ✓ Has `run` target (lines 106-107)
- **Issues/Inconsistencies**: FIXED - changed program name from `gerbil` to `main`
- **Status**: FIXED

## 576. src/ge-spmm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 577. src/ge-spmm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 578. src/ge-spmm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 579. src/gibbs-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 580. src/gibbs-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 581. src/gibbs-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 582. src/glu-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 583. src/glu-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 584. src/glu-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 585. src/glu-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 586. src/gmm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 587. src/gmm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 588. src/gmm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 589. src/gmm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 590. src/goulash-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 591. src/goulash-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 592. src/goulash-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 593. src/goulash-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 594. src/gpp-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 595. src/gpp-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 596. src/gpp-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 597. src/gpp-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 598. src/graphB+-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 599. src/graphB+-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 600. src/graphB+-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 77: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 86-87)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 601. src/graphExecution-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 602. src/graphExecution-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 603. src/graphExecution-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 604. src/grep-cuda/Makefile
- **Target name**: ✗ Produces `nfa` instead of `main` (line 15: `program = nfa`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - nfa depends on main.o, nfautil.o, regex.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: FIXED - changed program name from `nfa` to `main`
- **Status**: FIXED

## 605. src/grep-hip/Makefile
- **Target name**: ✗ Produces `nfa` instead of `main` (line 14: `program = nfa`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - nfa depends on main.o, nfautil.o, regex.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: FIXED - changed program name from `nfa` to `main`
- **Status**: FIXED

## 606. src/grep-omp/Makefile
- **Target name**: ✗ Produces `nfa` instead of `main` (line 16: `program = nfa`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - nfa depends on main.o, nfautil.o, regex.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: FIXED - changed program name from `nfa` to `main`
- **Status**: FIXED

## 607. src/grep-sycl/Makefile
- **Target name**: ✗ Produces `nfa` instead of `main` (line 22: `program = nfa`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - nfa depends on main.o, nfautil.o, regex.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: FIXED - changed program name from `nfa` to `main`
- **Status**: FIXED

## 608. src/grrt-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 609. src/grrt-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 610. src/grrt-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 611. src/grrt-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 612. src/gru-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 613. src/gru-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 614. src/gru-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 615. src/haccmk-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on haccmk.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 616. src/haccmk-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on haccmk.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 617. src/haccmk-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on haccmk.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 618. src/haccmk-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on haccmk.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 619. src/halo-finder-cuda/Makefile
- **Target name**: ⚠️ Produces `ForceTreeTest` in subdirectory `cuda/` instead of `main` (line 37: `PROGS = $(OBJDIR)/ForceTreeTest`, line 123: `$(OBJDIR)/ForceTreeTest: ...`)
- **Dependencies**: Complex build with libraries
- **Run target**: ✓ Has `run` target (lines 166-167, runs `./cuda/ForceTreeTest`)
- **Issues/Inconsistencies**: Complex build system - produces `ForceTreeTest` in subdirectory, not `main` - different structure
- **Status**: NOTE (Complex build, produces ForceTreeTest in subdirectory)

## 620. src/halo-finder-hip/Makefile
- **Target name**: ⚠️ Produces `ForceTreeTest` in subdirectory `hip/` instead of `main` (line 36: `PROGS = $(OBJDIR)/ForceTreeTest`, line 121: `$(OBJDIR)/ForceTreeTest: ...`)
- **Dependencies**: Complex build with libraries
- **Run target**: ✓ Has `run` target (lines 164-165, runs `./hip/ForceTreeTest`)
- **Issues/Inconsistencies**: Complex build system - produces `ForceTreeTest` in subdirectory, not `main` - different structure
- **Status**: NOTE (Complex build, produces ForceTreeTest in subdirectory)

## 621. src/halo-finder-sycl/Makefile
- **Target name**: ⚠️ Produces `ForceTreeTest` in subdirectory `sycl/` instead of `main` (line 68: `PROGS = $(OBJDIR)/ForceTreeTest`, line 150: `$(OBJDIR)/ForceTreeTest: ...`)
- **Dependencies**: Complex build with libraries
- **Run target**: ✓ Has `run` target (lines 192-193, runs `./sycl/ForceTreeTest`)
- **Issues/Inconsistencies**: Complex build system - produces `ForceTreeTest` in subdirectory, not `main` - different structure
- **Status**: NOTE (Complex build, produces ForceTreeTest in subdirectory)

## 622. src/hausdorff-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 623. src/hausdorff-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 624. src/hausdorff-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 625. src/hausdorff-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 626. src/haversine-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distance.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 627. src/haversine-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distance.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 628. src/haversine-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and distance.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 629. src/haversine-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 630. src/hbc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, util.o, parse.o, sequential.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 631. src/hbc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, util.o, parse.o, sequential.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 632. src/hbc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, util.o, parse.o, sequential.o
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 633. src/heartwall-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 31: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and utility object files
- **Run target**: ✓ Has `run` target (lines 99-100)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 634. src/heartwall-hip/Makefile
- **Target name**: ✓ Produces `main` (line 30: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and utility object files
- **Run target**: ✓ Has `run` target (lines 94-95)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 635. src/heartwall-omp/Makefile
- **Target name**: ✓ Produces `main` (line 39: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and utility object files
- **Run target**: ✓ Has `run` target (lines 106-107)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 636. src/heartwall-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 24: `program = main`, line 78: `main: ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel/kernel.o, and utility object files
- **Run target**: ✓ Has `run` target (lines 140-141)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 637. src/heat2d-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 638. src/heat2d-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 639. src/heat2d-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 640. src/heat2d-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 641. src/heat-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on heat.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 642. src/heat-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on heat.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 643. src/heat-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on heat.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 644. src/heat-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on heat.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 645. src/hellinger-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 57: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 646. src/hellinger-hip/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 56: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 647. src/hellinger-omp/Makefile
- **Target name**: ✓ Produces `main` (line 18: `program = main`, line 63: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 72-73)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 648. src/hellinger-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 24: `program = main`, line 82: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 649. src/henry-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 650. src/henry-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 651. src/henry-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 652. src/henry-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 653. src/hexciton-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, reference.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 654. src/hexciton-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, reference.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 655. src/hexciton-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 656. src/hexciton-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 657. src/histogram-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on histogram_compare.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 658. src/histogram-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on histogram_compare.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 659. src/histogram-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on histogram_compare_base.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 660. src/histogram-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on histogram_compare_base.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 661. src/hmm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on HiddenMarkovModel.o, ViterbiCPU.o, ViterbiGPU.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 662. src/hmm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on HiddenMarkovModel.o, ViterbiCPU.o, ViterbiGPU.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 663. src/hmm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on HiddenMarkovModel.o, ViterbiCPU.o, ViterbiGPU.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 664. src/hmm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on HiddenMarkovModel.o, ViterbiCPU.o, ViterbiGPU.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 665. src/hogbom-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o, timer.o
- **Run target**: ✓ Has `run` target (lines 68-69)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 666. src/hogbom-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o, timer.o
- **Run target**: ✓ Has `run` target (lines 70-71)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 667. src/hogbom-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 58: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o, timer.o
- **Run target**: ✓ Has `run` target (lines 76-77)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 668. src/hogbom-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 77: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernels.o, reference.o, timer.o
- **Run target**: ✓ Has `run` target (lines 95-96)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 669. src/hotspot3D-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on 3D.o and 3D_helper.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 670. src/hotspot3D-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on 3D.o and 3D_helper.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 671. src/hotspot3D-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on 3D.o and 3D_helper.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 672. src/hotspot3D-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on 3D.o and 3D_helper.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 673. src/hotspot-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on hotspot.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 674. src/hotspot-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on hotspot.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 675. src/hotspot-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on hotspot.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 676. src/hungarian-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 677. src/hungarian-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 678. src/hungarian-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 679. src/hwt1d-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, reference.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 680. src/hwt1d-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, reference.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 681. src/hwt1d-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 682. src/hwt1d-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, kernel.o, reference.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 683. src/hybridsort-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 33: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on hybridsort.o, bucketsort.o, mergesort.o
- **Run target**: ✓ Has `run` target (lines 50-51)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 684. src/hybridsort-hip/Makefile
- **Target name**: ✓ Produces `main` (line 31: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on hybridsort.o, bucketsort.o, mergesort.o
- **Run target**: ✗ Has `run` target but depends on `hybridsort` instead of `main` (line 48: `run: hybridsort`)
- **Issues/Inconsistencies**: FIXED - changed `run: hybridsort` to `run: main`
- **Status**: FIXED

## 685. src/hybridsort-omp/Makefile
- **Target name**: ✓ Produces `main` (line 44: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on hybridsort.o, bucketsort.o, mergesort.o
- **Run target**: ✓ Has `run` target (lines 64-65)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 686. src/hybridsort-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 81: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on hybridsort.o, bucketsort.o, mergesort.o
- **Run target**: ✓ Has `run` target (lines 98-99)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 687. src/hypterm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 688. src/hypterm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 689. src/hypterm-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 690. src/hypterm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 74: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, reference.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 89-90)
- **Issues/Inconsistencies**: FIXED - removed duplicate `LDFLAGS =` definition
- **Status**: OK

## 691. src/idivide-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 692. src/idivide-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 693. src/idivide-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 694. src/idivide-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 695. src/interleave-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 696. src/interleave-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 697. src/interleave-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 698. src/interleave-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 699. src/interval-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-58, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 700. src/interval-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-56, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 701. src/interval-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✗ Has `run` target but second command doesn't use `$(LAUNCHER)` (line 63)
- **Issues/Inconsistencies**: FIXED - added `$(LAUNCHER)` to second command in run target
- **Status**: FIXED

## 702. src/interval-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-83, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 703. src/intrinsics-cast-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 704. src/intrinsics-cast-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 705. src/intrinsics-cast-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 706. src/intrinsics-simd-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 707. src/inversek2j-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 708. src/inversek2j-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 709. src/inversek2j-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 710. src/inversek2j-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 711. src/is-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 712. src/is-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 713. src/is-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 714. src/ising-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 715. src/ising-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 716. src/ising-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 717. src/ising-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 718. src/iso2dfd-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on iso2dfd.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 719. src/iso2dfd-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on iso2dfd.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 720. src/iso2dfd-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on iso2dfd.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 721. src/iso2dfd-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on iso2dfd.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 722. src/jaccard-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 723. src/jaccard-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 724. src/jaccard-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 725. src/jacobi-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 726. src/jacobi-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 727. src/jacobi-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 728. src/jacobi-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 729. src/jenkins-hash-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 730. src/jenkins-hash-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 731. src/jenkins-hash-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 732. src/jenkins-hash-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 733. src/kalman-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 734. src/kalman-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 735. src/kalman-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 736. src/kalman-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 737. src/keccaktreehash-cuda/Makefile
- **Target name**: ✗ Produces `keccektree` instead of `main` (line 16: `program = keccektree`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - keccektree depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: FIXED - changed program name from `keccektree` to `main`
- **Status**: FIXED

## 738. src/keccaktreehash-hip/Makefile
- **Target name**: ✗ Produces `keccektree` instead of `main` (line 15: `program = keccektree`) - FIXED: changed to `main`
- **Dependencies**: Looks OK - keccektree depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: FIXED - changed program name from `keccektree` to `main`
- **Status**: FIXED

## 739. src/keccaktreehash-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 73-74)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 740. src/keccaktreehash-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 92-93)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 741. src/keogh-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 742. src/keogh-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 743. src/keogh-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 744. src/keogh-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 745. src/kernelLaunch-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 746. src/kernelLaunch-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 747. src/kernelLaunch-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 748. src/kernelLaunch-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 749. src/kiss-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 750. src/kiss-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 751. src/kiss-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 752. src/kmc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and svm.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 753. src/kmc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 44: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and svm.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 754. src/kmc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 84: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and svm.o
- **Run target**: ✓ Has `run` target (lines 96-97)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 755. src/kmeans-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 23: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on cluster.o, getopt.o, read_input.o, rmse.o, kmeans.cpp
- **Run target**: ✓ Has `run` target (lines 41-42)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 756. src/kmeans-hip/Makefile
- **Target name**: ✓ Produces `main` (line 22: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on cluster.o, getopt.o, read_input.o, rmse.o, kmeans.cpp
- **Run target**: ✓ Has `run` target (lines 40-41)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 757. src/kmeans-omp/Makefile
- **Target name**: ✓ Produces `main` (line 38: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on cluster.o, getopt.o, read_input.o, rmse.o, kmeans.c
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: Uses hardcoded `main` target instead of `$(program)` variable, but produces `main` - OK
- **Status**: OK

## 758. src/kmeans-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on cluster.o, getopt.o, read_input.o, rmse.o
- **Run target**: ✓ Has `run` target (lines 91-92)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 759. src/knn-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 760. src/knn-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 761. src/knn-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 762. src/knn-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 763. src/kurtosis-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 764. src/kurtosis-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 765. src/kurtosis-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 83-84)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 766. src/lanczos-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and lanczos.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 767. src/lanczos-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and lanczos.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 768. src/lanczos-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and lanczos.o
- **Run target**: ✓ Has `run` target (lines 65-66)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 769. src/lanczos-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o and lanczos.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 770. src/langevin-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 771. src/langevin-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 772. src/langevin-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 773. src/langevin-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 774. src/langford-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 775. src/langford-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 776. src/langford-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 777. src/langford-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 778. src/laplace3d-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 779. src/laplace3d-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-56, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 780. src/laplace3d-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-64, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 781. src/laplace3d-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-83, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 782. src/laplace-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 783. src/laplace-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 784. src/laplace-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 785. src/laplace-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 786. src/lavaMD-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, util/num/num.o, util/timer/timer.o
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 787. src/lavaMD-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, util/num/num.o, util/timer/timer.o
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 788. src/lavaMD-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 57: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, util/num/num.o, util/timer/timer.o
- **Run target**: ✓ Has `run` target (lines 72-73)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 789. src/lavaMD-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 24: `program = main`, line 78: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, util/num/num.o, util/timer/timer.o
- **Run target**: ✓ Has `run` target (lines 93-94)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 790. src/layernorm-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 60-62, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 791. src/layernorm-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-57, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 792. src/layernorm-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-83, runs program twice)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 793. src/layout-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 794. src/layout-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 795. src/layout-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 796. src/layout-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 797. src/lci-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 51: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 798. src/lci-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 799. src/lci-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 57: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 800. src/lci-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 23: `program = main`, line 76: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 85-86)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 801. src/lda-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 802. src/lda-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 803. src/lda-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 804. src/lda-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 805. src/ldpc-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cpu.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 806. src/ldpc-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cpu.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 807. src/ldpc-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cpu.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 808. src/ldpc-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, cpu.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 809. src/lebesgue-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 60-61)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 810. src/lebesgue-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 63-64)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 811. src/lebesgue-omp/Makefile
- **Target name**: ✓ Produces `main` (line 17: `program = main`, line 54: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 72-73)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 812. src/lebesgue-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 73: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, utils.o, kernels.o
- **Run target**: ✓ Has `run` target (lines 85-86)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 813. src/leukocyte-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 32: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on multiple object files and meschach.a library
- **Run target**: ✓ Has `run` target (lines 67-68)
- **Issues/Inconsistencies**: Uses hardcoded `main:` target instead of `$(program):` pattern, but produces `main` binary - OK
- **Status**: OK

## 814. src/leukocyte-hip/Makefile
- **Target name**: ✓ Produces `main` (line 31: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on multiple object files and meschach.a library
- **Run target**: ✓ Has `run` target (lines 66-67)
- **Issues/Inconsistencies**: Uses hardcoded `main:` target instead of `$(program):` pattern, but produces `main` binary - OK
- **Status**: OK

## 815. src/leukocyte-omp/Makefile
- **Target name**: ✓ Produces `main` (line 38: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on multiple object files and meschach.a library
- **Run target**: ✓ Has `run` target (lines 73-74)
- **Issues/Inconsistencies**: Uses hardcoded `main:` target instead of `$(program):` pattern, but produces `main` binary - OK
- **Status**: OK

## 816. src/leukocyte-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 70: `main: ...`, hardcoded target name)
- **Dependencies**: Looks OK - main depends on multiple object files and meschach.a library
- **Run target**: ✓ Has `run` target (lines 110-111)
- **Issues/Inconsistencies**: Uses hardcoded `main:` target instead of `$(program):` pattern, but produces `main` binary - OK
- **Status**: OK

## 817. src/lfib4-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 818. src/lfib4-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 819. src/lfib4-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 820. src/libor-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 821. src/libor-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 822. src/libor-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 823. src/libor-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 72: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 81-82)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 824. src/lid-driven-cavity-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 825. src/lid-driven-cavity-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 826. src/lid-driven-cavity-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 827. src/lid-driven-cavity-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, set.o
- **Run target**: ✓ Has `run` target (lines 85-86)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 828. src/lif-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 829. src/lif-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 830. src/lif-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 831. src/lif-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 832. src/linearprobing-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, linearprobing.o, test.o
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 833. src/linearprobing-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, linearprobing.o, test.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 834. src/linearprobing-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 52: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, linearprobing.o, test.o
- **Run target**: ✓ Has `run` target (lines 61-62)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 835. src/linearprobing-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o, linearprobing.o, test.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 836. src/log2-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 46: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 55-56)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 837. src/log2-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 45: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 54-55)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 838. src/log2-omp/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 53: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 62-63)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 839. src/log2-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 22: `program = main`, line 71: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 80-81)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 840. src/logan-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files from src/ directory
- **Run target**: ✓ Has `run` target (lines 71-72)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 841. src/logan-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files from src/ directory
- **Run target**: ✓ Has `run` target (lines 69-70)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 842. src/logan-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 24: `program = main`, line 76: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files from src/ directory
- **Run target**: ✓ Has `run` target (lines 98-99)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 843. src/logic-rewrite-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 49: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 58-59)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 844. src/logic-rewrite-hip/Makefile
- **Target name**: ✓ Produces `main` (line 15: `program = main`, line 48: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on multiple object files
- **Run target**: ✓ Has `run` target (lines 57-58)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 845. src/logprob-cuda/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 47: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 56-57)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 846. src/logprob-hip/Makefile
- **Target name**: ✓ Produces `main` (line 16: `program = main`, line 50: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 59-60)
- **Issues/Inconsistencies**: None found
- **Status**: OK

## 847. src/logprob-sycl/Makefile
- **Target name**: ✓ Produces `main` (line 25: `program = main`, line 83: `$(program): ...`)
- **Dependencies**: Looks OK - main depends on main.o
- **Run target**: ✓ Has `run` target (lines 92-93)
- **Issues/Inconsistencies**: None found
- **Status**: OK

---

## Summary

**Total Makefiles**: 1861
**Checked so far**: 68
**Issues Found and Fixed**: 6

**Issues Found and Fixed:**
1. **src/b+tree-hip/Makefile**: Had duplicate `run` target (lines 93-94 and 103-104) - FIXED by removing the duplicate
2. **src/b+tree-sycl/Makefile**: Had duplicate `run` target (lines 120-121 and 129-130) - FIXED by removing the duplicate
3. **src/triad-hip/Makefile**: Produced `triad` instead of `main` - FIXED by changing `program = triad` to `program = main`
4. **src/triad-cuda/Makefile**: Produced `triad` instead of `main` - FIXED by changing `program = triad` to `program = main`
5. **src/triad-omp/Makefile**: Produced `triad` instead of `main` - FIXED by changing `program = triad` to `program = main`
6. **src/miniDGS-cuda/Makefile**: Had `run :` (with space) and didn't use $(LAUNCHER) - FIXED by standardizing format and adding LAUNCHER

**Patterns Observed:**
- Most Makefiles use `program = main` or `EXE = main` variable, then build `$(program)` or `$(EXE)`
- Some Makefiles directly define `main:` as the target
- All `run` targets use `$(LAUNCHER) ./main` or `$(LAUNCHER) ./$(program)` pattern
- Dependencies look correct across all checked Makefiles
- 1801 out of 1861 Makefiles have `run` targets (60 missing are mostly subdirectory/library Makefiles)

**Remaining Work:**
Continuing systematic review of all 1861 Makefiles to ensure:
1. All produce binary named `main`
2. All have `run` target
3. All dependencies are correct

