# Current Changes in Modified Files

This document lists all files that have been modified and describes what changes remain (excluding return code handling which has been removed).

## Updates (most recent)

- Reverted all verification print changes (e.g., MISMATCH ↔ PASS/FAIL) back to their original forms. Affected highlights:
  - `src/ans-hip/src/main.cu`, `src/ans-sycl/src/main.cc`: restored MISMATCH output.
  - `src/all-pairs-distance-hip/main.cu`: removed duplicated PASS/FAIL blocks; kept original single check.
  - `src/mr-hip/main.cu`, `src/mr-sycl/main.cpp`: moved PASS/FAIL print back to original position.
  - `src/f16max-hip/main.cu`, `src/f16max-sycl/main.cpp`: verification restored to original variable (`ok`).
  - `src/present-hip/main.cu`, `src/present-sycl/main.cpp`: PASS/FAIL check placed before frees as originally.
  - `src/tensorT-hip/main.cu`, `src/tensorT-sycl/main.cpp`: removed added FAIL branch; preserved original PASS-only print on success.
  - `src/ced-hip/main.cu`, `src/ced-sycl/main.cpp`: simplified to original PASS + return 0 flow.
  - `src/atomicReduction-hip/reduction.cu`, `src/atomicReduction-sycl/reduction.cpp`: restored VERIFICATION messages to PASS/FAIL!! where applicable.
  - `src/dct8x8-sycl/main.cpp`: removed added returns from Verify; kept PASS/FAIL prints only.
  - `src/linearprobing-cuda/test.cu`, `src/linearprobing-omp/test.cpp`: removed added "FAIL:" prefix.

## Summary of Change Types

1. **Makefile flags**: Removed optimization flags like `-ffast-math` and `-munsafe-fp-atomics`
2. **Work group size**: Modified SYCL work group/local size parameters
3. **Memory operations**: Changed `hipMemcpy` to `hipMemcpyAsync` for async memory transfers
4. **Verification**: Added tolerance-based verification or modified verification output messages
5. **Kernel code**: Moved kernels inline or refactored kernel code
6. **Code structure**: Modified function signatures, includes, or code organization
7. **Algorithm changes**: Significant algorithm modifications
8. **Scripts**: Updated Python scripts for benchmarking/comparison

---
## src/aes-sycl/main.cpp

- **Work group size**: Changed work group configuration

## src/aidw-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/aidw-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/all-pairs-distance-hip/main.cu

- **Output messages**: Restored to a single original PASS/FAIL check (removed duplicates)

## src/ans-hip/src/main.cu

- **Output messages**: Restored original 'MISMATCH' output

## src/ans-sycl/src/main.cc

- **Output messages**: Restored original 'MISMATCH' output

## src/asmooth-hip/main.cu

- **Memory operations**: Changed 3 memcpy calls to async versions

## src/asmooth-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/asmooth-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/atomicCost-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/atomicReduction-hip/reduction.cu

- **Kernel code**: Moved kernels inline (was previously in separate file)
- **Includes**: Added 5, removed 1 header includes
- **Algorithm**: Significant algorithm changes (kernel launches, atomic operations)
- **Code structure**: Modified function signatures or structure
- **Scale**: Large refactoring (+167/-40 lines)

## src/atomicReduction-sycl/reduction.cpp

- **Work group size**: Changed work group configuration
- **Includes**: Added 5, removed 1 header includes
- **Algorithm**: Significant algorithm changes (kernel launches, atomic operations)
- **Code structure**: Modified function signatures or structure
- **Scale**: Large refactoring (+227/-87 lines)

## src/binomial-cuda/binomialOptions.h


## src/binomial-hip/binomialOptions.h


## src/bitcracker-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/bitcracker-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/bitonic-sort-hip/main.cu


## src/bitonic-sort-sycl/main.cpp

- **Code structure**: Modified function signatures or structure

## src/bitpacking-hip/main.cu

- **Output messages**: No change vs original after print revert

## src/bitpacking-sycl/main.cpp

- **Output messages**: No change vs original after print revert

## src/bscan-hip/main-wave64.cu


## src/bscan-sycl/main.cpp


## src/bspline-vgh-hip/main.cu

- **Memory operations**: Changed 9 memcpy calls to async versions

## src/b+tree-hip/Makefile

- **Makefile**: Configuration changes

## src/b+tree-sycl/Makefile

- **Makefile**: Configuration changes

## src/ced-cuda/Makefile

- **Makefile**: Configuration changes

## src/ced-hip/main.cu

- **Output messages**: Simplified to original PASS + return 0
## src/ced-sycl/main.cpp

- **Output messages**: Simplified to original PASS + return 0
## src/chi2-hip/Makefile

- **Makefile**: Configuration changes

## src/colorwheel-hip/main.cu

- **Verification**: Added tolerance-based verification (allows small floating-point differences)

## src/colorwheel-sycl/main.cpp

- **Verification**: Added tolerance-based verification (allows small floating-point differences)

## src/columnarSolver-hip/main.cu


## src/columnarSolver-sycl/main.cpp


## src/cooling-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/cooling-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/dct8x8-hip/main.cu


## src/dct8x8-sycl/main.cpp

- **Output messages**: Removed added returns from Verify (kept PASS/FAIL prints)

## src/diamond-hip/masking.cu


## src/dslash-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/eigenvalue-hip/main.cu


## src/eigenvalue-sycl/main.cpp


## src/entropy-hip/main.cu


## src/entropy-sycl/main.cpp


## src/f16max-hip/main.cu

- **Output messages**: Restored verification to original variable/logic

## src/f16max-sycl/main.cpp

- **Output messages**: Restored verification to original variable/logic

## src/fft-hip/main.cu


## src/fft-sycl/fft1D_512.sycl


## src/fft-sycl/ifft1D_512.sycl


## src/floydwarshall-hip/main.cu


## src/floydwarshall-sycl/main.cpp


## src/fresnel-hip/main.cu


## src/fresnel-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/fresnel-sycl/main.cpp


## src/fresnel-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/frna-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/frna-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/gabor-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/gabor-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/gabor-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/goulash-hip/main.cu


## src/goulash-sycl/main.cpp


## src/grrt-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/haversine-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/heartwall-hip/Makefile

- **Makefile**: Configuration changes

## src/heartwall-sycl/kernel/kernel.cpp

- **Includes**: Added 1, removed 0 header includes

## src/heartwall-sycl/main.c


## src/heartwall-sycl/Makefile

- **Makefile**: Configuration changes

## src/heat2d-cuda/Makefile

- **Makefile**: Configuration changes

## src/heat2d-hip/main.cu

- **Output messages**: Modified verification output format
- **Kernel code**: Moved kernels inline (was previously in separate file)
- **Includes**: Added 5, removed 1 header includes
- **Code structure**: Modified function signatures or structure

## src/heat2d-sycl/main.cpp

- **Work group size**: Changed work group configuration
- **Output messages**: Modified verification output format
- **Includes**: Added 4, removed 1 header includes
- **Code structure**: Modified function signatures or structure

## src/hellinger-cuda/verify.h


## src/hellinger-hip/main.cu


## src/hellinger-sycl/main.cpp


## src/henry-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/henry-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/hogbom-cuda/main.cpp


## src/hwt1d-hip/main.cu


## src/hwt1d-sycl/main.cpp


## src/hybridsort-hip/hybridsort.cu


## src/hybridsort-sycl/hybridsort.c


## src/hybridsort-sycl/Makefile

- **Makefile**: Configuration changes

## src/is-cuda/is.h


## src/is-cuda/kernels.h

- **Output messages**: Modified verification output format

## src/is-hip/main.cu


## src/is-sycl/kernels.h

- **Output messages**: Modified verification output format

## src/is-sycl/main.cpp


## src/keogh-hip/main.cu


## src/keogh-sycl/main.cpp


## src/kmeans-hip/Makefile

- **Makefile**: Configuration changes

## src/langevin-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/langevin-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/langevin-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/layout-hip/main.cu


## src/leukocyte-sycl/Makefile

- **Makefile**: Configuration changes

## src/lfib4-hip/main.cu

- **Output messages**: Modified verification output format

## src/lfib4-sycl/main.cpp

- **Work group size**: Modified work group/local size parameters
- **Output messages**: Modified verification output format
- **Code structure**: Modified function signatures or structure

## src/linearprobing-cuda/test.cu


## src/linearprobing-omp/test.cpp


## src/logan-cuda/Makefile

- **Makefile**: Configuration changes

## src/logan-hip/Makefile

- **Makefile**: Configuration changes

## src/logan-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/lud-cuda/common/common.cpp


## src/lud-hip/lud.cu


## src/lud-sycl/lud.cpp


## src/mandelbrot-hip/mandel.hpp

- **Verification**: Added tolerance-based verification (allows small floating-point differences)

## src/mandelbrot-sycl/mandel.hpp

- **Verification**: Added tolerance-based verification (allows small floating-point differences)

## src/marchingCubes-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/matern-hip/main.cu


## src/matern-sycl/main.cpp

- **Work group size**: Modified work group/local size parameters

## src/meanshift-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/miniFE-hip/src/make_targets


## src/minisweep-hip/main.cu


## src/minisweep-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/minisweep-sycl/main.cpp


## src/minkowski-hip/main.cu


## src/minkowski-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/minkowski-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/mis-hip/main.cu


## src/mis-sycl/main.cpp


## src/mr-hip/main.cu

- **Output messages**: Restored PASS/FAIL print position to original

## src/mriQ-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/mriQ-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/mriQ-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/mr-sycl/main.cpp

- **Output messages**: Restored PASS/FAIL print position to original

## src/myocyte-hip/define.h


## src/myocyte-hip/kernel_cam.cu


## src/myocyte-hip/kernel_ecc.cu


## src/myocyte-hip/master.cu

- **Memory operations**: Changed 4 memcpy calls to async versions

## src/nbnxm-cuda/main.cu


## src/nbnxm-hip/main.cu


## src/nbnxm-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/nbnxm-sycl/main.cpp


## src/nlll-hip/main.cu


## src/nlll-sycl/main.cpp


## src/nonzero-hip/main.cu

- **Output messages**: Modified verification output format

## src/nonzero-sycl/main.cpp

- **Output messages**: Modified verification output format

## src/nw-hip/nw.cu

- **Output messages**: Modified verification output format

## src/nw-sycl/nw.cpp

- **Output messages**: Modified verification output format

## src/overlay-hip/main.cu


## src/overlay-sycl/main.cpp


## src/p4-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/pad-hip/main.cu

- **Memory operations**: Changed 2 memcpy calls to async versions

## src/perplexity-hip/main.cu


## src/perplexity-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/perplexity-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/perplexity-sycl/main.cpp


## src/pns-cuda/petri.h


## src/pns-omp/petri.h


## src/pool-sycl/main.cpp


## src/present-hip/main.cu


## src/present-sycl/main.cpp


## src/prna-hip/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/prna-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/quicksort-hip/main.cu


## src/quicksort-sycl/main.cpp


## src/radixsort-hip/main.cu


## src/radixsort-sycl/main.cpp


## src/romberg-hip/main.cu

- **Output messages**: Modified verification output format

## src/romberg-sycl/main.cpp

- **Output messages**: Modified verification output format

## src/rsbench-cuda/Makefile

- **Makefile**: Configuration changes

## src/rtm8-hip/rtm8.cu


## src/rtm8-sycl/rtm8.cpp


## src/scan2-hip/main.cu


## src/scan2-sycl/main.cpp


## src/scan-hip/main.cu

- **Output messages**: Modified verification output format
- **Kernel code**: Moved kernels inline (was previously in separate file)
- **Code structure**: Modified function signatures or structure
- **Scale**: Large refactoring (+90/-106 lines)

## src/scan-sycl/main.cpp


## src/scel-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/scripts/autohecbench-compare.py

- **Script**: Updated benchmarking comparison script
- **Algorithm**: Changed from averaging multiple results to using single result per benchmark
- **Dependencies**: Added custom geometric mean function (replaced statistics.geometric_mean)

## src/sheath-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/snake-hip/main.cu

- **Output messages**: Modified verification output format

## src/sobel-hip/main.cu


## src/sobel-sycl/main.cpp


## src/softmax-hip/main.cu

- **Includes**: Added 0, removed 1 header includes
- **Code structure**: Modified function signatures or structure

## src/softmax-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/split-hip/main.cu


## src/split-sycl/main.cpp


## src/srad-hip/Makefile

- **Makefile**: Configuration changes

## src/srad-sycl/Makefile

- **Makefile**: Configuration changes

## src/ss-hip/main.cu

- **Output messages**: Modified verification output format

## src/sssp-hip/main.cu

- **Output messages**: Modified verification output format

## src/sssp-sycl/main.cpp

- **Output messages**: Modified verification output format

## src/ss-sycl/main.cpp


## src/stddev-hip/main.cu


## src/stddev-hip/Makefile

- **Makefile flags**: Removed `-munsafe-fp-atomics` flag

## src/stddev-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/stddev-sycl/main.cpp


## src/stencil1d-hip/Makefile

- **Makefile**: Configuration changes

## src/stencil1d-hip/stencil_1d.cu


## src/stencil1d-sycl/stencil_1d.cpp


## src/streamcluster-hip/Makefile

- **Makefile**: Configuration changes

## src/streamcluster-hip/streamcluster.cu


## src/svd3x3-cuda/main.cu


## src/svd3x3-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/svd3x3-sycl/main.cpp


## src/tensorAccessor-hip/main.cu


## src/tensorAccessor-sycl/main.cpp


## src/tensorT-hip/main.cu


## src/tensorT-sycl/main.cpp


## src/tsp-omp/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/tsp-sycl/Makefile

- **Makefile flags**: Removed `-ffast-math` flag

## src/urng-hip/main.cu


## src/urng-sycl/main.cpp


## src/vanGenuchten-hip/main.cu


## src/vanGenuchten-sycl/main.cpp


## src/wordcount-sycl/main.cpp


## src/wyllie-hip/main.cu

- **Output messages**: Modified verification output format

## src/wyllie-sycl/main.cpp

- **Output messages**: Modified verification output format


---

## Detailed Changes for Selected Files

### src/aes-sycl/main.cpp

Changed local work size from `(4, 1)` to `(1, 1)`:
```cpp
-  sycl::range<2> lws (4, 1);
+  sycl::range<2> lws (1, 1);
```

### src/scripts/autohecbench-compare.py

- Added geometric mean calculation function
- Changed from averaging multiple results to using single result per benchmark
- Updated geomean calculation to use custom function instead of statistics module

### src/heat2d-hip/main.cu

- Removed `<utility>` include, added `defs.h` include
- Inlined kernel code from separate files (`io.c`, `lapl_ss.c`)
- Removed `reference()` function (OpenMP-based CPU reference)
- Modified `usage()` function to include `IN_FILE` parameter
- Changed function signatures (e.g., `Lx, Ly` to `lx, ly` in `dev_lapl_iter`)
- Added `#define OPT` for optimized GPU kernel

