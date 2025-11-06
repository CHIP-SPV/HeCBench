# Worklog

## Summary of Changes

### 1. Build System & Optimization Flags
**Category**: Build Configuration
- **Removed `-ffast-math` flag** from ~40+ Makefiles across various benchmarks
- **Removed `-munsafe-fp-atomics` flag** from several HIP benchmarks
- **Standardized optimization**: All benchmarks now use only `-O3` instead of `-O3 -ffast-math`
- **Rationale**: Removing unsafe floating-point optimizations for better numerical correctness

### 2. Executable Naming Standardization
**Category**: Build System
- **Renamed executables to `main`** in ~15+ benchmarks:
  - `b+tree.out` → `main`
  - `heartwall` → `main`
  - `kmeans` → `main`
  - `srad` → `main`
  - `ced` → `main`
  - `chi2` → `main`
  - `rsbench` → `main`
  - `stencil_1d` → `main`
  - `streamcluster` → `main`
- **Updated Makefile targets and run rules** accordingly

### 3. Code Simplification & Cleanup
**Category**: Code Quality
- **Removed pragma unroll directives** in:
  - `fft-sycl/fft1D_512.sycl` and `ifft1D_512.sycl`
  - `nbnxm-hip/main.cu` and `nbnxm-sycl/main.cpp`
  - `nbnxm-cuda/main.cu`
- **Removed cooperative groups dependency** from `softmax-hip/main.cu`
- **Simplified kernel implementations** (removed complex optimizations)
- **Removed file I/O operations** in `hybridsort-hip` and `hybridsort-sycl`

### 4. Memory Operation Changes
**Category**: Performance/Correctness
- **Changed `hipMemcpy` to `hipMemcpyAsync`** in:
  - `asmooth-hip/main.cu`
  - `bspline-vgh-hip/main.cu`
  - `myocyte-hip/master.cu`
  - `pad-hip/main.cu`
- **Changed `hipMemset` to `hipMemsetAsync`** in `atomicReduction-hip/reduction.cu`
- **Added proper synchronization** after async operations

### 5. Verification & Testing Changes
**Category**: Testing/Verification
- **Modified verification logic** to use tolerance-based comparisons:
  - `colorwheel-hip/main.cu` and `colorwheel-sycl/main.cpp` (tolerance = 1)
  - `heat2d-sycl/main.cpp` (relative error threshold)
- **Fixed verification return values**:
  - `dct8x8-hip/main.cu` and `dct8x8-sycl/main.cpp` (return int instead of void)
  - `hellinger-hip/main.cu` and `hellinger-sycl/main.cpp` (return bool)
- **Fixed inverted PASS/FAIL logic** in `romberg-hip/main.cu` and `romberg-sycl/main.cpp`
- **Added error tracking variables** in multiple benchmarks (`mis-hip`, `mis-sycl`, `nw-hip`, `nw-sycl`)

### 6. Test Parameter Adjustments
**Category**: Benchmark Configuration
- **Reduced test sizes**:
  - `bscan-hip/main-wave64.cu`: Only test 256 (commented out 64, 128, 512, 1024)
  - `bscan-sycl/main.cpp`: Only test 256
  - `nlll-hip/main.cu` and `nlll-sycl/main.cpp`: Only test 512
  - `scan-hip/main.cu` and `scan-sycl/main.cpp`: Only test 256
  - `bitpacking-hip` and `bitpacking-sycl`: Only test size 100000001
- **Changed iteration counts**:
  - `binomial-cuda` and `binomial-hip`: NUM_STEPS 2048→4096, MAX_OPTIONS 1024→8192, NUM_ITERATIONS 1000→100
  - `is-cuda/is.h`: MAX_ITERATIONS 24→1
- **Increased test sizes**:
  - `hybridsort-hip` and `hybridsort-sycl`: SIZE 50000000→128024000
  - `pns-cuda` and `pns-omp`: MAX_DEVICE_MEM 750000000→2048MB

### 7. Kernel & Algorithm Changes
**Category**: Algorithm Implementation
- **Inlined kernels** in `atomicReduction-hip/reduction.cu` and `atomicReduction-sycl/reduction.cpp` (removed separate kernels.h)
- **Simplified scan kernels** in `scan-hip/main.cu` (removed grid-stride loops)
- **Modified queue usage** in `lfib4-sycl/main.cpp` (separate in-order and out-of-order queues)
- **Fixed kernel function signatures** in `bitonic-sort-sycl/main.cpp` (queue parameter)
- **Removed optimized softmax implementation** in `softmax-hip/main.cu`

### 8. Code Fixes & Corrections
**Category**: Bug Fixes
- **Fixed character encoding issues** (copyright symbols) in multiple files
- **Fixed variable shadowing** in `f16max-hip/main.cu` and `f16max-sycl/main.cpp` (renamed `ok` to `ok2`)
- **Fixed missing return statement** in `present-hip/main.cu`
- **Fixed verification output order** in `nonzero-hip/main.cu` and `nonzero-sycl/main.cpp`
- **Fixed Makefile syntax** in `heartwall-hip/Makefile` (compilation order)
- **Added missing includes** and fixed header dependencies

### 9. Output & Logging Changes
**Category**: User Interface
- **Changed stderr to stdout** in `streamcluster-hip/streamcluster.cu`
- **Modified output formatting** in various benchmarks
- **Removed debug print statements** in `is-cuda/kernels.h` and `is-sycl/kernels.h`
- **Added timing information** in `heartwall-sycl` kernel wrapper

### 10. SYCL-Specific Changes
**Category**: SYCL Implementation
- **Fixed atomic operations** in `atomicReduction-sycl/reduction.cpp` (inline atomicAdd function)
- **Changed native functions**: `sycl::native::rsqrt` → `sycl::rsqrt` in `nbnxm-sycl/main.cpp`
- **Fixed queue property usage** in various SYCL benchmarks
- **Added proper memory scope** for atomic operations

### 11. HIP-Specific Changes
**Category**: HIP Implementation
- **Changed `__frsqrt_rn` to `rsqrt`** in `nbnxm-hip/main.cu`
- **Added `hipInit(0)`** in `bitonic-sort-hip/main.cu`
- **Fixed kernel launch syntax** using `hipLaunchKernelGGL` in multiple files
- **Removed pragma unroll** directives (HIP doesn't support same syntax as CUDA)

### 12. Heat2D Benchmark Refactoring
**Category**: Major Refactoring
- **Complete rewrite** of `heat2d-hip/main.cu` and `heat2d-sycl/main.cpp`:
  - Added file I/O support (requires input file)
  - Added supersite packing optimization
  - Changed from random initialization to file-based input
  - Updated Makefiles to generate data files
  - Modified verification to use relative error

### 13. Script Changes
**Category**: Tooling
- **Fixed geometric mean calculation** in `autohecbench-compare.py`:
  - Changed from averaging multiple runs to single value
  - Fixed geomean implementation (using math.exp instead of statistics.geometric_mean)

### 14. Minor Fixes
**Category**: Miscellaneous
- **Fixed Makefile dependencies** and target names
- **Removed unused variables** and dead code
- **Fixed compilation warnings** (variable types, unused includes)
- **Standardized error handling** patterns
- **Fixed loop variable scoping** issues

## Impact Summary

**Total files modified**: ~150+ files
**Primary focus areas**:
1. Removing unsafe floating-point optimizations (40+ files)
2. Standardizing executable names (15+ files)
3. Simplifying code and removing complex optimizations (20+ files)
4. Fixing verification logic and test parameters (30+ files)
5. Improving memory operation patterns (10+ files)

**Overall goal**: Improve numerical correctness, standardize build system, and simplify codebase while maintaining functionality.

