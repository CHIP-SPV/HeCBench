#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <assert.h>
#include <random>
#include <chrono>
#include <hip/hip_runtime.h>

// Uncomment to use chars as the data type, otherwise use int
// #define CHAR_DATA_TYPE

// Uncomment to use a 4x4 predefined matrix for testing
// #define USE_TEST_MATRIX

#define klog2(n) ((n<8)?2:((n<16)?3:((n<32)?4:((n<64)?5:((n<128)?6:((n<256)?7:((n<512)?8:\
                ((n<1024)?9:((n<2048)?10:((n<4096)?11:((n<8192)?12:((n<16384)?13:0))))))))))))

#define kmin(x,y) ((x<y)?x:y)
#define kmax(x,y) ((x>y)?x:y)

#ifndef USE_TEST_MATRIX
#ifdef _n_
// These values are meant to be changed by scripts
const int n = _n_;          // size of the cost/pay matrix
const int range = _range_;  // defines the range of the random matrix.
const int user_n = n;          
const int n_tests = 100;
#else
// User inputs: These values should be changed by the user
const int user_n = 1000;    // This is the size of the cost matrix as supplied by the user
const int n = 1<<(klog2(user_n)+1);    // The size of the cost/pay matrix used in the algorithm that is increased to a power of two
const int range = n;        // defines the range of the random matrix.
const int n_tests = 10;     // defines the number of tests performed
#endif

// End of user inputs

const int log2_n = klog2(n);
const int n_threads = kmin(n,64);    // Number of threads used in small kernels grid size (typically grid size equal to n)
// Used in steps 3ini, 3, 4ini, 4a, 4b, 5a and 5b (64)
const int n_threads_reduction = kmin(n, 256); // Number of threads used in the redution kernels in step 1 and 6 (256)
const int n_blocks_reduction = kmin(n, 256);  // Number of blocks used in the redution kernels in step 1 and 6 (256)
const int n_threads_full = kmin(n, 256);      // Number of threads used the largest grids sizes (typically grid size equal to n*n)
// Used in steps 2 and 6 (256)
const int seed = 45345; // Initialization for the random number generator

#else
const int n = 4;
const int log2_n = 2;
const int n_threads = 2;
const int n_threads_reduction = 2;
const int n_blocks_reduction = 2;
const int n_threads_full = 2;
#endif

const int n_blocks = n / n_threads;  // Number of blocks used in small kernels grid size (typically grid size equal to n)
const int n_blocks_full = n * n / n_threads_full; // Number of blocks used the largest gris sizes (typically grid size equal to n*n)
const int row_mask = (1 << log2_n) - 1; // Used to extract the row from tha matrix position index (matrices are column wise)
const int nrows = n, ncols = n; // The matrix is square so the number of rows and columns is equal to n
const int max_threads_per_block = 256; // The maximum number of threads per block
const int columns_per_block_step_4 = 512; // Number of columns per block in step 4
const int n_blocks_step_4 = kmax(n / columns_per_block_step_4, 1);  // Number of blocks in step 4 and 2
const int data_block_size = columns_per_block_step_4 * n; // The size of a data block. Note that this can be bigger than the matrix size.
const int log2_data_block_size = log2_n + klog2(columns_per_block_step_4);  // log2 of the size of a data block. Note that klog2 cannot handle very large sizes

// For the selection of the data type used
#ifndef CHAR_DATA_TYPE
typedef int data;
#define MAX_DATA INT_MAX
#define MIN_DATA INT_MIN
#else
typedef unsigned char data;
#define MAX_DATA 255
#define MIN_DATA 0
#endif

// Host Variables

// Some host variables start with h_ to distinguish them from the corresponding device variables
// Device variables have no prefix.

#ifndef USE_TEST_MATRIX
data h_cost[ncols][nrows];
#else
data h_cost[n][n] = { { 1, 2, 3, 4 }, { 2, 4, 6, 8 }, { 3, 6, 9, 12 }, { 4, 8, 12, 16 } };
#endif
int h_column_of_star_at_row[nrows];
int h_zeros_vector_size;
int h_zeros_size;
int h_n_matches;
bool h_found;
bool h_goto_5;
bool h_repeat_kernel;

// Device Variables

__device__ data slack[nrows*ncols];           // The slack matrix
__device__ data min_in_rows[nrows];           // Minimum in rows
__device__ data min_in_cols[ncols];           // Minimum in columns
__device__ int zeros[nrows*ncols];            // A vector with the position of the zeros in the slack matrix
__device__ int zeros_size_b[n_blocks_step_4]; // The number of zeros in block i
__device__ int row_of_star_at_column[ncols];  // A vector that given the column j gives the row of the star at that column (or -1, no star)
__device__ int column_of_star_at_row[nrows];  // A vector that given the row i gives the column of the star at that row (or -1, no star)
__device__ int cover_row[nrows];              // A vector that given the row i indicates if it is covered (1- covered, 0- uncovered)
__device__ int cover_column[ncols];           // A vector that given the column j indicates if it is covered (1- covered, 0- uncovered)
__device__ int column_of_prime_at_row[nrows]; // A vector that given the row i gives the column of the prime at that row  (or -1, no prime)
__device__ int row_of_green_at_column[ncols]; // A vector that given the row j gives the column of the green at that row (or -1, no green)
__device__ data max_in_mat_row[nrows];        // Used in step 1 to stores the maximum in rows
__device__ data min_in_mat_col[ncols];        // Used in step 1 to stores the minimums in columns
__device__ data d_min_in_mat_vect[n_blocks_reduction];  // Used in step 6 to stores the intermediate results from the first reduction kernel
__device__ data d_min_in_mat;                 // Used in step 6 to store the minimum

// These flags used to be __managed__ and were polled directly by the host.
// They are now plain device globals accessed with explicit
// hipMemcpyToSymbol/hipMemcpyFromSymbol around each kernel launch, which is
// portable to platforms without coherent managed memory.
__device__ int zeros_size;            // The number fo zeros
__device__ int n_matches;             // Used in step 3 to count the number of matches found
__device__ bool goto_5;               // After step 4, goto step 5?
__device__ bool repeat_kernel;        // Needs to repeat the step 2 and step 4 kernel?
__device__ int step5_error;           // Fail-loudly backstop: set by step_5a if the
                                      // augmenting-path chase exceeds n hops, which can
                                      // only happen if step 4 produced a cyclic priming
                                      // state. Host checks it after step_5a and aborts.

__shared__ extern data sdata[];               // For access to shared memory

// -------------------------------------------------------------------------------------
// Device code
// -------------------------------------------------------------------------------------

__global__ void init()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  // initializations
  //for step 2
  if (i < nrows){
    cover_row[i] = 0;
    column_of_star_at_row[i] = -1;
  }
  if (i < ncols){
    cover_column[i] = 0;
    row_of_star_at_column[i] = -1;
  }
}

// STEP 1.
// a) Subtracting the row by the minimum in each row
const int n_rows_per_block = n / n_blocks_reduction;

// PORTABILITY NOTE: this used to be a CUDA warp-synchronous reduction (no
// barriers, guarded by `if (tid < 32)` at the call site), which requires
// 32-wide lockstep execution. OpenCL/Level-Zero devices do
// not guarantee that, and the broken reduction returned MAX_DATA, which fed
// garbage into steps 1/6 (wrong costs and a step-4/6 livelock). It is now a
// barrier-synchronized tail reduction executed by ALL threads of the block
// so that no barrier sits in divergent control flow.
__device__ void min_in_rows_warp_reduce(volatile data* sdata, int tid) {
  #pragma unroll
  for (int s = 32; s >= 1; s >>= 1) {
    if (n_threads_reduction >= 2*s && n_rows_per_block < 2*s && tid < s)
      sdata[tid] = min(sdata[tid], sdata[tid + s]);
    __syncthreads();
  }
}

__global__ void calc_min_in_rows()
{
  __shared__ data sdata[n_threads_reduction];    // One temporary result for each thread.

  unsigned int tid = threadIdx.x;
  unsigned int bid = blockIdx.x;
  // One gets the line and column from the blockID and threadID.
  unsigned int l = bid * n_rows_per_block + tid % n_rows_per_block;
  unsigned int c = tid / n_rows_per_block;
  unsigned int i = c * nrows + l;
  const unsigned int gridSize = n_threads_reduction * n_blocks_reduction;
  data thread_min = MAX_DATA;

  while (i < n * n) {
    thread_min = min(thread_min, slack[i]);
    i += gridSize;  // go to the next piece of the matrix...
    // gridSize = 2^k * n, so that each thread always processes the same line or column
  }
  sdata[tid] = thread_min;

  __syncthreads();
  if (n_threads_reduction >= 1024 && n_rows_per_block < 1024) {if (tid < 512) { sdata[tid] = min(sdata[tid], sdata[tid + 512]); } __syncthreads(); }
  if (n_threads_reduction >= 512 && n_rows_per_block < 512) { if (tid < 256) { sdata[tid] = min(sdata[tid], sdata[tid + 256]); } __syncthreads(); }
  if (n_threads_reduction >= 256 && n_rows_per_block < 256) { if (tid < 128) { sdata[tid] = min(sdata[tid], sdata[tid + 128]); } __syncthreads(); }
  if (n_threads_reduction >= 128 && n_rows_per_block < 128) { if (tid <  64) { sdata[tid] = min(sdata[tid], sdata[tid + 64]); } __syncthreads(); }
  min_in_rows_warp_reduce(sdata, tid); // all threads: contains barriers
  if (tid < n_rows_per_block) min_in_rows[bid*n_rows_per_block + tid] = sdata[tid];
}

// a) Subtracting the column by the minimum in each column
const int n_cols_per_block = n / n_blocks_reduction;

// Barrier-synchronized for portability; executed by ALL threads (see
// min_in_rows_warp_reduce).
__device__ void min_in_cols_warp_reduce(volatile data* sdata, int tid) {
  #pragma unroll
  for (int s = 32; s >= 1; s >>= 1) {
    if (n_threads_reduction >= 2*s && n_cols_per_block < 2*s && tid < s)
      sdata[tid] = min(sdata[tid], sdata[tid + s]);
    __syncthreads();
  }
}

__global__ void calc_min_in_cols()
{
  __shared__ data sdata[n_threads_reduction];    // One temporary result for each thread

  unsigned int tid = threadIdx.x;
  unsigned int bid = blockIdx.x;
  // One gets the line and column from the blockID and threadID.
  unsigned int c = bid * n_cols_per_block + tid % n_cols_per_block;
  unsigned int l = tid / n_cols_per_block;
  const unsigned int gridSize = n_threads_reduction * n_blocks_reduction;
  data thread_min = MAX_DATA;

  while (l < n) {
    unsigned int i = c * nrows + l;
    thread_min = min(thread_min, slack[i]);
    l += gridSize / n;  // go to the next piece of the matrix...
    // gridSize = 2^k * n, so that each thread always processes the same line or column
  }
  sdata[tid] = thread_min;

  __syncthreads();
  if (n_threads_reduction >= 1024 && n_cols_per_block < 1024) {
    if (tid < 512) { sdata[tid] = min(sdata[tid], sdata[tid + 512]); } __syncthreads(); }
  if (n_threads_reduction >= 512 && n_cols_per_block < 512) {
    if (tid < 256) { sdata[tid] = min(sdata[tid], sdata[tid + 256]); } __syncthreads(); }
  if (n_threads_reduction >= 256 && n_cols_per_block < 256) {
    if (tid < 128) { sdata[tid] = min(sdata[tid], sdata[tid + 128]); } __syncthreads(); }
  if (n_threads_reduction >= 128 && n_cols_per_block < 128) {
    if (tid <  64) { sdata[tid] = min(sdata[tid], sdata[tid + 64]); } __syncthreads(); }
  min_in_cols_warp_reduce(sdata, tid); // all threads: contains barriers
  if (tid < n_cols_per_block) min_in_cols[bid*n_cols_per_block + tid] = sdata[tid];
}

__global__ void step_1_row_sub()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int l = i & row_mask;
  slack[i] = slack[i] - min_in_rows[l];  // subtract the minimum in row from that row
}

__global__ void step_1_col_sub()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int c = i >> log2_n;
  slack[i] = slack[i] - min_in_cols[c]; // subtract the minimum in row from that row

  if (i == 0) zeros_size = 0;
  if (i < n_blocks_step_4) zeros_size_b[i] = 0;
}

// Compress matrix
__global__ void compress_matrix(){
  int i = blockDim.x * blockIdx.x + threadIdx.x;

  if (slack[i] == 0) {
    atomicAdd(&zeros_size, 1);
    int b = i >> log2_data_block_size;
    int i0 = i & ~(data_block_size - 1);    // == b << log2_data_block_size
    int j = atomicAdd(zeros_size_b + b, 1);
    zeros[i0 + j] = i;
  }
}

// STEP 2
// Find a zero of slack. If there are no starred zeros in its
// column or row star the zero. Repeat for each zero.

// The zeros are split through blocks of data so we run step 2 with several thread blocks and rerun the kernel if repeat was set to true.
//
// PORTABILITY NOTE: the original CUDA code additionally iterated inside the
// kernel with `do { ... } while (repeat)`, where the __shared__ bool `repeat`
// is written non-atomically by arbitrary threads between barriers.  On some
// OpenCL/Level-Zero devices that block-side convergence spin does not terminate
// reliably (see PHASE7_KNOWN_FAIL.md), and it was only an intra-block
// optimization: cross-block convergence already relied on the host relaunching
// the kernel while `repeat_kernel` is set.  The in-kernel loop is therefore
// hoisted to the host: each launch performs exactly one pass over the zeros
// and raises the global `repeat_kernel` flag when another pass is needed.
__global__ void step_2()
{
  int i = threadIdx.x;
  int b = blockIdx.x;

  for (int j = i; j < zeros_size_b[b]; j += blockDim.x)
  {
    int z = zeros[(b << log2_data_block_size) + j];
    int l = z & row_mask;
    int c = z >> log2_n;

    if (cover_row[l] == 0 && cover_column[c] == 0) {
      // thread trys to get the line
      if (!atomicExch((int *)&(cover_row[l]), 1)){
        // only one thread gets the line
        if (!atomicExch((int *)&(cover_column[c]), 1)){
          // only one thread gets the column
          row_of_star_at_column[c] = l;
          column_of_star_at_row[l] = c;
        }
        else {
          cover_row[l] = 0;
          repeat_kernel = true; // benign race: every writer stores true
        }
      }
    }
  }
}

// STEP 3
// uncover all the rows and columns before going to step 3
__global__ void step_3ini()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  cover_row[i] = 0;
  cover_column[i] = 0;
  if (i == 0) n_matches = 0;
}

// Cover each column with a starred zero. If all the columns are
// covered then the matching is maximum
__global__ void step_3()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if (row_of_star_at_column[i]>=0)
  {
    cover_column[i] = 1;
    atomicAdd((int*)&n_matches, 1);
  }
}

// STEP 4
// Find a noncovered zero and prime it. If there is no starred
// zero in the row containing this primed zero, go to Step 5.
// Otherwise, cover this row and uncover the column containing
// the starred zero. Continue in this manner until there are no
// uncovered zeros left. Save the smallest uncovered value and
// Go to Step 6.

__global__ void step_4_init()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  column_of_prime_at_row[i] = -1;
  row_of_green_at_column[i] = -1;
}

// PORTABILITY NOTE: like step_2, the original CUDA kernel iterated in-kernel
// with `do { ... } while (s_found && !s_goto_5)` over __shared__ bools written
// non-atomically by arbitrary threads — the same divergent-termination spin
// that hangs on such devices.  `s_found` and `s_repeat_kernel` were
// always set together, so one pass per launch with the host looping
// `while (repeat_kernel && !goto_5)` (which it already did) is equivalent.
//
// RACE FIX (Arc B570 hang in step_5a): priming a starred row must be EXCLUSIVE.
// The algorithm's acyclicity guarantee for the step-5a chase is a temporal
// ordering: a starred column c only becomes uncovered after its star row r was
// primed and covered, so every chase hop  c -> star_row(c)=r -> prime(r)
// lands on a column that was uncovered strictly earlier — the chain must
// terminate.  That argument requires `column_of_prime_at_row[l]` to be
// immutable once `cover_row[l] == 1` is observable.  The original (upstream
// CUDA) code enforced this only probabilistically: the non-atomic
// check-then-act  `if (!cover_column[c] && !cover_row[l]) { prime; cover }`
// lets two threads both pass the `!cover_row[l]` test, so a thread can
// overwrite prime[l] AFTER row l's cover/uncover side effects were consumed by
// other threads to build later primes — cross-linking primes into a cycle
// (e.g. prime[r1]=c2, prime[r2]=c1 with stars c1@r1, c2@r2), which makes the
// step_5a chase spin forever.  Narrow schedulers (iGPU, most CUDA runs) keep
// the check-act window effectively closed; the B570's wide concurrent
// execution exposes it.  Fix: the row cover is an atomicExch claim — exactly
// one thread wins the 0->1 transition and only the winner primes the row.
// Losers do nothing: their zero is now covered, and the winner already raised
// repeat_kernel, so the host relaunch re-examines everything.
__global__ void step_4() {
  volatile int *v_cover_row = cover_row;
  volatile int *v_cover_column = cover_column;

  int i = threadIdx.x;
  int b = blockIdx.x;

  for (int j = i; j < zeros_size_b[b]; j += blockDim.x)
  {
    int z = zeros[(b << log2_data_block_size) + j];
    int l = z & row_mask;
    int c = z >> log2_n;
    int c1 = column_of_star_at_row[l];

    for (int n = 0; n < 10; n++) {

      if (!v_cover_column[c] && !v_cover_row[l]) {
        // Columns are never re-covered during step 4, so an observed
        // uncovered column stays valid across the claim below.
        if (c1 >= 0) {
          if (atomicExch((int *)&cover_row[l], 1) == 0) {
            // Exclusive winner for row l: prime it exactly once.
            column_of_prime_at_row[l] = c;
            repeat_kernel = true; // benign race: every writer stores true
            __threadfence();      // prime visible before the uncover below
            v_cover_column[c1] = 0;
          }
          // Losers: row l is covered now; nothing further to do for this zero.
        }
        else {
          // Row without a star: never covered, so last-write-wins priming is
          // fine — any currently-uncovered zero column is a valid chase entry.
          column_of_prime_at_row[l] = c;
          repeat_kernel = true; // benign race: every writer stores true
          goto_5 = true;        // benign race: every writer stores true
        }
      }
    } // for(int n

  } // for(int j
}

/* STEP 5:
Construct a series of alternating primed and starred zeros as follows:
Let Z0 represent the uncovered primed zero found in Step 4.
Let Z1 denote the starred zero in the column of Z0(if any).
Let Z2 denote the primed zero in the row of Z1(there will always
be one). Continue until the series terminates at a primed zero
that has no starred zero in its column. Unstar each starred
zero of the series, star each primed zero of the series, erase
all primes and uncover every line in the matrix. Return to Step 3.*/

// Eliminates joining paths
__global__ void step_5a()
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;

  int r_Z0, c_Z0;

  c_Z0 = column_of_prime_at_row[i];
  if (c_Z0 >= 0 && column_of_star_at_row[i] < 0) {
    row_of_green_at_column[c_Z0] = i;

    // Fail-loudly backstop: an alternating path visits each row/column at most
    // once, so it can never exceed n hops.  Exceeding the bound (or landing on
    // a starred row with no prime) means step 4 produced a cyclic/corrupt
    // priming state; abort instead of spinning forever.  With the atomic row
    // claim in step_4 this must never trigger.
    int hops = 0;
    while ((r_Z0 = row_of_star_at_column[c_Z0]) >= 0) {
      if (++hops > nrows) {
        printf("step_5a ERROR: augmenting path from row %d exceeds %d hops - cyclic priming state (step 4 race)\n", i, nrows);
        step5_error = 1;
        return;
      }
      c_Z0 = column_of_prime_at_row[r_Z0];
      if (c_Z0 < 0) {
        printf("step_5a ERROR: starred row %d reached by chase from row %d has no prime - corrupt priming state\n", r_Z0, i);
        step5_error = 1;
        return;
      }
      row_of_green_at_column[c_Z0] = r_Z0;
    }
  }
}

// Applies the alternating paths
__global__ void step_5b()
{
  int j = blockDim.x * blockIdx.x + threadIdx.x;

  int r_Z0, c_Z0, c_Z2;

  r_Z0 = row_of_green_at_column[j];

  if (r_Z0 >= 0 && row_of_star_at_column[j] < 0) {

    c_Z2 = column_of_star_at_row[r_Z0];

    column_of_star_at_row[r_Z0] = j;
    row_of_star_at_column[j] = r_Z0;

    while (c_Z2 >= 0) {
      r_Z0 = row_of_green_at_column[c_Z2];  // row of Z2
      c_Z0 = c_Z2;              // col of Z2
      c_Z2 = column_of_star_at_row[r_Z0];    // col of Z4

      // star Z2
      column_of_star_at_row[r_Z0] = c_Z0;
      row_of_star_at_column[c_Z0] = r_Z0;
    }
  }
}

// STEP 6
// Add the minimum uncovered value to every element of each covered
// row, and subtract it from every element of each uncovered column.
// Return to Step 4 without altering any stars, primes, or covered lines.

// Barrier-synchronized for portability; executed by ALL threads (see
// min_in_rows_warp_reduce).
template <unsigned int blockSize>
__device__ void min_warp_reduce(volatile data* sdata, int tid) {
  #pragma unroll
  for (int s = 32; s >= 1; s >>= 1) {
    if (blockSize >= (unsigned)(2*s) && tid < s)
      sdata[tid] = min(sdata[tid], sdata[tid + s]);
    __syncthreads();
  }
}

template <unsigned int blockSize>  // blockSize is the size of a block of threads
__device__ void min_reduce1(volatile data *g_idata, volatile data *g_odata, unsigned int n)
{
  unsigned int tid = threadIdx.x;
  unsigned int i = blockIdx.x*(blockSize * 2) + tid;
  unsigned int gridSize = blockSize * 2 * gridDim.x;
  sdata[tid] = MAX_DATA;

  while (i < n) {
    int i1 = i;
    int i2 = i + blockSize;
    int l1 = i1 & row_mask;
    int c1 = i1 >> log2_n; 
    data g1;
    if (cover_row[l1] == 1 || cover_column[c1] == 1) g1 = MAX_DATA;
    else g1 = g_idata[i1];
    int l2 = i2 & row_mask;
    int c2 = i2 >> log2_n;
    data g2;
    if (cover_row[l2] == 1 || cover_column[c2] == 1) g2 = MAX_DATA;
    else g2 = g_idata[i2];
    sdata[tid] = min(sdata[tid], min(g1, g2));
    i += gridSize;
  }

  __syncthreads();
  if (blockSize >= 1024) { if (tid < 512) { sdata[tid] = min(sdata[tid], sdata[tid + 512]); } __syncthreads(); }
  if (blockSize >= 512) { if (tid < 256) { sdata[tid] = min(sdata[tid], sdata[tid + 256]); } __syncthreads(); }
  if (blockSize >= 256) { if (tid < 128) { sdata[tid] = min(sdata[tid], sdata[tid + 128]); } __syncthreads(); }
  if (blockSize >= 128) { if (tid <  64) { sdata[tid] = min(sdata[tid], sdata[tid + 64]); } __syncthreads(); }
  min_warp_reduce<blockSize>(sdata, tid); // all threads: contains barriers
  if (tid == 0) g_odata[blockIdx.x] = sdata[0];
}

template <unsigned int blockSize>
__device__ void min_reduce2(volatile data *g_idata, volatile data *g_odata, unsigned int n)
{
  unsigned int tid = threadIdx.x;
  unsigned int i = blockIdx.x*(blockSize * 2) + tid;

  sdata[tid] = min(g_idata[i], g_idata[i + blockSize]);

  __syncthreads();
  if (blockSize >= 1024) { if (tid < 512) { sdata[tid] = min(sdata[tid], sdata[tid + 512]); } __syncthreads(); }
  if (blockSize >= 512) { if (tid < 256) { sdata[tid] = min(sdata[tid], sdata[tid + 256]); } __syncthreads(); }
  if (blockSize >= 256) { if (tid < 128) { sdata[tid] = min(sdata[tid], sdata[tid + 128]); } __syncthreads(); }
  if (blockSize >= 128) { if (tid <  64) { sdata[tid] = min(sdata[tid], sdata[tid + 64]); } __syncthreads(); }
  min_warp_reduce<blockSize>(sdata, tid); // all threads: contains barriers
  if (tid == 0) g_odata[blockIdx.x] = sdata[0];
}

__global__ void step_6_add_sub()
{
  // STEP 6:
  //  /*STEP 6: Add the minimum uncovered value to every element of each covered
  //  row, and subtract it from every element of each uncovered column.
  //  Return to Step 4 without altering any stars, primes, or covered lines. */
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  int l = i & row_mask;
  int c = i >> log2_n;
  if (cover_row[l] == 1 && cover_column[c] == 1)
    slack[i] += d_min_in_mat;
  if (cover_row[l] == 0 && cover_column[c] == 0)
    slack[i] -= d_min_in_mat;

  if (i == 0) zeros_size = 0;
  if (i < n_blocks_step_4) zeros_size_b[i] = 0;
}

__global__ void min_reduce_kernel1() {
  min_reduce1<n_threads_reduction>(slack, d_min_in_mat_vect, nrows*ncols);
}

__global__ void min_reduce_kernel2() {
  min_reduce2<n_threads_reduction / 2>(d_min_in_mat_vect, &d_min_in_mat, n_blocks_reduction);
}

// -------------------------------------------------------------------------------------
// Host code
// -------------------------------------------------------------------------------------

// Used to make sure some constants are properly set
void check(bool val, const char *str){
  if (!val) {
    printf("Check failed: %s!\n", str);
    exit(-1);
  }
}

// Convenience function for checking HIP runtime API results
// can be wrapped around any runtime API call. No-op in release builds.
inline hipError_t check(hipError_t result)
{
  if (result != hipSuccess) {
    printf("HIP Runtime Error: %s\n", hipGetErrorString(result));
  }
  return result;
};

#define call_kernel(k, n_blocks, n_threads) \
  call_kernel_s(k, n_blocks, n_threads, 0ll)

#define call_kernel_s(k, n_blocks, n_threads, shared)  \
{ \
  hipLaunchKernelGGL(k, n_blocks, n_threads, shared, 0); \
  check(hipDeviceSynchronize()); \
}

// Hungarian_Algorithm
void Hungarian_Algorithm()
{
  int h_step5_error = 0;
  check(hipMemcpyToSymbol(HIP_SYMBOL(step5_error), &h_step5_error, sizeof(int)));

  // Initialization
  call_kernel(init, n_blocks, n_threads);

  // Step 1 kernels
  call_kernel(calc_min_in_rows, n_blocks_reduction, n_threads_reduction);
  call_kernel(step_1_row_sub, n_blocks_full, n_threads_full);
  call_kernel(calc_min_in_cols, n_blocks_reduction, n_threads_reduction);
  call_kernel(step_1_col_sub, n_blocks_full, n_threads_full);

  // compress_matrix
  call_kernel(compress_matrix, n_blocks_full, n_threads_full);
  check(hipMemcpyFromSymbol(&h_zeros_size, HIP_SYMBOL(zeros_size), sizeof(int)));

  // Step 2 kernels
  do {
    h_repeat_kernel = false;
    check(hipMemcpyToSymbol(HIP_SYMBOL(repeat_kernel), &h_repeat_kernel, sizeof(bool)));
    call_kernel(step_2, n_blocks_step_4, (n_blocks_step_4 > 1 || h_zeros_size > max_threads_per_block) ? max_threads_per_block : h_zeros_size);
    // If we have more than one block it means that we have 512 lines per block so 1024 threads should be adequate.
    check(hipMemcpyFromSymbol(&h_repeat_kernel, HIP_SYMBOL(repeat_kernel), sizeof(bool)));
  } while (h_repeat_kernel);

  while (1) {  // repeat steps 3 to 6

    // Step 3 kernels
    call_kernel(step_3ini, n_blocks, n_threads);
    call_kernel(step_3, n_blocks, n_threads);
    check(hipMemcpyFromSymbol(&h_n_matches, HIP_SYMBOL(n_matches), sizeof(int)));

    if (h_n_matches >= ncols) break;      // It's done

    //step 4_kernels
    call_kernel(step_4_init, n_blocks, n_threads);

    while (1) // repeat step 4 and 6
    {
      do {  // step 4 loop
        h_goto_5 = false; h_repeat_kernel = false;
        check(hipMemcpyToSymbol(HIP_SYMBOL(goto_5), &h_goto_5, sizeof(bool)));
        check(hipMemcpyToSymbol(HIP_SYMBOL(repeat_kernel), &h_repeat_kernel, sizeof(bool)));

        call_kernel(step_4, n_blocks_step_4, (n_blocks_step_4 > 1 || h_zeros_size > max_threads_per_block) ? max_threads_per_block : h_zeros_size);
        // If we have more than one block it means that we have 512 lines per block so 1024 threads should be adequate.

        check(hipMemcpyFromSymbol(&h_repeat_kernel, HIP_SYMBOL(repeat_kernel), sizeof(bool)));
        check(hipMemcpyFromSymbol(&h_goto_5, HIP_SYMBOL(goto_5), sizeof(bool)));
      } while (h_repeat_kernel && !h_goto_5);

      if (h_goto_5) break;

      //step 6_kernel
      call_kernel_s(min_reduce_kernel1, n_blocks_reduction, n_threads_reduction, n_threads_reduction*sizeof(int));
      call_kernel_s(min_reduce_kernel2, 1, n_blocks_reduction / 2, (n_blocks_reduction / 2) * sizeof(int));
      call_kernel(step_6_add_sub, n_blocks_full, n_threads_full);

      //compress_matrix
      call_kernel(compress_matrix, n_blocks_full, n_threads_full);
      check(hipMemcpyFromSymbol(&h_zeros_size, HIP_SYMBOL(zeros_size), sizeof(int)));

    } // repeat step 4 and 6

    call_kernel(step_5a, n_blocks, n_threads);
    check(hipMemcpyFromSymbol(&h_step5_error, HIP_SYMBOL(step5_error), sizeof(int)));
    if (h_step5_error) {
      fprintf(stderr, "FATAL: step_5a detected a cyclic/corrupt priming state (step 4 exclusivity violated)\n");
      exit(2);
    }
    call_kernel(step_5b, n_blocks, n_threads);

  }  // repeat steps 3 to 6
}

int main(int argc, char* argv[])
{
  if (argc != 2) {
    printf("Usage: %s <output file>\n", argv[0]);
    return 1;
  }

  // Constant checks:
  check(n == (1 << log2_n), "Incorrect log2_n!");
  check(n_threads*n_blocks == n, "n_threads*n_blocks != n\n");
  // step 1
  check(n_blocks_reduction <= n, "Step 1: Should have several lines per block!");
  check(n % n_blocks_reduction == 0, "Step 1: Number of lines per block should be integer!");
  check((n_blocks_reduction*n_threads_reduction) % n == 0,
        "Step 1: The grid size must be a multiple of the line size!");
  check(n_threads_reduction*n_blocks_reduction <= n*n,
        "Step 1: The grid size is bigger than the matrix size!");
  // step 6
  check(n_threads_full*n_blocks_full <= n*n,
        "Step 6: The grid size is bigger than the matrix size!");
  check(columns_per_block_step_4*n == (1 << log2_data_block_size),
        "Columns per block of step 4 is not a power of two!");

  // Open text file
  FILE *file = freopen(argv[1], "w", stdout);
  if (file == NULL)
  {
    perror("Error opening the output file!\n");
    return 1; 
  };

  // Prints the current time
  time_t current_time;
  time(&current_time);
  printf("%s\n", ctime(&current_time));
  fflush(file);

  // total kernel time for all testcases
  long total_time = 0;

#ifndef USE_TEST_MATRIX
  std::default_random_engine generator(seed);
  std::uniform_int_distribution<int> distribution(0, range-1);

  for (int test = 0; test < n_tests; test++) {
    printf("\n\n\n\ntest %d\n", test);
    fflush(file);

    for (int c = 0; c < ncols; c++)
      for (int r = 0; r < nrows; r++) {
        if (c < user_n && r < user_n)
          h_cost[c][r] = distribution(generator);
        else {
          if (c == r) h_cost[c][r] = 0;
          else h_cost[c][r] = MAX_DATA;
        }
      }
#endif

    // Copy vectors from host memory to device memory
    hipMemcpyToSymbol(HIP_SYMBOL(slack), h_cost, sizeof(data)*nrows*ncols); 

    // Invoke kernels
    hipDeviceSynchronize();
    auto start = std::chrono::steady_clock::now();

    Hungarian_Algorithm();
    check(hipDeviceSynchronize());

    auto end = std::chrono::steady_clock::now();
    auto time = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    total_time += time;
    printf("Total kernel execution time of the Hungarian algorithm %f (s)\n", time * 1e-9f);

    fflush(file);

    // Copy assignments from Device to Host and calculate the total Cost
    hipMemcpyFromSymbol(h_column_of_star_at_row, HIP_SYMBOL(column_of_star_at_row), nrows * sizeof(int));

    int total_cost = 0;
    for (int r = 0; r < nrows; r++) {
      int c = h_column_of_star_at_row[r];
      if (c >= 0) total_cost += h_cost[c][r];
    }

    printf("Total cost is \t %d \n", total_cost);

#ifndef USE_TEST_MATRIX
  }
#endif

  fclose(file);
  fprintf(stderr, "Total kernel time for all test cases %lf (s)\n", total_time * 1e-9);
  return 0;
}
