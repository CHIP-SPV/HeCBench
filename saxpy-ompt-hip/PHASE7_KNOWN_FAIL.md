# saxpy-ompt-hip — OUT OF SCOPE for the chipStar sweep

Not a HIP benchmark: the kernels are OpenMP target-offload pragmas
(#pragma omp target teams distribute), compiled by clang's OpenMP offload
driver against the ROCm device library ("-hip" in the name only denotes the
offload target vendor). It never uses the HIP API chipStar implements, so a
chipStar sweep must skip it — its build failure ("cannot find ROCm device
library for ABI version 6") is about the AMD OpenMP toolchain, not chipStar.
Same applies to saxpy-ompt-cuda / saxpy-ompt-sycl for their targets.
