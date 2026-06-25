// N ints of private memory per work-item. 3072 ints = 12 KB/WI.
// At SIMD16 that is 12KB*16 = 192 KB per hardware thread:
//   > Intel OpenCL ~64 KB/thread scratch cap  -> expect CL_OUT_OF_RESOURCES
//   < Level Zero / HW 256 KB/thread cap        -> expect success
#define N 3072
__attribute__((intel_reqd_sub_group_size(16)))
__kernel void scratchhog(__global int *out, int rounds) {
  int gid = get_global_id(0);
  volatile int priv[N];                 // large -> spills to private/scratch
  for (int i = 0; i < N; i++) priv[i] = gid + i;
  int acc = 0;
  for (int r = 0; r < rounds; r++)
    for (int i = 0; i < N; i++)
      acc += priv[(i * 1103515245 + r) & (N - 1)];   // dynamic idx -> can't promote to GRF
  out[gid] = acc;
}
