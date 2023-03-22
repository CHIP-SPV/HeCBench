#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <random>
#include "common.h"

#define threadsPerBlock  256

template<memory_scope MemoryScope = memory_scope::device>
static inline
void gpuAtomicAddNoReturn(int32_t &address, int32_t val) {
  auto ao = atomic_ref<int32_t,
                       memory_order::relaxed,
                       MemoryScope,
    access::address_space::generic_space> (address);
  ao.fetch_add(val);
}

// Memory types used for the bincount implementations
enum class DeviceMemoryType { SHARED, GLOBAL };

template <typename input_t, typename IndexType>
static IndexType
getBin(input_t v, input_t minvalue, input_t maxvalue, IndexType nbins)
{
  IndexType bin = (v - minvalue) * nbins / (maxvalue - minvalue);
  // while each bin is inclusive at the lower end and exclusive at the higher,
  // i.e. [start, end) the last bin is inclusive at both, i.e. [start, end], in
  // order to include maxvalue if exists therefore when bin == nbins, adjust bin
  // to the last bin
  if (bin == nbins) bin--;
  return bin;
}

// Kernel for computing the histogram of the input
template <typename output_t,
          typename input_t,
          typename IndexType,
          DeviceMemoryType MemoryType>
void bincount (
  nd_item<1> &item,
       output_t *smem,
       output_t *output,
  const input_t *input,
  IndexType nbins,
  input_t minvalue,
  input_t maxvalue,
  IndexType input_size,
  IndexType output_size)
{
  IndexType lid = item.get_local_id(0);
  IndexType gid = item.get_group(0);
  IndexType wgs = item.get_local_range(0);
  IndexType wgr = item.get_group_range(0);

  if (MemoryType == DeviceMemoryType::SHARED) {
    // atomically add to block specific shared memory
    // then atomically add to the global output tensor
    for (IndexType i = lid; i < nbins; i += wgs) {
      smem[i] = 0;
    }
    item.barrier(sycl::access::fence_space::local_space);

    for (IndexType linearIndex = gid * wgs + lid;
                   linearIndex < input_size; linearIndex += wgr * wgs) {
      const auto v = input[linearIndex];

      if (v >= minvalue && v <= maxvalue) {
        const IndexType bin = getBin<input_t, IndexType>(
                              v, minvalue, maxvalue, nbins);
        gpuAtomicAddNoReturn<memory_scope::work_group>(smem[bin], 1);
      }
    }
    item.barrier(sycl::access::fence_space::local_space);

    // Atomically update output bin count.
    for (IndexType i = lid; i < nbins; i += wgs) {
      gpuAtomicAddNoReturn(output[i], smem[i]);
    }

  } else {
    ////////////////////////// Global memory //////////////////////////
    // atomically add to the output tensor
    // compute histogram for the block
    for (IndexType linearIndex = gid * wgs + lid;
                   linearIndex < input_size; linearIndex += wgr * wgs) {
      const auto v = input[linearIndex];
      if (v >= minvalue && v <= maxvalue) {
        const IndexType bin = getBin<input_t, IndexType>(
                              v, minvalue, maxvalue, nbins);
        gpuAtomicAddNoReturn(output[bin], 1);
      }
    }
  }
}

#define HANDLE_CASE(MEMORY_TYPE, SHARED_MEM)                         \
  auto start = std::chrono::steady_clock::now();                     \
  for (int i = 0; i < repeat; i++)                                   \
    q.submit([&](handler& cgh) {                                     \
      accessor<output_t, 1, sycl_read_write, access::target::local>  \
        sm (SHARED_MEM, cgh);                                        \
      cgh.parallel_for(nd_range<1>(gws, lws), [=] (nd_item<1> item) {\
      bincount<output_t, input_t, IndexType, MEMORY_TYPE>(           \
        item,                                                        \
        sm.get_pointer(),                                            \
        d_output,                                                    \
        d_input,                                                     \
        nbins,                                                       \
        minvalue,                                                    \
        maxvalue,                                                    \
        input_size,                                                  \
        output_size);                                                \
      });                                                            \
    });                                                              \
  q.wait();                                                          \
  auto end = std::chrono::steady_clock::now();                       \
  auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count(); \
  printf("Average execution time of bincount kernel: %f (us)\n",     \
         (time * 1e-3f) / repeat)

#define HANDLE_SWITCH_CASE(mType)                           \
  switch (mType) {                                          \
    case DeviceMemoryType::SHARED: {                        \
      HANDLE_CASE(DeviceMemoryType::SHARED, nbins);         \
      break;                                                \
    }                                                       \
    default: {                                              \
      HANDLE_CASE(DeviceMemoryType::GLOBAL, 0);             \
    }                                                       \
  }

/*
  Calculate the frequency of the input values.
  3 implementations based of input size and memory usage:
    case: sufficient shared mem
        SHARED: Each block atomically adds to it's own **shared** hist copy,
        then atomically updates the global tensor.
    case: insufficient shared memory
        GLOBAL: all threads atomically update to a single **global** hist copy.
 */
template <typename output_t, typename input_t, typename IndexType>
void eval(IndexType input_size, int repeat)
{
  size_t input_size_bytes = sizeof(input_t) * input_size;

  input_t *input = (input_t*) malloc (input_size_bytes); 

  std::default_random_engine generator (123);
  std::normal_distribution<input_t> distribution(5.0,2.0);
  for (int i = 0; i < input_size; i++) {
    input[i] = distribution(generator);
  }

  auto min_iter = std::min_element(input, input+input_size);
  auto max_iter = std::max_element(input, input+input_size);
  
  input_t minvalue = *min_iter;
  input_t maxvalue = *max_iter;
  printf("Input min, max values: (%f %f)\n", (float)minvalue, (float)maxvalue);

#ifdef USE_GPU
  gpu_selector dev_sel;
#else
  cpu_selector dev_sel;
#endif
  queue q(dev_sel);

  input_t *d_input = malloc_device<input_t>(input_size, q);
  q.memcpy(d_input, input, input_size_bytes).wait();

  int maxSharedMemory = q.get_device().get_info<info::device::local_mem_size>();

  printf("Maximum shared local memory size per block in bytes: %d\n", maxSharedMemory);

  for (IndexType nbins = 768; nbins <= 768 * 32; nbins = nbins * 2) {

    printf("\nNumber of bins: %d\n", nbins);
    IndexType sharedMem = nbins * sizeof(output_t);

    IndexType output_size = nbins;
    size_t output_size_bytes = sizeof(output_t) * output_size;
    output_t *output = (output_t*) malloc (output_size_bytes); 

    output_t *d_output = malloc_device<output_t>(output_size, q);
    q.memset(d_output, 0, output_size_bytes).wait();

    range<1> gws ((input_size + threadsPerBlock - 1) / threadsPerBlock * threadsPerBlock);
    range<1> lws (threadsPerBlock);

    // determine memory type to use in the kernel
    DeviceMemoryType memType = DeviceMemoryType::GLOBAL;
    printf("bincount using global atomics\n");
    HANDLE_SWITCH_CASE(memType)

    if (sharedMem <= maxSharedMemory) {
      printf("bincount using global and local atomics\n");
      memType = DeviceMemoryType::SHARED;
      HANDLE_SWITCH_CASE(memType)
    }

    q.memcpy(output, d_output, output_size_bytes).wait();
    auto min_iter = std::min_element(output, output+output_size);
    auto max_iter = std::max_element(output, output+output_size);
    output_t minvalue = *min_iter;
    output_t maxvalue = *max_iter;
    printf("Output min, median, max values: (%ld %ld %ld)\n",
           (int64_t)minvalue / repeat,
           (int64_t)output[output_size/2] / repeat,
           (int64_t)maxvalue / repeat);

    free(d_output, q);
    free(output);
  }

  free(d_input, q);
  free(input);
}

int main(int argc, char* argv[])
{
  if (argc != 3) {
    printf("Usage: %s <number of elements> <repeat>\n", argv[0]);
    return 1;
  }
  const int n = atoi(argv[1]);
  const int repeat = atoi(argv[2]);

  eval<int32_t, float, int32_t>(n, repeat);

  return 0; 
}
