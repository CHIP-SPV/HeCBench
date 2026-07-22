#ifndef GLM_HIP_SHIM_H
#define GLM_HIP_SHIM_H

// GLM <= 0.9.9.8 (e.g. the Ubuntu system package) only adds
// "__device__ __host__" qualifiers to its functions when it detects
// nvcc via __CUDACC__; native HIP detection was only added in later
// GLM releases.  Without the qualifiers, every glm::dot/cross/... call
// inside a __global__ kernel fails with "call to __host__ function
// from __global__ function".
//
// Define __CUDACC__ only while the GLM headers are being processed
// (this file is force-included via -include before any other code) so
// the HIP runtime headers never see it.  CUDA_VERSION/GLM_FORCE_CUDA
// stop GLM from trying to include <cuda.h>.
#if defined(__HIP__) && !defined(__CUDACC__)
  #define __CUDACC__
  #define GLM_FORCE_CUDA
  #ifndef CUDA_VERSION
    #define CUDA_VERSION 8000
  #endif
  #include <glm/glm.hpp>
  // GLM 0.9.9.8 bug: gtc/type_ptr.inl defines make_vec1..make_vec4 with
  // plain `inline` while type_ptr.hpp declares them GLM_FUNC_DECL
  // (= __device__ __host__ under CUDA); clang rejects the qualifier
  // mismatch (nvcc tolerated it).  type_ptr and its dependencies
  // (gtc/quaternion, gtc/vec1) are only used in host code here, so
  // process them without the CUDA qualifiers.
  #pragma push_macro("GLM_FUNC_DECL")
  #pragma push_macro("GLM_FUNC_QUALIFIER")
  #undef GLM_FUNC_DECL
  #define GLM_FUNC_DECL
  #undef GLM_FUNC_QUALIFIER
  #define GLM_FUNC_QUALIFIER inline
  #include <glm/gtc/type_ptr.hpp>
  #pragma pop_macro("GLM_FUNC_QUALIFIER")
  #pragma pop_macro("GLM_FUNC_DECL")
  #undef __CUDACC__
#else
  #include <glm/glm.hpp>
  #include <glm/gtc/type_ptr.hpp>
#endif

#endif // GLM_HIP_SHIM_H
