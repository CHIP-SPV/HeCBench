#ifndef DP_STDPAR_SHIM_H
#define DP_STDPAR_SHIM_H

// ---------------------------------------------------------------------------
// Minimal in-repo replacement for the one C++17 parallel-STL algorithm this
// benchmark uses on device memory.
//
// Upstream dp-hip calls
//
//     std::transform_reduce(std::execution::par_unseq,
//                           d_srcA, d_srcA + n, d_srcB, init);
//
// where d_srcA/d_srcB are *device* pointers from hipMalloc.  That only works
// under clang's `--hipstdpar` mode, which rewrites the libstdc++ parallel
// algorithms onto a separate "HIP Standard Parallelism Acceleration library"
// (rocThrust's hipstdpar headers).  chipStar does not ship that library, so
// --hipstdpar fails outright:
//
//     error: cannot find HIP Standard Parallelism Acceleration library
//
// We cannot legally add our own overloads inside namespace std for std types,
// and we do not want to depend on any external repository, so instead this
// header provides the same algorithm under our own namespace and the call site
// in main.cu is changed by one token.  The forwarding target is rocThrust,
// which chipStar does ship and whose HIP device backend works
// (-DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP, see the Makefile).
//
// Algorithms forwarded (this is the complete list used by dp-hip):
//
//   std::transform_reduce(par_unseq, first1, last1, first2, init)
//       -> thrust::inner_product(thrust::device, first1, last1, first2, init)
//
// thrust::inner_product is the exact two-range analogue: it computes
// init + sum(first1[i] * first2[i]) with thrust::plus/thrust::multiplies, i.e.
// the same default operations std::transform_reduce uses for this overload.
// The only observable difference is that thrust performs the multiply in the
// accumulator type (decltype(init)) rather than in the element type; that is
// never less accurate than the std:: version.
//
// Passing raw pointers together with an explicit thrust::device policy is the
// documented way to tell thrust they address device memory, which matches how
// --hipstdpar treats them.
// ---------------------------------------------------------------------------

#include <thrust/execution_policy.h>
#include <thrust/inner_product.h>

namespace stdpar_shim {

// Stand-ins for std::execution::par / par_unseq.  Both map to the same thrust
// device policy: thrust kernels are already unsequenced within a thread block,
// so par and par_unseq are indistinguishable here.
struct par_policy_t {};

inline constexpr par_policy_t par{};
inline constexpr par_policy_t par_unseq{};

template <typename InputIt1, typename InputIt2, typename T>
inline T transform_reduce(par_policy_t,
                          InputIt1 first1, InputIt1 last1,
                          InputIt2 first2, T init)
{
  return thrust::inner_product(thrust::device, first1, last1, first2, init);
}

}  // namespace stdpar_shim

#endif  // DP_STDPAR_SHIM_H
