#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <hip/hip_runtime.h>
#include "utils.h"

// One pointer-jumping step. The original code did a `while (not_converged)`
// loop with `__syncthreads()` inside, which deadlocks Intel GPUs once threads
// diverge — and even on CUDA it relied on lucky cross-block scheduling, since
// __syncthreads() only synchronises within a block. We split iterations across
// kernel launches: the kernel-launch boundary provides grid-wide sync.
__global__
void wyllie_step ( long *in , long *out , const int size )
{
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  if (index >= size) return;
  long node = in[index];
  long temp = node;
  if ((node >> 32) != NIL) {
    long next = in[node >> 32];
    if ((next >> 32) != NIL) {
      temp  = (node & MASK);
      temp += (next & MASK);
      temp += (next >> 32) << 32;
    }
  }
  out[index] = temp;
}

// Smallest n such that (1 << n) >= x.
static inline int ceil_log2(int x) {
  int n = 0;
  while ((1 << n) < x) ++n;
  return n;
}

int main(int argc, char* argv[]) {
  if (argc != 4) {
    printf("Usage: ./%s <list size> <0 or 1> <repeat>", argv[0]);
    printf("0 and 1 indicate an ordered list and a random list, respectively\n");
    exit(-1);
  }

  int elems = atoi(argv[1]);
  int setRandomList = atoi(argv[2]);
  int repeat = atoi(argv[3]);
  int i;

  std::vector<int> next (elems);
  std::vector<int> rank (elems);
  std::vector<long> list (elems);
  std::vector<long> d_res (elems);
  std::vector<long> h_res (elems);

  // generate an array in which each element contains the index of the next element
  if (setRandomList)
    random_list(next);
  else
    ordered_list(next);

  // initialize the rank list
  for (i = 0; i < elems; i++) {
    rank[i] = next[i] == NIL ? 0 : 1;
  }

  // pack next and rank as a 64-bit number
  for (i = 0; i < elems; i++) list[i] = ((long)next[i] << 32) | rank[i];

  // run list ranking on a device
  long *d_a, *d_b;
  hipMalloc((void**)&d_a, sizeof(long) * elems);
  hipMalloc((void**)&d_b, sizeof(long) * elems);

  dim3 grid ((elems + 255)/256);
  dim3 block (256);
  const int max_steps = ceil_log2(elems) + 1;

  double time = 0.0;

  for (i = 0; i <= repeat; i++) {
    hipMemcpy(d_a, list.data(), sizeof(long) * elems, hipMemcpyHostToDevice);

    hipDeviceSynchronize();
    auto start = std::chrono::steady_clock::now();

    long *in = d_a, *out = d_b;
    for (int step = 0; step < max_steps; ++step) {
      hipLaunchKernelGGL(wyllie_step, grid, block, 0, 0, in, out, elems);
      long *tmp = in; in = out; out = tmp;
    }

    hipDeviceSynchronize();
    auto end = std::chrono::steady_clock::now();
    if (i > 0) time += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    // After max_steps swaps, `in` holds the final result.
    if (i == repeat) hipMemcpy(d_res.data(), in, sizeof(long) * elems, hipMemcpyDeviceToHost);
  }

  printf("Average kernel execution time: %f (ms)\n", (time * 1e-6f) / repeat);

  hipFree(d_a);
  hipFree(d_b);

  for (i = 0; i < elems; i++) d_res[i] &= MASK;

  // verify
  // compute distance from the *end* of the list (note the first element is the head node)
  h_res[0] = elems-1;
  i = 0;
  for (int r = 1; r < elems; r++) {
    h_res[next[i]] = elems-1-r;
    i = next[i];
  }

#ifdef DEBUG
  printf("Ranks:\n");
  for (i = 0; i < elems; i++) {
    printf("%d: %ld %ld\n", i, h_res[i], d_res[i]);
  }
#endif

  bool ok = (h_res == d_res);
  printf("%s\n", ok ? "PASS" : "FAIL");
  if (!ok) exit(1);
   
  return 0;
}
