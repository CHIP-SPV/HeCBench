# Problem Size Notes for Quick Mode

This file documents the minimal problem sizes tested for each benchmark in quick mode.
Each entry should verify that the benchmark runs successfully with minimal inputs while still performing all computations.

## Testing Process
1. Examine source code to understand argument requirements
2. Test with smallest reasonable problem size
3. Verify it completes successfully
4. Document execution time, compilation issues, or other relevant details
5. Add to subset-quick.json

---

## accuracy-sycl
- **Args**: nrows, ndims, top_k, repeat
- **Current**: ["8192", "10000", "10", "100"]
- **Minimal**: ["128", "100", "1", "1"]
- **Compilation**: Success
- **Execution Time**: 0.16 seconds
- **Result**: PASS
- **Notes**: Code does `for (int ngrid = nrows / 4; ngrid <= nrows; ngrid += nrows / 4)`, so nrows should be >= 4 and divisible by 4. 128 works correctly.

---

## ace-sycl
- **Args**: num_steps
- **Current**: ["100"]
- **Minimal**: ["10"]
- **Compilation**: Success
- **Execution Time**: 20.92 seconds
- **Result**: Success
- **Notes**: Single argument for number of simulation steps. 10 steps is sufficient for quick test.

---

## adam-sycl
- **Args**: vector_size, time_step, repeat
- **Current**: ["10000", "200", "100"]
- **Minimal**: ["100", "1", "1"]
- **Compilation**: Success
- **Execution Time**: 0.52 seconds
- **Result**: PASS
- **Notes**: Vector size can be small, time_step=1 is minimal, repeat=1 for quick mode.

---

## adamw-sycl
- **Args**: vector_size, time_step
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success
- **Execution Time**: 14.79 seconds (crashed with exit code 134)
- **Result**: FAIL - Runtime error: "UR backend failed. UR backend returns:40 (UR_RESULT_ERROR_OUT_OF_RESOURCES)"
- **Notes**: Not in standard subset. Compiles but fails at runtime with out-of-resources error from SYCL backend. May need different parameters or investigation.

---

## addBiasResidualLayerNorm-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"]
- **Compilation**: Success
- **Execution Time**: 3.72 seconds
- **Result**: PASS
- **Notes**: Not in standard subset.

---

## adjacent-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.00 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters.

---

## adv-sycl
- **Args**: N, cubN, Nelements, [Ntests optional]
- **Current**: ["16", "16", "16"]
- **Minimal**: ["16", "16", "16"]
- **Compilation**: Success
- **Execution Time**: 0.66 seconds (crashed with exit code 134)
- **Result**: FAIL - Runtime error: "Native API failed. Native API returns: 29 (UR_RESULT_ERROR_INVALID_KERNEL_NAME)"
- **Notes**: Compiles successfully but crashes at runtime with SYCL kernel name error.

---

## aes-sycl
- **Args**: iterations, 0_or_1, path_to_bitmap
- **Current**: Not in subset.json
- **Minimal**: ["1", "0", "../urng-sycl/URNG_Input.bmp"] (from make run, but file may not exist)
- **Compilation**: Success
- **Execution Time**: N/A - Requires bitmap file
- **Result**: FAIL - Requires bitmap image file: "../urng-sycl/URNG_Input.bmp" (from make run)
- **Notes**: Not in standard subset. Requires bitmap image file. Make run shows it needs ../urng-sycl/URNG_Input.bmp.

---

## affine-sycl
- **Args**: input_image, output_image, iterations
- **Current**: Not in subset.json
- **Minimal**: ["data/CT-MONO2-16-brain.raw", "result.raw", "1"] (from make run)
- **Compilation**: Success
- **Execution Time**: 0.13 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Requires RAW image input file. File exists at data/CT-MONO2-16-brain.raw. Works correctly with minimal parameters.

---

## aidw-sycl
- **Args**: pts (in 1K units), check, iterations
- **Current**: ["10", "1", "100"]
- **Minimal**: ["1", "1", "1"]
- **Compilation**: Success (with warnings about -fopenmp)
- **Execution Time**: 0.15 seconds
- **Result**: PASS
- **Notes**: pts=1 means 1024 points, which is sufficient for quick test.

---

## aligned-types-sycl
- **Args**: None (no arguments)
- **Current**: Not in subset.json
- **Minimal**: []
- **Compilation**: Success
- **Execution Time**: 7.46 seconds
- **Result**: Success
- **Notes**: Not in standard subset. Takes no arguments.

---

## all-pairs-distance-sycl
- **Args**: iterations
- **Current**: ["1000"]
- **Minimal**: ["1"]
- **Compilation**: Success
- **Execution Time**: 0.21 seconds
- **Result**: PASS
- **Notes**: Single iteration is sufficient.

---

## allreduce-sycl
- **Args**: None (no arguments, uses hardcoded buffer sizes and iterations)
- **Current**: Not in subset.json
- **Minimal**: [] (no args)
- **Compilation**: FAIL
- **Compilation Error**: fatal error: 'mpi.h' file not found - Requires MPI headers and MPI-enabled build
- **Notes**: Not in standard subset. Requires MPI library and must be run with mpirun. Uses hardcoded buffer sizes and iteration counts internally.

---

## amgmk-sycl
- **Args**: None (no arguments)
- **Current**: Not in subset.json
- **Minimal**: [] (no args)
- **Compilation**: Success
- **Execution Time**: 0.94 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Binary name is AMGMk (not main). Takes no arguments, uses hardcoded test parameters.

---

## ans-sycl
- **Args**: size_in_megabytes
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10 MB)
- **Compilation**: FAIL
- **Compilation Error**: 3 errors in multians_gpu_decoder.cc - no matching function for calls to phase1_decode_subseq, phase2_synchronise_blocks, phase4_decode_write_output. Error: no known conversion from 'global_ptr<value_type>' (aka 'multi_ptr<const unsigned int, access::address_space::global_space>') to 'std::uint32_t *' (aka 'unsigned int *') for function arguments. SYCL multi_ptr type mismatch issue.
- **Notes**: Not in standard subset. Has compilation errors due to SYCL multi_ptr type conversion issues in decoder functions. Takes input size in megabytes.

---

## aobench-sycl
- **Args**: iterations
- **Current**: ["1000"]
- **Minimal**: ["1"]
- **Compilation**: Success
- **Execution Time**: 0.17 seconds
- **Result**: Success
- **Notes**: Single iteration for quick test works correctly.

---

## aop-sycl
- **Args**: Uses flags like -paths, -timesteps, -runs
- **Current**: ["-paths", "200"]
- **Minimal**: ["-paths", "10"]
- **Compilation**: Success (with warnings)
- **Execution Time**: 1.00 seconds
- **Result**: Success
- **Notes**: Defaults are timesteps=100, paths=32, runs=1. Minimal paths=10 works correctly.

---

## asmooth-sycl
- **Args**: image_dimension, threshold, max_box_size, iterations
- **Current**: ["10000", "1", "5", "1"]
- **Minimal**: ["100", "1", "1", "1"]
- **Compilation**: Success
- **Execution Time**: 0.13 seconds
- **Result**: PASS
- **Notes**: Image dimension can be reduced significantly. Tested and verified.

---

## assert-sycl
- **Args**: None
- **Current**: [] (no args)
- **Minimal**: []
- **Compilation**: Success
- **Execution Time**: 0.16 seconds (terminates with assertion failure)
- **Result**: Expected failure (exit code 134) - assertion failure is the intended behavior
- **Notes**: Takes no arguments, just runs tests. The assertion failure is expected behavior for this benchmark to test assert functionality.

---

## asta-sycl
- **Args**: Uses getopt with -m, -n, -s, -w, -r, -i, -g (all optional)
- **Current**: [] (uses defaults)
- **Minimal**: []
- **Compilation**: Success
- **Execution Time**: 4.04 seconds
- **Result**: Success
- **Notes**: Has defaults: m=197, n=35588, s=32. Can use defaults.

---

## atan2-sycl
- **Args**: number_of_coordinates, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.20 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters.

---

## atomicAggregate-sycl
- **Args**: repeat
- **Current**: ["1000"]
- **Minimal**: ["1"]
- **Compilation**: Success
- **Execution Time**: 0.25 seconds
- **Result**: PASS
- **Notes**: Single repeat should be sufficient.

---

## atomicCAS-sycl
- **Args**: repeat
- **Current**: ["10000"]
- **Minimal**: ["1"]
- **Compilation**: Success
- **Execution Time**: 1.35 seconds
- **Result**: PASS
- **Notes**: Single repeat for quick test.

---

## atomicCost-sycl
- **Args**: N, repeat
- **Current**: ["16", "10"]
- **Minimal**: ["16", "1"]
- **Compilation**: Success
- **Execution Time**: 1.31 seconds
- **Result**: PASS
- **Notes**: Keep N=16, reduce repeat to 1.

---

## atomicIntrinsics-sycl
- **Args**: number_of_atomic_operations, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.00 seconds (PASS)
- **Result**: PASS
- **Notes**: Not in standard subset.

---

## atomicPerf-sycl
- **Args**: repeat
- **Current**: ["10"]
- **Minimal**: ["1"]
- **Compilation**: Success (with warnings)
- **Execution Time**: 17.74 seconds
- **Result**: PASS
- **Notes**: Single repeat. Takes longer than other atomic benchmarks.

---

## atomicReduction-sycl
- **Args**: [arrayLength, N optional]
- **Current**: [] (uses defaults)
- **Minimal**: []
- **Compilation**: Success
- **Execution Time**: 2.27 seconds
- **Result**: Success
- **Notes**: Takes no args, uses defaults.

---

## atomicSystemWide-sycl
- **Args**: loop_count_within_kernel
- **Current**: Not in subset.json
- **Minimal**: ["1000"] (from make run)
- **Compilation**: Success
- **Execution Time**: 0.81 seconds (exit code 1)
- **Result**: FAIL - Correctness error: "atomicAdd failed val = 327680000 testData = 163840000" - verification fails
- **Notes**: Not in standard subset. Test fails verification - atomic operations produce incorrect results. May be a SYCL implementation issue with system-wide atomics.

---

## attentionMultiHead-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"]
- **Compilation**: Success (with warnings about -fopenmp)
- **Execution Time**: 0.00 seconds (PASS but exit code 1)
- **Result**: PASS (but exits with code 1, may be expected)
- **Notes**: Not in standard subset. Prints PASS but exits with code 1.

---

## attention-sycl
- **Args**: rows, columns, implementation, repeat
- **Current**: ["8192", "8192", "0", "5"]
- **Minimal**: ["128", "128", "0", "1"]
- **Compilation**: Success
- **Execution Time**: 0.15 seconds
- **Result**: PASS
- **Notes**: Reduce dimensions significantly, keep implementation=0, repeat=1. Tested and verified.

---

## axhelm-sycl
- **Args**: Ndim, Nelements, [nRepetitions optional]
- **Current**: ["3", "8000", "100"]
- **Minimal**: ["3", "100", "1"]
- **Compilation**: FAIL
- **Compilation Error**: `main.cpp:315:19: error: call to 'fabs' is ambiguous` - ambiguous call to fabs function, conflict between C++ cmath and C math.h
- **Notes**: Compilation fails due to ambiguous fabs call. Needs code fix (use std::fabs or cast to resolve ambiguity).

---

## babelstream-sycl
- **Args**: Optional flags --arraysize/-s, --numtimes/-n (defaults used if not provided)
- **Current**: Not in subset.json
- **Minimal**: [] (uses defaults)
- **Compilation**: Success
- **Execution Time**: 2.76 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Takes optional arguments but works with defaults. num_times must be >= 2 if provided.

---

## background-subtract-sycl
- **Args**: image_width, image_height, merge, repeat
- **Current**: ["4096", "2048", "1", "102"]
- **Minimal**: ["4096", "2048", "1", "1"]
- **Compilation**: Success
- **Execution Time**: 0.25 seconds
- **Result**: PASS
- **Notes**: Reduce repeat from 102 to 1. Keep image dimensions as they may be minimal for correctness.

---

## backprop-sycl
- **Args**: number_of_input_nodes (must be divisible by 16)
- **Current**: ["65536"]
- **Minimal**: ["1024"]
- **Compilation**: Success (with warnings)
- **Execution Time**: 0.13 seconds
- **Result**: PASS
- **Notes**: Reduce from 65536 to 1024 neurons. Must be divisible by 16.

---

## bezier-surface-sycl
- **Args**: Uses getopt, -n for number of points
- **Current**: ["-n", "8192"]
- **Minimal**: ["-n", "128"]
- **Compilation**: Success
- **Execution Time**: 0.14 seconds
- **Result**: PASS
- **Notes**: Reduce from 8192 to 128 points for quick test.

---

## bfs-sycl
- **Args**: input_file (graph file)
- **Current**: Not in subset.json
- **Minimal**: ["../data/bfs/graph1MW_6.txt"] (from make run, but file may not exist)
- **Compilation**: Success
- **Execution Time**: N/A - Requires graph file
- **Result**: FAIL - Requires graph input file: "../data/bfs/graph1MW_6.txt" (from make run)
- **Notes**: Not in standard subset. Requires graph input file. Make run shows it needs ../data/bfs/graph1MW_6.txt.

---

## bh-sycl
- **Args**: nbodies, timesteps
- **Current**: ["300", "30"]
- **Minimal**: ["100000", "100"] (from make run)
- **Compilation**: Success (with warnings)
- **Execution Time**: Crashed immediately
- **Result**: FAIL - Runtime error: "Native API failed. Native API returns: 20 (UR_RESULT_ERROR_DEVICE_LOST)" - device lost error
- **Notes**: Compiles but crashes at runtime with device lost error. May need different parameters or device configuration.

---

## bilateral-sycl
- **Args**: image_width, image_height, intensity, spatial, repeat
- **Current**: ["2960", "1440", "0.5", "0.5", "1000"]
- **Minimal**: ["100", "100", "0.5", "0.5", "1"]
- **Compilation**: Success
- **Execution Time**: 0.14 seconds
- **Result**: PASS
- **Notes**: Reduce image dimensions and repeat significantly.

---

## bincount-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success (with warnings)
- **Execution Time**: 0.00 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters.

---

## binomial-sycl
- **Args**: None (no arguments)
- **Current**: [] (no args)
- **Minimal**: []
- **Compilation**: Success
- **Execution Time**: 1.72 seconds
- **Result**: Success
- **Notes**: Takes no arguments, uses hardcoded values.

---

## bitcracker-sycl
- **Args**: -f hash_file, -d dictionary_file, -b batch_size
- **Current**: Not in subset.json
- **Minimal**: ["-f", "../bitcracker-cuda/hash_pass/img_win8_user_hash.txt", "-d", "../bitcracker-cuda/hash_pass/user_passwords_60000.txt", "-b", "60000"] (from make run)
- **Compilation**: Success
- **Execution Time**: N/A - Files not found
- **Result**: FAIL - Missing input files: "../bitcracker-cuda/hash_pass/img_win8_user_hash.txt : No such file or directory" - requires hash and dictionary files from bitcracker-cuda directory
- **Notes**: Not in standard subset. Requires hash and dictionary input files that don't exist in the expected location.

---

## bitonic-sort-sycl
- **Args**: n (array size), k (number of iterations)
- **Current**: ["25", "2"]
- **Minimal**: ["10", "1"]
- **Compilation**: Success
- **Execution Time**: 0.15 seconds
- **Result**: PASS
- **Notes**: Reduce array size and iterations.

---

## bitpacking-sycl
- **Args**: None (no arguments)
- **Current**: [] (no args)
- **Minimal**: []
- **Compilation**: Success (with warnings)
- **Execution Time**: 6.89 seconds
- **Result**: Success
- **Notes**: Takes no arguments, uses hardcoded values.

---

## bitpermute-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"]
- **Compilation**: Success (with warnings about -fopenmp)
- **Execution Time**: 42.77 seconds (for lg_domain_size=27)
- **Result**: FAIL - Correctness error: verification fails (memcmp returns non-zero) - bit reversal permutation produces incorrect results
- **Notes**: Not in standard subset. Runs but fails verification - bit reversal permutation produces incorrect output compared to CPU reference.

---

## black-scholes-sycl
- **Args**: repeat
- **Current**: ["100"]
- **Minimal**: ["10"]
- **Compilation**: Success
- **Execution Time**: 3.14 seconds
- **Result**: PASS
- **Notes**: Reduce repeat from 100 to 10 for quick test.

---

## blas-dot-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "1"]
- **Compilation**: Success
- **Execution Time**: 3.19 seconds
- **Result**: FAIL - Correctness error: "Host: 65664.062500 Device: 65536.000000" - oneMKL dot product result doesn't match host computation (BF16 precision issue)
- **Notes**: Not in standard subset. Runs but fails correctness check - BF16 dot product produces incorrect result compared to host computation.

---

## blas-gemmBatched-sycl
- **Args**: Uses getopt with -l (lower), -u (upper), -n (num/batch_size), -r (reps), -v (verbose) flags
- **Current**: Not in subset.json
- **Minimal**: ["-l", "2", "-u", "10", "-n", "10", "-r", "1"] (from make run defaults: lower=2, upper=100, num=25000, reps=10)
- **Compilation**: Success
- **Execution Time**: Very slow - times out with minimal params (exit code 141 = SIGTERM from timeout)
- **Result**: FAIL - Very slow execution - times out even with minimal parameters. Benchmark runs but takes too long to complete.
- **Notes**: Not in standard subset. Benchmark executes but is extremely slow, timing out even with minimal parameters. Default make run uses num=25000 which is very large.

---

## blas-gemmEx2-sycl
- **Args**: Testing...
- **Current**: Not in subset.json
- **Minimal**: Testing...
- **Compilation**: FAIL - Missing dnnl.hpp header (fatal error: 'oneapi/dnnl/dnnl.hpp' file not found)
- **Compilation Error**: Requires oneAPI DNNL library headers
- **Notes**: Not in standard subset. Requires DNNL library.

---

## blas-gemmEx-sycl
- **Args**: M, N, K, iterations
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.14 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters. Tests multiple precision modes (fp64, fp32, fp16, bf16, int8).

---

## blas-gemmStridedBatched-sycl
- **Args**: Uses getopt with -l (lower), -u (upper), -n (num/batch_size), -r (reps), -v (verbose) flags
- **Current**: Not in subset.json
- **Minimal**: ["-l", "2", "-u", "10", "-n", "10", "-r", "1"] (from make run defaults: lower=2, upper=100, num=25000, reps=10)
- **Compilation**: Success
- **Execution Time**: Very slow - times out with minimal params (exit code 141 = SIGTERM from timeout)
- **Result**: FAIL - Very slow execution - times out even with minimal parameters. Benchmark runs but takes too long to complete.
- **Notes**: Not in standard subset. Benchmark executes but is extremely slow, timing out even with minimal parameters. Default make run uses num=25000 which is very large.

---

## blas-gemm-sycl
- **Args**: m, k, n, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.16 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters. Tests multiple precision modes (half, float, double).

---

## blockAccess-sycl
- **Args**: number_of_rows, number_of_columns, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.15 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters.

---

## blockexchange-sycl
- **Args**: number_of_rows, number_of_columns, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "1"]
- **Compilation**: Success
- **Execution Time**: 0.17 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal parameters.

---

## bm3d-sycl
- **Args**: NoisyImage (file), DenoisedImage (file), sigma, [color optional], [ReferenceImage optional]
- **Current**: Not in subset.json
- **Minimal**: Requires image files (cannot test without input images)
- **Compilation**: Success
- **Execution Time**: N/A - Requires image files
- **Result**: FAIL - Requires image input files (NoisyImage, DenoisedImage)
- **Notes**: Not in standard subset. Requires bitmap image files as input/output. Cannot run without test images.

---

## bmf-sycl
- **Args**: dataset_file (or "test" for random data), [-r runs], [-l lines], [-i iterations], [--seed seed], [--stuck stuck_iterations], [other optional flags]
- **Current**: Not in subset.json
- **Minimal**: ["test", "-r", "1", "-l", "10", "-i", "10", "--seed", "123", "--stuck", "10"]
- **Compilation**: Success
- **Execution Time**: 0.30 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Uses "test" to generate random test data instead of requiring input file. Minimal parameters work correctly.

---

## bn-sycl
- **Args**: output_file_path, repeat
- **Current**: Not in subset.json
- **Minimal**: ["/tmp/bn_test_output.txt", "1"]
- **Compilation**: Success (with warnings)
- **Execution Time**: 10.67 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Requires output file path. Works correctly with minimal parameters.

---

## bonds-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100)
- **Compilation**: Success
- **Execution Time**: 8.03 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Uses hardcoded 1000000 bonds internally. Works correctly with minimal repeat.

---

## b+tree-sycl
- **Args**: file input_file, command command_file
- **Current**: Not in subset.json
- **Minimal**: ["file", "../../data/b+tree/mil.txt", "command", "../../data/b+tree/command.txt"] (corrected path from /space/pvelesko/HeCBench/data/)
- **Compilation**: Success
- **Execution Time**: 1.07 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. B+ tree search on graph data. Files located in /space/pvelesko/HeCBench/data/b+tree/ (2 levels up from src subdirectory).

---

## btree-sycl
- **Args**: numKeys (optional, default 1<<20), numQueries (optional, default numKeys)
- **Current**: Not in subset.json
- **Minimal**: ["1000", "1000"] (from make run: 50000000 50000000)
- **Compilation**: FAIL
- **Compilation Error**: `./map_warps.h:83:25: error: no member named 'ctz' in namespace 'sycl::ext::intel'; did you mean 'sycl::ctz'?` - Uses deprecated sycl::ext::intel::ctz instead of sycl::ctz
- **Notes**: Not in standard subset. Compilation fails due to deprecated SYCL extension API usage.

---

## burger-sycl
- **Args**: dim_x, dim_y, nt (number of time steps)
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "10"] (from make run: 8200 8100 100)
- **Compilation**: Success
- **Execution Time**: 0.16 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal grid dimensions and time steps.

---

## bwt-sycl
- **Args**: sequence_length (optional, default 1000000)
- **Current**: Not in subset.json
- **Minimal**: ["1000"] (default is 1E6)
- **Compilation**: Success
- **Execution Time**: 0.14 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Takes optional sequence length argument. Works correctly with minimal sequence length.

---

## car-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100)
- **Compilation**: Success
- **Execution Time**: 17.48 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal repeat. Uses hardcoded image dimensions (128x3x480x640).

---

## cbsfil-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["128", "128", "1"] (from make run: 8192 8192 100)
- **Compilation**: Success
- **Execution Time**: 0.13 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal dimensions and repeat.

---

## ccsd-trpdrv-sycl
- **Args**: nocc, nvir, maxiter (optional, default 100), nkpass (optional, default 1)
- **Current**: Not in subset.json
- **Minimal**: ["10", "50", "10"] (from make run: 40 200 100)
- **Compilation**: Success
- **Execution Time**: 0.19 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Works correctly with minimal dimensions. CCSD coupled cluster doubles calculation.

---

## ccs-sycl
- **Args**: -t threshold, -i input_file, -o output_file, -m max_bicluster, -r repeat (optional, default 0), other flags
- **Current**: Not in subset.json
- **Minimal**: ["-t", "0.5", "-i", "../ccs-cuda/Data_Constant_100_1_bicluster.txt", "-o", "/tmp/out.txt", "-m", "10", "-r", "1"] (from make run)
- **Compilation**: Success
- **Execution Time**: 2.08 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Requires input file (exists). Biclustering algorithm for gene expression data.

---

## cc-sycl
- **Args**: input_file (ECL format), repeat
- **Current**: Not in subset.json
- **Minimal**: No suitable input files available
- **Compilation**: Success
- **Execution Time**: N/A
- **Result**: FAIL - No input graph files available - requires rmat*.mtx ECL format graph files  which are not included
- **Notes**: Not in standard subset. Connected Components algorithm requires ECL graph format. No graph data files present in repository.

---

## ced-sycl
- **Args**: -a alpha (fraction for CPU, default 0.2), -w warmup (default 10), -r repeat (default 100), -f input_folder (default input/peppa/), -c comparison_folder, other flags
- **Current**: Not in subset.json
- **Minimal**: ["-a", "0", "-w", "1", "-r", "1"] (from make run: default is -a 0)
- **Compilation**: Success
- **Execution Time**: 0.45 seconds
- **Result**: FAIL - Correctness failure: "Test failed with 2 errors" - verification fails
- **Notes**: Not in standard subset. Canny edge detection. Fails verification even with minimal parameters (requires input video frames).

---

## cfd-sycl
- **Args**: data_file (CFD mesh file)
- **Current**: Not in subset.json
- **Minimal**: Input file not found
- **Compilation**: Success
- **Execution Time**: N/A - Input file not found
- **Result**: FAIL - Missing input file: ../data/cfd/fvcorr.domn.097K - requires CFD domain mesh file
- **Notes**: Not in standard subset. Requires CFD mesh file. Input file not available.

---

## chacha20-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1000"] (from make run: 100000)
- **Compilation**: Success
- **Execution Time**: 0.45 seconds
- **Result**: FAIL - Correctness error: memcmp returns non-zero (FAIL) - encryption result doesn't match expected keystream
- **Notes**: Not in standard subset. Chacha20 stream cipher test. Fails correctness check even with minimal parameters.

---

## channelShuffle-sycl
- **Args**: group_size, width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["2", "4", "4", "1"] (default has nested loops with N,C 1-64, 32-512)
- **Compilation**: Success
- **Execution Time**: 0.18 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Tests NCHW and NHWC channel shuffle formats. Works with minimal dimensions.

---

## channelSum-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["4", "4", "1"] (default has nested loops with N,C 1-64, 32-512)
- **Compilation**: Success
- **Execution Time**: 0.16 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Tests channel sum for NHWC and NCHW formats. Works with minimal dimensions.

---

## chemv-sycl
- **Args**: None (hardcoded REPEAT=1000, N=370)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments, runs with hardcoded values)
- **Compilation**: Success
- **Execution Time**: 1.91 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Complex hermitian matrix-vector multiplication. Fixed problem size (N=370).

---

## chi2-sycl
- **Args**: rows, cols, cases, controls, threads, repeat
- **Current**: Not in subset.json
- **Minimal**: ["100", "100", "10", "5", "32", "1"] (typical values)
- **Compilation**: Success
- **Execution Time**: 0.13 seconds
- **Result**: FAIL - Correctness error: GPU kernel results don't match CPU reference computation
- **Notes**: Not in standard subset. Chi-squared test for genetic data. Fails verification (GPU vs CPU mismatch).

---

## clink-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10)
- **Compilation**: Success
- **Execution Time**: N/A - Missing input files (input.hpp, weight_1.hpp, weight_2.hpp)
- **Result**: FAIL - Missing weight and input files - LSTM neural network inference
- **Notes**: Not in standard subset. Requires pre-generated input and weight files which are not provided.

---

## complex-sycl
- **Args**: problem_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["10000", "1"] (from make run: 10000000 1000)
- **Compilation**: Success
- **Execution Time**: 1.01 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Tests complex number operations (float and double precision). Works with minimal problem size.

---

## convolution1D-sycl
- **Args**: input_width, repeat (repeats for different mask widths)
- **Current**: Not in subset.json
- **Minimal**: ["1024", "1"] (from make run: 134217728 1000)
- **Compilation**: Success (6 warnings)
- **Execution Time**: 0.43 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Tests 1D convolution with multiple implementations and data types (FP64, FP32, INT16). Works with minimal input width.

---

## dct8x8-sycl
- **Args**: image_width, image_height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "64", "1"] (from make run: 8192 8192 100)
- **Compilation**: Success
- **Execution Time**: 0.20 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Discrete Cosine Transform 8x8. Tests both forward and inverse DCT. Works with minimal image size.

---

## dpid-sycl
- **Args**: output_width, output_height, lambda, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run)
- **Compilation**: Success
- **Execution Time**: < 0.01 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Image processing algorithm. Works with minimal dimensions.

---

## dropout-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1000", "1"] (typical values)
- **Compilation**: Success
- **Execution Time**: < 0.01 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Neural network dropout layer. Works with minimal element count.

---

## dslash-sycl
- **Args**: None (hardcoded parameters)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments)
- **Compilation**: Success
- **Execution Time**: 1.95 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Lattice QCD dslash operator computation. Fixed problem size.

---

## heat-sycl
- **Args**: size_x, size_y, size_z, num_iterations, repeat
- **Current**: Not in subset.json
- **Minimal**: Varies - requires exploration
- **Compilation**: Success
- **Execution Time**: ~0.43 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Heat equation solver. Works with various dimensions.

---

## fft-sycl
- **Args**: log2_n (power of 2), repeat
- **Current**: Not in subset.json
- **Minimal**: ["3", "1"] (from make run: 3 100)
- **Compilation**: Success
- **Execution Time**: 0.20 seconds
- **Result**: PARTIAL (FFT PASS, iFFT FAIL) - Inverse FFT fails
- **Notes**: Not in standard subset. Fast Fourier Transform. Forward FFT works, inverse fails verification.

---

## floydwarshall-sycl
- **Args**: number_of_nodes, iterations, block_size
- **Current**: Not in subset.json
- **Minimal**: ["1024", "1", "16"] (from make run)
- **Compilation**: Success
- **Execution Time**: 0.84 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. All pairs shortest path algorithm. Works with minimal nodes.

---

## floydwarshall2-sycl
- **Args**: Requires input file (graph)
- **Current**: Not in subset.json
- **Minimal**: File-based input required
- **Compilation**: Success
- **Execution Time**: N/A
- **Result**: FAIL - Missing input file - expects graph file as argument
- **Notes**: Not in standard subset. ECL-APSP (All-Pairs Shortest Path). Requires external graph file input.

---

## ddbp-sycl
- **Args**: None (all parameters hardcoded in main())
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments - program takes none)
- **Compilation**: FAIL - Ambiguous calls to cos/sin functions. Error: "call to 'cos' is ambiguous" and "call to 'sin' is ambiguous" at lines 578-579. Requires std::cos/std::sin or explicit namespace qualification.
- **Execution Time**: N/A (compilation failed)
- **Result**: FAIL - Compilation error prevents execution
- **Notes**: Distance-driven backprojection for 3D volume reconstruction. All parameters (nPixX=1996, nPixY=2457, nSlices=78, nDetX=1664, nDetY=2048, nProj=15) are hardcoded. No command-line arguments. Compilation fails due to ambiguous cos/sin calls in SYCL context.

---

## debayer-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "64", "1"] (from make run: 8192 8192 100)
- **Compilation**: Success (warnings about deprecated get_pointer)
- **Execution Time**: 0.072 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Bayer pattern demosaicing (Malvar-He-Cutler algorithm). Converts single-channel Bayer pattern image to RGB. Works with minimal dimensions 64x64.

---

## degrid-sycl
- **Args**: None (all parameters hardcoded in degrid.h)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments - program takes none)
- **Compilation**: Success
- **Execution Time**: > 30 seconds (timeout)
- **Result**: FAIL - Times out with hardcoded parameters (NPOINTS=40000, IMG_SIZE=8192, REPEAT=100, GCF_DIM=256)
- **Notes**: Not in standard subset. Degridding operation for radio astronomy imaging. All parameters are compile-time constants in degrid.h. Program times out with default hardcoded values. Would require source modification to reduce problem size.

---

## dense-embedding-sycl
- **Args**: number_of_rows, batch_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["5", "2", "1"] (from make run: 100000 256 1000, constraint: nrows > batch_size^2)
- **Compilation**: Success
- **Execution Time**: < 0.01 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Dense embedding operation for neural networks. Tests multiple embedding dimensions (768, 2048, 12288) and block sizes. Requires nrows > batch_size^2 assertion.

---

## depixel-sycl
- **Args**: image_width, image_height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["256", "256", "1"] (from make run: 2048 2048 10, size must be multiple of 256)
- **Compilation**: FAIL - Type mismatch: kernels.h uses `float3` but should use `sycl::float3`. Error: "member reference base type 'float' is not a structure or union" at lines 7-10 in kernels.h. The function `rgbToyuv` expects `float3` but it's not properly defined.
- **Execution Time**: N/A (compilation failed)
- **Result**: FAIL - Compilation error prevents execution
- **Notes**: Not in standard subset. Depixelization algorithm for image processing. Removes pixel artifacts by checking connectivity between neighboring pixels. Requires size to be multiple of 256 (nthreads). Compilation fails due to missing `sycl::` namespace prefix for `float3` type in kernels.h.

---

## deredundancy-sycl
- **Args**: Optional flags: `i inputFile`, `o outputFile`, `t threshold` (defaults: testData.fasta, result.fasta, 0.95)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments - uses defaults, but requires input file testData.fasta)
- **Compilation**: Success (warnings about deprecated get_pointer)
- **Execution Time**: 0.637 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. DNA sequence redundancy removal/clustering. Requires FASTA format input file. Threshold must be between 0.8 and 1.0. Works with minimal 2-sequence FASTA file.

---

## determinant-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000)
- **Compilation**: FAIL - Missing oneDPL headers. Error: "fatal error: 'oneapi/dpl/execution' file not found". Makefile references `-I./oneDPL/include -I./oneTBB/include` but these directories don't exist in the source tree. Requires oneDPL (oneAPI Data Parallel Library) dependency.
- **Execution Time**: N/A (compilation failed)
- **Result**: FAIL - Compilation error prevents execution
- **Notes**: Not in standard subset. Matrix determinant computation using Cholesky factorization via oneMKL LAPACK. Matrix size is hardcoded (11x11). Requires oneDPL library for parallel execution policies and oneTBB for threading.

---

## diamond-sycl
- **Args**: command [options] (e.g., `benchmark`, `blastx -q query.fasta -d database -o output`)
- **Current**: Not in subset.json
- **Minimal**: ["benchmark"] (from make run: `blastx -q long.fastq.gz -d ARDB -o long_cur.m8 --tmpdir /dev/shm -p1`)
- **Compilation**: Success (warnings about deprecated auto_ptr)
- **Execution Time**: < 0.01 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. DIAMOND protein aligner (BLAST-like). Supports multiple commands: blastx, blastp, makedb, benchmark, etc. The `benchmark` command runs without input files and performs a simple benchmark test. For alignment commands, requires query file (-q), database file (-d), and output file (-o).

---

## dispatch-sycl
- **Args**: None (all parameters hardcoded in main.cpp)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments - program takes none)
- **Compilation**: Success
- **Execution Time**: < 0.1 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Measures SYCL kernel dispatch performance (enqueue rate, single dispatch latency, batch dispatch latency). All parameters are compile-time constants: NUM_GROUPS=1, GROUP_SIZE=1, WARMUP_RUN_COUNT=100, TIMING_RUN_COUNT=1000, BATCH_SIZE=1000.

---

## distort-sycl
- **Args**: input_image_width, input_image_height, coefficient_of_distortion, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "64", "0.001", "1"] (from make run: 1024 1024 0.001 1000)
- **Compilation**: FAIL - Missing header file. Error: "fatal error: 'common.h' file not found" at line 4 in distort.h. The header file common.h is referenced but does not exist in the source directory.
- **Execution Time**: N/A (compilation failed)
- **Result**: FAIL - Compilation error prevents execution
- **Notes**: Not in standard subset. Barrel distortion image processing. Applies radial distortion correction to images. Requires width, height, distortion coefficient K, and repeat count. Uses 16x16 local work size. Compilation fails due to missing common.h header file.

---

## divergence-sycl
- **Args**: [input_file] [num_tests] (both optional: defaults to stdin and 100000)
- **Current**: Not in subset.json
- **Minimal**: ["input.txt", "1"] (from make run: input.txt 10000)
- **Compilation**: Success (warnings about pragma messages)
- **Execution Time**: < 0.001 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Computes divergence of velocity field on a sphere. Reads velocity, element, derivative, and divergence data from input file. NP=4 is hardcoded. Compares CPU and GPU results. Works with minimal 1 test iteration.

---

## doh-sycl
- **Args**: height, width, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "64", "1"] (from make run: 480 640 100)
- **Compilation**: Success
- **Execution Time**: 0.057 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Determinant of Hessian (DoH) feature detection using SURF algorithm. Computes approximate Hessian determinant over 2D integral image using box filters. Uses sigma=4.0 hardcoded. Works with minimal dimensions 64x64.

---

## dpid-sycl
- **Args**: output_width, output_height, lambda, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "64", "0.5", "1"] (from make run: 640 480 0.5 100)
- **Compilation**: Success
- **Execution Time**: 5.574 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Domain-preserving image downsampling using guided filtering. Input image size is hardcoded (8192x8192). Output dimensions can be 0 (one of them) to maintain aspect ratio. Lambda parameter controls filtering strength. Works with minimal output dimensions 64x64.

---

## dp-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "1"] (from make run: 268435456 1000)
- **Compilation**: FAIL - Missing oneDPL headers. Error: "fatal error: 'oneapi/dpl/execution' file not found" at line 19 in main.cpp. Makefile references `-I ./oneDPL/include -I ./oneTBB/include` but these directories don't exist in the source tree. Requires oneDPL (oneAPI Data Parallel Library) and oneTBB dependencies.
- **Execution Time**: N/A (compilation failed)
- **Result**: FAIL - Compilation error prevents execution
- **Notes**: Not in standard subset. Vector dot product computation using oneMKL and oneDPL. Tests both float and double precision. Uses oneMKL dot product and std::transform_reduce from oneDPL. Requires oneDPL and oneTBB libraries.

---

## dropout-sycl
- **Args**: number_of_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["64", "1"] (from make run: 16777216 1000)
- **Compilation**: Success
- **Execution Time**: N/A (runtime crash)
- **Result**: FAIL - Runtime crash: "Native API failed. Native API returns: 20 (UR_RESULT_ERROR_DEVICE_LOST)" - device lost error. The SYCL runtime indicates the device became unavailable during execution.
- **Notes**: Not in standard subset. Dropout operation for neural networks using oneMKL RNG (Philox generator). Tests three vectorization levels (VEC1, VEC2, VEC4). Uses oneMKL RNG device API for random number generation. Fails with device lost error even with minimal parameters.

---

## dslash-sycl
- **Args**: workgroup_size
- **Current**: Not in subset.json
- **Minimal**: ["32"] (from make run: 256)
- **Compilation**: Success
- **Execution Time**: 0.431 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Dslash operator for lattice QCD (quantum chromodynamics). Computes Wilson-Dirac dslash operator on 4D lattice. Lattice dimension (LDIM=32) and iterations (100) are hardcoded. Workgroup size controls SYCL kernel launch configuration. Works with minimal workgroup size 32.

---

## dwconv1d-sycl
- **Args**: None (Python script, no command-line arguments)
- **Current**: Not in subset.json
- **Minimal**: [] (no arguments - script runs tests automatically)
- **Compilation**: N/A (Python script)
- **Execution Time**: N/A (runtime failure)
- **Result**: FAIL - Runtime failure: "ModuleNotFoundError: No module named 'torch'". Requires PyTorch and Intel Extension for PyTorch (XPU) dependencies. This is a Python-based benchmark that uses PyTorch with SYCL backend for depthwise 1D convolution operations.
- **Notes**: Not in standard subset. Python-based benchmark using PyTorch and Intel Extension for PyTorch. Implements TimeX operator (depthwise 1D convolution) for RWKV language model. No command-line arguments - script runs verification and benchmark tests automatically. Requires PyTorch and Intel Extension for PyTorch to be installed.

---

## dwconv-sycl
- **Args**: batch_size, input_channels, height, width, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "4", "4", "1"] (from make run: 128 16 224 224 100)
- **Compilation**: Success
- **Execution Time**: < 0.1 seconds (runs 12 configurations: m=1-4, k=1,3,5)
- **Result**: PASS
- **Notes**: Not in standard subset. Depthwise 2D convolution operation. Sweeps over depth multipliers (m=1-4) and kernel sizes (k=1,3,5), running 12 total configurations. Uses tensor accessors for memory layout. Works with minimal dimensions 1x1x4x4.

---

## dwt2d-sycl
- **Args**: input_file, -d dimensions (WxH), -f (forward), -5 (5/3 transform), -l levels
- **Current**: Not in subset.json
- **Minimal**: ["minimal.rgb", "-d", "4x4", "-f", "-5", "-l", "1"] (from make run: rgb.bmp -d 1024x1024 -f -5 -l 3)
- **Compilation**: Success (with deprecation warnings)
- **Execution Time**: 0.45 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. 2D Discrete Wavelet Transform (DWT). Requires input RGB image file in `../data/dwt2d/` directory. Created minimal 4x4 RGB image (48 bytes) for testing. Supports forward/reverse transforms and 5/3 or 9/7 transforms (9/7 not implemented in SYCL). Minimal dimensions 4x4 work correctly.

---

## dxtc1-sycl
- **Status**: Directory does not exist
- **Result**: SKIP - Benchmark directory not found in src/

---

## dxtc2-sycl
- **Status**: Directory does not exist
- **Result**: SKIP - Benchmark directory not found in src/

---

## easyWave-sycl
- **Args**: -grid grid_file, -source source_file, -time minutes
- **Current**: Not in subset.json
- **Minimal**: ["-grid", "../easyWave-omp/data/grids/e2Asean.grd", "-source", "../easyWave-omp/data/faults/BengkuluSept2007.flt", "-time", "1"] (from make run: -grid ../easyWave-omp/data/grids/e2Asean.grd -source ../easyWave-omp/data/faults/BengkuluSept2007.flt -time 120)
- **Compilation**: Success (with warnings)
- **Execution Time**: 0.51 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Tsunami simulation program. Requires grid file (bathymetry) and source file (fault/earthquake data). Time is specified in minutes (converted to seconds internally). Minimal time of 1 minute works correctly. Uses existing data files from easyWave-omp directory.

---

## ecdh-sycl
- **Args**: num_pk (number of keys), repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 50000000 100)
- **Compilation**: Success
- **Execution Time**: 0.14 seconds (slow kernel: 0.14s, fast kernel: 0.000123s)
- **Result**: PASS
- **Notes**: Not in standard subset. Elliptic Curve Diffie-Hellman key exchange. Generates public keys using slow and fast kernel implementations, then verifies they produce the same results. Minimal parameters (1 key, 1 repeat) work correctly. Uses elliptic curve cryptography with modulus 17 and curve parameter a=2.

---

## eigenvalue-sycl
- **Args**: length (diagonal size), iterations
- **Current**: Not in subset.json
- **Minimal**: ["256", "1"] (from make run: 2048 10000)
- **Compilation**: Success
- **Execution Time**: 0.056 seconds (56.4 ms)
- **Result**: PASS
- **Notes**: Not in standard subset. Computes eigenvalues of a symmetric tridiagonal matrix using bisection method. Code enforces minimum length of 256 (rounds to power of 2 if needed). Minimal parameters (256x256 matrix, 1 iteration) work correctly. Uses Gerschgorin interval to bound eigenvalues, then bisects intervals until convergence.

---

## eikonal-sycl
- **Args**: -s size (volume size cubed), -m type (speed init), -i iter_per_block, -o output_name, -v (verbose)
- **Current**: Not in subset.json
- **Minimal**: ["-s", "4"] (from make run: -s 512)
- **Compilation**: Success (with deprecation warnings)
- **Execution Time**: 0.48 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Fast Iterative Method (FIM) for solving Eikonal equations on 3D structured grids. Computes distance field from seed points. Minimal size 4x4x4 (64 voxels) works correctly. Default size is 256, iterations per block is 10, output file is "output.nrrd".

---

## entropy-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["16", "16", "1"] (from make run: 8192 8192 100)
- **Compilation**: Success (with warnings about char subscripts)
- **Execution Time**: 0.002 seconds (baseline: 0.002338s, optimized: 0.001514s)
- **Result**: PASS
- **Notes**: Not in standard subset. Computes entropy of a 2D image using a 5x5 sliding window. For each pixel, counts occurrences of values 0-15 in its neighborhood and calculates Shannon entropy. Minimal parameters (16x16 image, 1 repeat) work correctly. Uses two kernel implementations: baseline and optimized (with lookup table for log2).

---

## epistasis-sycl
- **Args**: num_pac (number of samples), num_snp (number of SNPs), iteration
- **Current**: Not in subset.json
- **Minimal**: ["8", "8", "1"] (from make run: 146 31339 100)
- **Compilation**: Success
- **Execution Time**: 0.004 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Detects epistatic interactions between pairs of SNPs (Single Nucleotide Polymorphisms) in genetic data. Computes interaction scores using contingency tables and gamma functions. Minimal parameters (8 samples, 8 SNPs, 1 iteration) work correctly. Uses binary encoding of SNP data for efficient bitwise operations.

---

## ert-sycl
- **Args**: gpu_blocks, gpu_threads
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1024 256)
- **Compilation**: Success
- **Execution Time**: Timeout (hangs indefinitely)
- **Result**: SKIP (timeout/hang)
- **Notes**: Not in standard subset. Empirical Roofline Toolkit (ERT) for measuring memory bandwidth and compute performance. Tests FP16, FP32, and FP64 performance with various working set sizes. Benchmark hangs indefinitely even with minimal parameters (1 block, 1 thread) - likely a runtime issue with the kernel execution or memory allocation. Uses large memory buffers (ERT_MEMORY_MAX = 33554432 bytes) and performs extensive compute operations.

---

## expdist-sycl
- **Args**: size (number of points in each set), repeat
- **Current**: Not in subset.json
- **Minimal**: ["32", "1"] (from make run: 16384 1000)
- **Compilation**: Success (warnings about deprecated get_pointer())
- **Execution Time**: 0.004 seconds (single precision), 0.007 seconds (double precision)
- **Result**: FAIL (correctness error)
- **Notes**: Not in standard subset. Computes exponential distance cost function between two point sets (Bhattacharya cost). Uses tiled parallelization with 2D thread blocks. Benchmark runs to completion but produces incorrect device results (0.000000) while host computation matches analytical result. This indicates a correctness issue in the SYCL kernel implementation, possibly in the reduction step. Both single and double precision tests show the same issue.

---

## extend2-sycl
- **Args**: repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 2000)
- **Compilation**: Success
- **Execution Time**: 0.008 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Sequence alignment using extend2 algorithm (similar to BLAST). Reads test data from testdata/ directory (17 binary files with query/target sequences). Performs dynamic programming-based sequence alignment with gap penalties. Minimal parameter (1 repeat) works correctly. Uses SYCL for GPU acceleration of alignment computation.

---

## extrema-sycl
- **Args**: repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100)
- **Compilation**: Success
- **Execution Time**: 0.251 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Detects relative extrema (local maxima/minima) in 1D and 2D arrays. Tests multiple data types (int, long, float, double) and orders (1, 2, 4, 8, 16, 32, 64, 128). Uses clipping mode for boundary handling. Verifies correctness by comparing GPU results with CPU reference implementation. Minimal parameter (1 repeat) works correctly. The benchmark runs comprehensive tests across all combinations of types, orders, and dimensions.

---

## f16atomic-sycl
- **Args**: N (total number of elements, must be multiple of 2), repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["2", "1"] (from make run: 131072 100, 262144 100)
- **Compilation**: Success (warnings about format specifiers for half/bfloat16 types)
- **Execution Time**: 0.000265 seconds (FP16: 197.5us, BF16: 67.8us)
- **Result**: PASS
- **Notes**: Not in standard subset. Tests 16-bit floating-point atomic add operations on global memory for both FP16 (half precision) and BF16 (bfloat16) types. Uses custom atomicAdd implementations for half2 and bfloat162 vector types. Minimal parameter (N=2, repeat=1) works correctly. The benchmark verifies atomic operations by performing atomic additions and printing results.

---

## f16max-sycl
- **Args**: repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100)
- **Compilation**: Success
- **Execution Time**: 0.025 seconds (fp16_hmax2: 10.9ms, fp16_hmax: 13.8ms)
- **Result**: PASS
- **Notes**: Not in standard subset. Tests FP16 (half precision) maximum operations for both half2 (vector) and half (scalar) types. Uses fixed problem size: NUM_OF_BLOCKS=1048576, NUM_OF_THREADS=256 (total 268435456 elements). Implements custom half_max functions using byte permutation for efficient comparison. Verifies correctness by comparing GPU results with CPU fmaxf computation. Minimal parameter (1 repeat) works correctly. Both fp16_hmax2 and fp16_hmax tests pass.

---

## f16sp-sycl
- **Args**: repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000)
- **Compilation**: Success
- **Execution Time**: Timeout (hangs/times out with minimal params)
- **Result**: SKIP (timeout/hang)
- **Notes**: Not in standard subset. Tests FP16 (half precision) scalar product (dot product) operations using multiple kernel implementations. Uses fixed problem size: NUM_OF_BLOCKS=1048576, NUM_OF_THREADS=128 (total 134217728 elements). Tests multiple grid sizes (from NUM_OF_BLOCKS down to NUM_OF_BLOCKS/16) and multiple kernel variants (native FP16, native FP32, native2 FP32, and oneMKL blas::dot). Each grid size test performs 1000 warmup iterations before timing, making even minimal repeat=1 very slow. Benchmark times out (exit code 124) even with minimal parameters due to extensive warmup overhead.

---

## face-sycl
- **Args**: input_image.pgm classifier_info.txt class_info.txt output_image.pgm
- **Current**: Not in subset.json
- **Minimal**: ["../face-cuda/Face.pgm", "../face-cuda/info.txt", "../face-cuda/class.txt", "Output-gpu.pgm"] (from make run)
- **Compilation**: Success (warnings about unused variable 'version')
- **Execution Time**: 0.544 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Viola-Jones face detection algorithm using Haar cascade classifiers. Requires 4 arguments: input PGM image file, classifier information file (info.txt), class information file (class.txt), and output PGM image file. Uses fixed detection parameters: scaleFactor=1.2, minNeighbours=1. The benchmark detects faces in the input image and draws rectangles around detected faces in the output image. Input files are located in ../face-cuda/ directory (Face.pgm, info.txt, class.txt). Minimal parameters (same as make run) work correctly. The benchmark successfully detects faces and saves the output image.

---

## fdtd3d-sycl
- **Args**: --dimx=<N> --dimy=<N> --dimz=<N> --timesteps=<N> [--radius=<N>] [--work-group-size=<N>]
- **Current**: Not in subset.json
- **Minimal**: ["--dimx=96", "--dimy=96", "--dimz=96", "--timesteps=1"] (from make run: --dimx=192 --dimy=184 --timesteps=90, minimums from FDTD3dGPU.h: k_dim_min=96, k_timesteps_min=1)
- **Compilation**: Success (warnings about format string and unused variables)
- **Execution Time**: 0.004 seconds (average kernel execution time)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 3D Finite-Difference Time-Domain (FDTD) method for solving Maxwell's equations. Requires command-line flags: --dimx, --dimy, --dimz (dimensions excluding halo, minimum 96 each), --timesteps (minimum 1). Optional: --radius (stencil radius, default 4), --work-group-size. The benchmark performs FDTD computation on a 3D volume with symmetric filter radius, comparing GPU results with CPU reference implementation. Minimal parameters (96x96x96 volume, 1 timestep) work correctly. The benchmark verifies correctness by comparing device output with host reference output within tolerance 0.000100.

---

## feynman-kac-sycl
- **Args**: iterations (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10)
- **Compilation**: Success
- **Execution Time**: N/A (runtime crash)
- **Result**: FAIL (runtime crash)
- **Notes**: Not in standard subset. Implements Feynman-Kac method for solving 2D elliptic PDE using Monte Carlo simulation. Uses fixed parameters: N=1000 trajectories per grid point, h=0.001 stepsize, a=2.0, b=1.0 (ellipse parameters), grid dimensions ni x nj (nj=128, ni calculated from a/b ratio). The benchmark crashes at runtime with "Native API failed. Native API returns: 20 (UR_RESULT_ERROR_DEVICE_LOST)" - device lost error, indicating the SYCL runtime lost connection to the device during execution. This is a runtime crash, not a correctness error.

---

## fft-sycl
- **Args**: problem_size (0-3: 0=1M, 1=8M, 2=96M, 3=256M), number_of_passes
- **Current**: Not in subset.json
- **Minimal**: ["0", "1"] (from make run: 3 100, minimal: problem_size=0 for 1M, passes=1)
- **Compilation**: Success
- **Execution Time**: 0.009 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 1D Fast Fourier Transform (FFT) and inverse FFT (iFFT) using SYCL. The benchmark performs FFT and iFFT operations on complex data arrays. Problem size 0 corresponds to 1MB (65536 complex numbers), which is the smallest size. The benchmark verifies correctness by comparing GPU results with CPU reference implementation within tolerance (1e-4 for float, 1e-6 for double). Minimal parameters (problem size 0, 1 pass) work correctly. Both FFT and iFFT pass verification.

---

## fhd-sycl
- **Args**: #samples, #voxels, verify (0=no verification, 1=verify)
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "0"] (from make run: 100000 2097152 0, minimal: samples=1, voxels=1, verify=0)
- **Compilation**: Success
- **Execution Time**: 0.045 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Fast Holographic Deconvolution (FHd) algorithm using SYCL. The benchmark performs complex-valued convolution operations on 3D k-space data. Samples represent the number of data points, voxels represent the number of 3D volume elements. The verify flag controls whether to perform CPU verification (0=no verification, 1=verify). Minimal parameters (1 sample, 1 voxel, no verification) work correctly.

---

## filter-sycl
- **Args**: number_of_elements, block_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 100000000 256 100, minimal: elements=1, block_size=1, repeat=1)
- **Compilation**: Success
- **Execution Time**: 0.007 seconds (average of both filter implementations)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements parallel filter operation that extracts elements matching a predicate (elements > 0) from an input array. Uses two implementations: shared memory-based filter and global aggregate-based filter. The benchmark verifies correctness by comparing device results with host results (sorted for comparison). Minimal parameters (1 element, block size 1, 1 repeat) work correctly. Both filter implementations pass verification.

---

## flame-sycl
- **Args**: repeat (number of iterations)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: Success (warnings: unused variable 'phi')
- **Execution Time**: 9.16 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements fractal flame generator using SYCL. The benchmark generates fractal patterns using iterative transformations. Uses fixed parameters: NUM_THREADS=16384, NUM_ITERATIONS=15 per repeat, NUM_POINTS_PER_THREAD=64. The repeat argument controls how many times the main loop runs. Minimal parameter (repeat=1) works correctly.

---

## flip-sycl
- **Args**: number_of_dimensions, size_of_each_dimension, repeat
- **Current**: Not in subset.json
- **Minimal**: ["3", "1", "1"] (from make run: 3 1024 100, minimal: num_dims=3, dim_size=1, repeat=1)
- **Compilation**: Success (warnings: use of '-qopenmp' recommended over '-fopenmp')
- **Execution Time**: 0.001 seconds (average of FP32 and FP64)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements tensor flip operation using SYCL. The benchmark flips tensors along specified dimensions. Uses fixed number of flip dimensions equal to number of dimensions. Tests both FP32 and FP64 data types. Minimal parameters (3 dimensions, size 1, 1 repeat) work correctly. Both FP32 and FP64 pass verification.

---

## floydwarshall2-sycl
- **Args**: input_graph_name, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../floydwarshall2-cuda/CollegeMsg.egr", "1"] (from make run: ../floydwarshall2-cuda/CollegeMsg.egr 1000, minimal: repeat=1)
- **Compilation**: Success (warnings: deprecated 'get_pointer' method)
- **Execution Time**: 1.19 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Floyd-Warshall all-pairs shortest paths algorithm using SYCL. The benchmark operates on graphs stored in binary CSR format (ECL format). Requires input graph file with edge weights. Uses fixed work-group size of 1024 threads. The benchmark verifies correctness by comparing GPU results with CPU reference implementation. Minimal parameter (repeat=1) works correctly. Results match between GPU and CPU.

---

## floydwarshall-sycl
- **Args**: numNodes, iterations, blockSize
- **Current**: Not in subset.json
- **Minimal**: ["16", "1", "16"] (from make run: 1024 100 16, minimal: numNodes=16, iterations=1, blockSize=16)
- **Compilation**: Success
- **Execution Time**: 0.26 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Floyd-Warshall all-pairs shortest paths algorithm using SYCL. The benchmark generates a random graph with numNodes nodes and computes shortest paths between all pairs. Uses block-based tiling with blockSize x blockSize work-groups. If blockSize^2 > 256, it resets to 16. numNodes must be a multiple of blockSize (automatically adjusted if not). Verifies correctness by comparing GPU results with CPU reference implementation. Minimal parameters (16 nodes, 1 iteration, block size 16) work correctly. Results match between GPU and CPU.

---

## fluidSim-sycl
- **Args**: iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000, minimal: iterations=1)
- **Compilation**: Success
- **Execution Time**: 0.24 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Lattice Boltzmann Method (LBM) fluid simulation using SYCL. The benchmark simulates fluid flow on a 256x256 grid with 9 velocity directions per cell. Uses fixed grid dimensions (256x256) and omega (viscosity parameter) of 1.2. Verifies correctness by comparing GPU results with CPU reference implementation when VERIFY is enabled. Minimal parameter (1 iteration) works correctly. Results match between GPU and CPU.

---

## fma-sycl
- **Args**: NA, NC, C, num_ops, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 8192 8192 1031 8192 1000, minimal: NA=1, NC=1, C=1, num_ops=1, repeat=1)
- **Compilation**: Success
- **Execution Time**: ~0.04 seconds (total for all data types)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Fused Multiply-Add (FMA) operations using SYCL. The benchmark performs implicit FMA operations: grad_in_features[in_map] += grad_output[out_map] * weight[i]. Requires num_ops <= NC. Tests both "basic" and "rowwise" kernel implementations. Runs 2 trials, testing FP16, BF16, FP32, and FP64 data types. Verifies correctness by comparing GPU results with CPU reference implementation. Minimal parameters (all dimensions=1, num_ops=1, repeat=1) work correctly. All data types pass verification.

---

## fpc-sycl
- **Args**: work-group size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 256 100, minimal: work-group size=1, repeat=1)
- **Compilation**: Success
- **Execution Time**: ~0.0001 seconds (average per kernel)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements FPC (Floating Point Compression) using SYCL. The benchmark tests two kernel implementations (fpc and fpc2) that compress data using various compression patterns (zero, small values, repeated bytes, etc.). Verifies correctness by comparing GPU results with CPU reference implementation. Minimal parameters (work-group size=1, repeat=1) work correctly. Both kernels pass verification.

---

## fpdc-sycl
- **Args**: blocks, warpsperblock, repeat, dimensionality
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 255 8 100 2, minimal: blocks=1, warpsperblock=1, repeat=1, dimensionality=1)
- **Compilation**: Success (with deprecation warnings)
- **Execution Time**: ~2.64 seconds
- **Result**: PASS
- **Notes**: Not in standard subset. Implements FPDC (Floating Point Data Compression) using SYCL. The benchmark generates an input file (input.bin) with double-precision floating-point values, compresses it using GPU kernels, and writes the compressed output to output.bin. Reports compression ratio. Requires blocks < 256, warpsperblock < 256, dimensionality <= WARPSIZE (typically 32). Minimal parameters (blocks=1, warpsperblock=1, repeat=1, dimensionality=1) work correctly. Compression ratio is approximately 1.64.

---

## frechet-sycl
- **Args**: n_1, n_2, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 4 4 1000, minimal: n_1=1, n_2=1, repeat=1)
- **Compilation**: FAIL
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements discrete Frechet distance computation between two curves using SYCL. The benchmark tests three different norm implementations (norm1, norm2, norm3). **Compilation fails** because SYCL kernels cannot call recursive functions, and norm2.h and norm3.h use recursive functions (`recursive_norm2` and `recursive_norm3`). This is a known limitation mentioned in the README file. The benchmark cannot be built with the current SYCL implementation.

---

## fresnel-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (required creating missing common.h header file)
- **Execution Time**: ~0.89s (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Fresnel sine integral computation using SYCL. The benchmark computes Fresnel sine integrals for points in the range [0, 8] with interval 1e-7 (80 million points). The benchmark required creating a missing `common.h` header file that includes SYCL headers and math.h. The benchmark verifies results against a CPU reference implementation with a tolerance of 1e-6.

---

## frna-sycl
- **Args**: sequence_file, output_file
- **Current**: Not in subset.json
- **Minimal**: ["../frna-cuda/RD0260.seq", "test.out"] (from make test: ../frna-cuda/RD0260.seq rd0260.out, minimal: smallest sequence file)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~1.16s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements RNA secondary structure prediction using partition function calculation with SYCL. Requires DATAPATH environment variable to be set to the data_tables directory (extracted from ../prna-cuda/data_tables.tar.gz). The benchmark reads a sequence file, calculates partition functions, and writes results to an output file. Optional flags: `-h` (help), `-d` (use DNA parameters). Minimal test uses RD0260.seq (89 bytes, 81 base sequence).

---

## fsm-sycl
- **Args**: trace_length
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 65536, minimal: trace_length=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~0.35s (for trace_length=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements a genetic algorithm (GA) for finding well-performing finite-state machines (FSM) for predicting binary sequences using SYCL. The benchmark generates random trace data and uses a genetic algorithm to evolve FSMs. Reports runtime, throughput, and hit rates. Minimal test with trace_length=1 completes successfully.

---

## fwt-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~0.0088s per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Fast Walsh Transform (FWT) using SYCL for dyadic convolution computation. The benchmark computes Walsh-Hadamard transforms on data of length 8388608 (2^23) and kernel of length 128 (2^7). Verifies results against CPU reference implementation with L2 norm tolerance. Minimal test with repeat=1 completes successfully.

---

## gabor-sycl
- **Args**: height, width, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8640 15360 1000, minimal: height=1 width=1 repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~8.4ms per iteration (for height=1 width=1 repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Gabor filter computation using SYCL. The benchmark generates Gabor kernels for image processing applications. Verifies results against CPU reference implementation. Minimal test with height=1, width=1, repeat=1 completes successfully.

---

## gamma-correction-sycl
- **Args**: image_width, image_height, block_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 7680 4320 256 100, minimal: width=1 height=1 block_size=1 repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~0.0045s per iteration (for width=1 height=1 block_size=1 repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements gamma correction for image processing using SYCL. The benchmark applies gamma correction (gamma=2) to an image by converting RGB to grayscale and applying gamma transformation. Verifies results against CPU reference implementation. Minimal test with width=1, height=1, block_size=1, repeat=1 completes successfully.

---

## ga-sycl
- **Args**: target_sequence_length, query_sequence_length, coarse_match_length, coarse_match_threshold
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 1000000 1000 11 1, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.0000s (for all=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements genetic algorithm (GA) for sequence alignment using SYCL. The benchmark performs coarse-grained sequence matching between target and query sequences using Hamming distance. Verifies results against CPU reference implementation. Minimal test with all parameters=1 completes successfully.

---

## gaussian-sycl
- **Args**: [-f filename | -s size] [-q] [-t]
- **Current**: Not in subset.json
- **Minimal**: ["-s", "1"] (from make run: -q -t -s 4096, minimal: -s 1)
- **Compilation**: PASS (with VLA warnings)
- **Execution Time**: ~0.0000s (for size=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Gaussian elimination for solving linear systems using SYCL. The benchmark can read a matrix from a file (-f) or generate one internally (-s size). Optional flags: -q (quiet), -t (timing). Verifies results against CPU reference implementation. Minimal test with size=1 completes successfully.

---

## gc-sycl
- **Args**: input_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../floydwarshall2-cuda/CollegeMsg.egr", "1"] (from make run: ../mis-cuda/internet.egr 100, minimal: smallest graph file, repeat=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (runtime failure)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements ECL-GC graph coloring algorithm with shortcutting using SYCL. The benchmark reads a graph file in binary CSR format and performs graph coloring. Runtime failure with device error (UR_RESULT_ERROR_DEVICE_LOST). This may be a device-specific issue or require a different graph file.

---

## gd-sycl
- **Args**: file_path, lambda, alpha, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../gd-cuda/gisette_scale", "0.0001", "1", "1"] (from make run: ../gd-cuda/gisette_scale 0.0001 10 100, minimal: lambda=0.0001 alpha=1 repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A (file not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements gradient descent for classification using SYCL. The benchmark requires a .scale file (SVM format) that was not found. Error: "Could not find the SMV file, check again!"

---

## geam-sycl
- **Args**: m, n, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 16384 16384 200, minimal: m=1 n=1 repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~2.6ms per iteration (for 1x1 matrix)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements General Element-wise Add and Multiply (GEAM) using SYCL with oneMKL. Performs matrix transpose operations. Verifies results against CPU reference implementation. Minimal test with 1x1 matrix completes successfully.

---

## geglu-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: TIMEOUT (takes too long even with repeat=1)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements Gated Exponential Linear Unit (GEGLU) activation function using SYCL. The benchmark times out even with minimal repeat=1, suggesting it may require significant computation time or has initialization overhead.

---

## gels-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~3.5ms per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements General Linear System Solver (GELS) using SYCL with oneMKL. The benchmark performs linear system solving operations. Minimal test with repeat=1 completes successfully.

---

## gelu-sycl
- **Args**: batch_size, seq_len, hidden_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 8 4096 512 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~1.9ms per iteration (for all=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Gaussian Error Linear Unit (GELU) activation function using SYCL. The benchmark computes GELU activation with vectorized and baseline kernels. Verifies results against CPU reference implementation. Minimal test with all parameters=1 completes successfully.

---

## gemv-sycl
- **Args**: -s size -i iterations -x x_dim -y y_dim
- **Current**: Not in subset.json
- **Minimal**: ["-s", "1", "-i", "1", "-x", "8", "-y", "1"] (from make run: -s 16384 -i 100 -x 512 -y 2, minimal: size=1 iterations=1, but x_dim must be >=8 due to assertion)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (assertion failure with minimal args)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements General Matrix-Vector multiplication (GEMV) using SYCL. The benchmark has an assertion requiring `num_per_thread >= 8`, which means x_dim must be at least 8. Minimal test fails due to this constraint.

---

## geodesic-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~3.5ms per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements geodesic distance computation using SYCL. The benchmark reads city locations from a file and computes geodesic distances. Reports maximum error in distance calculation. Minimal test with repeat=1 completes successfully.

---

## ge-spmm-sycl
- **Args**: matrix_file, num_heads, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation failure)
- **Compilation**: FAIL (missing boost/program_options.hpp)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements General Sparse Matrix-Matrix multiplication (GE-SpMM) using SYCL. Compilation fails due to missing Boost library dependency (boost/program_options.hpp). Requires Boost to be installed and configured.

---

## gibbs-sycl
- **Args**: data_file, iterations
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation failure)
- **Compilation**: FAIL (compilation errors)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Gibbs sampling algorithm using SYCL. Compilation fails with multiple errors related to deprecated SYCL APIs. Requires code updates to fix deprecation warnings and errors.

---

## glu-sycl
- **Args**: batch_size, hidden_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 3 1024 100, minimal: all=1, but hidden_size must be divisible by 2)
- **Compilation**: PASS
- **Execution Time**: N/A (skipped due to dimension requirement)
- **Result**: SKIP
- **Notes**: Not in standard subset. Implements Gated Linear Unit (GLU) activation function using SYCL. The benchmark requires the split dimension (hidden_size) to be divisible by two. With hidden_size=1, the operation is skipped. Minimal test with hidden_size=2 would be needed.

---

## gmm-sycl
- **Args**: num_clusters, data_file, result_file
- **Current**: Not in subset.json
- **Minimal**: N/A (data file required)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (data file not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Gaussian Mixture Model (GMM) clustering using SYCL. The benchmark requires a data file that was not found. Compilation succeeds but execution requires input data file.

---

## goulash-sycl
- **Args**: width, height
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 101 5, minimal: width=1 height=1)
- **Compilation**: PASS
- **Execution Time**: ~0.59s (for 0 iterations with 1x1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Goulash cellular automaton simulation using SYCL. The benchmark performs cellular automaton computations on a grid. Minimal test with width=1, height=1 completes successfully.

---

## gpp-sycl
- **Args**: benchmark_name
- **Current**: Not in subset.json
- **Minimal**: N/A (benchmark file required)
- **Compilation**: PASS
- **Execution Time**: N/A (benchmark file not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Graph Pattern Processing (GPP) using SYCL. The benchmark requires a benchmark file that was not found. Compilation succeeds but execution requires input benchmark file.

---

## graphB+-sycl
- **Args**: graph_file, num_iterations, output_file
- **Current**: Not in subset.json
- **Minimal**: ["../graphB+-cuda/graph.csv", "1", "test.out"] (from make run: ../graphB+-cuda/graph.csv 10000 output, minimal: iterations=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~N/A (for iterations=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Graph B+ tree operations using SYCL. The benchmark reads a graph CSV file and performs graph operations. Minimal test with 1 iteration completes successfully.

---

## graphExecution-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~1.13s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements graph execution patterns using SYCL. The benchmark performs graph computations with stream-based execution. Reports execution time and final reduced sum. Minimal test with no arguments completes successfully.

---

## grep-sycl
- **Args**: (uses runtests.sh script)
- **Current**: Not in subset.json
- **Minimal**: N/A (uses test script)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (not tested, uses runtests.sh)
- **Result**: PASS (compilation)
- **Notes**: Not in standard subset. Implements regular expression matching (grep) using SYCL with NFA (Non-deterministic Finite Automaton). The benchmark uses a runtests.sh script for execution. Compilation succeeds with warnings.

---

## grrt-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: TIMEOUT (takes too long)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements GRRT (likely a graph or routing algorithm) using SYCL. The benchmark times out even with no arguments, suggesting significant computation or initialization overhead.

---

## gru-sycl
- **Args**: batch_size, hidden_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 102400 1024 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~67ms per iteration (for batch=1 hidden=1 repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Gated Recurrent Unit (GRU) neural network cell using SYCL. The benchmark performs GRU forward pass computations. Reports average execution time and checksum. Minimal test with all parameters=1 completes successfully.

---

## haccmk-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~0.007s per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements HACC (Hardware Accelerated Cosmology Code) microkernel using SYCL. The benchmark performs cosmological N-body simulation computations. Reports outer and inner loop counts and average kernel execution time. Minimal test with repeat=1 completes successfully.

---

## halo-finder-sycl
- **Args**: linking_length, smoothing_length, num_particles, smoothing_radius, num_iterations, periodic, num_threads, method
- **Current**: Not in subset.json
- **Minimal**: N/A (complex build system, requires MPI includes)
- **Compilation**: N/A (not tested - complex build system)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements Halo Finder for cosmological simulations using SYCL. Complex build system with multiple libraries and MPI dependencies. Makefile shows run target: `./sycl/ForceTreeTest 0.5 0.1 10000 0.1 10 N 12 rcb`. Not tested due to complex build requirements.

---

## hausdorff-sycl
- **Args**: num_points_A, num_points_B, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 100000 100000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~5.1ms per iteration (for all=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Hausdorff distance computation between two point sets using SYCL. Verifies results against CPU reference implementation. Minimal test with all parameters=1 completes successfully.

---

## haversine-sycl
- **Args**: locations_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../geodesic-cuda/locations.txt", "1"] (from make run: ../geodesic-cuda/locations.txt 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~0.54s per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Haversine distance computation for geographic coordinates using SYCL. Reads city locations from a file and computes distances. Reports maximum error in distance calculation. Minimal test with repeat=1 completes successfully.

---

## hbc-sycl
- **Args**: -i input_file -v [--printscores=output_file]
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation failure - missing boost)
- **Compilation**: FAIL (missing boost/algorithm/string.hpp)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Hierarchical Bayesian Clustering (HBC) using SYCL. Compilation fails due to missing Boost library dependency (boost/algorithm/string.hpp). Requires Boost to be installed and configured.

---

## heartwall-sycl
- **Args**: num_frames
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 104, minimal: num_frames=1)
- **Compilation**: FAIL (fabs undeclared in kernel.sycl)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements heart wall tracking using SYCL. Compilation fails because `fabs` is undeclared in `kernel/kernel.sycl`. Requires adding `#include <math.h>` or `#include <cmath>` to the kernel file.

---

## heat2d-sycl
- **Args**: LX, LY, niter
- **Current**: Not in subset.json
- **Minimal**: ["16", "16", "1"] (from make run: 4096 4096 1000, minimal: LX=16 LY=16 niter=1, must be multiple of block size 16)
- **Compilation**: PASS
- **Execution Time**: ~5.2ms per iteration (for 16x16, niter=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 2D heat equation solver using SYCL. The benchmark requires LX and LY to be multiples of block size (16). Minimal test with 16x16 grid and 1 iteration completes successfully.

---

## heat-sycl
- **Args**: size, niter
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 4096 1000, minimal: size=1 niter=1)
- **Compilation**: PASS
- **Execution Time**: ~0.006s per iteration (for size=1 niter=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 1D heat equation solver using SYCL. Reports error (L2norm), solve time, total time, and bandwidth. Minimal test with size=1, niter=1 completes successfully.

---

## hellinger-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~67.6ms per iteration (for repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Hellinger distance computation using SYCL. The benchmark performs matrix multiplication operations (c(768,3072) = a(768,1536) * b(1536,3072)). Minimal test with repeat=1 completes successfully.

---

## henry-sycl
- **Args**: cssr_file, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (cssr file required)
- **Compilation**: PASS
- **Execution Time**: N/A (cssr file not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Henry's law constant computation for molecular simulations using SYCL. The benchmark requires a CSSR file (crystal structure file) that was not found. Compilation succeeds but execution requires input CSSR file.

---

## hexciton-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.48s (total kernel time)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements hexciton (exciton) computation using SYCL. The benchmark performs quantum mechanical calculations. Reports total execution time and deviation. Minimal test with no arguments completes successfully.

---

## histogram-sycl
- **Args**: --i=iterations
- **Current**: Not in subset.json
- **Minimal**: ["--i=1"] (from make run: --i=100, minimal: iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~0.49ms (smem atomics), ~0.66ms (gmem atomics) for iterations=1
- **Result**: PASS
- **Notes**: Not in standard subset. Implements histogram computation using SYCL with shared memory and global memory atomics. Reports performance metrics (GB/s, % peak). Minimal test with iterations=1 completes successfully.

---

## hmm-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.31s (device execution time)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Hidden Markov Model (HMM) with Viterbi algorithm using SYCL. The benchmark computes Viterbi path on both GPU and CPU. Reports device execution time. Minimal test with no arguments completes successfully.

---

## hogbom-sycl
- **Args**: dirty_image, psf_image, num_iterations
- **Current**: Not in subset.json
- **Minimal**: N/A (image files required)
- **Compilation**: PASS
- **Execution Time**: N/A (image files not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Hogbom CLEAN algorithm for radio astronomy image deconvolution using SYCL. The benchmark requires dirty image and PSF (Point Spread Function) image files that were not found. Compilation succeeds but execution requires input image files.

---

## hotspot3D-sycl
- **Args**: grid_cols, grid_rows, layers, iterations, power_file, temp_file, output_file
- **Current**: Not in subset.json
- **Minimal**: N/A (data files required)
- **Compilation**: PASS
- **Execution Time**: N/A (data files not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements 3D hotspot thermal simulation using SYCL. The benchmark requires power and temperature data files that were not found. Compilation succeeds but execution requires input data files.

---

## hotspot-sycl
- **Args**: grid_cols, grid_rows, iterations, temp_file, power_file, output_file
- **Current**: Not in subset.json
- **Minimal**: N/A (data files required)
- **Compilation**: PASS
- **Execution Time**: N/A (data files not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements 2D hotspot thermal simulation using SYCL. The benchmark requires temperature and power data files that were not found. Compilation succeeds but execution requires input data files.

---

## hpl-sycl
- **Args**: N/A (complex HPL benchmark)
- **Current**: Not in subset.json
- **Minimal**: N/A (complex build system)
- **Compilation**: N/A (not tested - complex HPL build system)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements High Performance Linpack (HPL) benchmark using SYCL. Complex build system with multiple Makefiles. Not tested due to complexity.

---

## hungarian-sycl
- **Args**: output_file
- **Current**: Not in subset.json
- **Minimal**: ["test.out"] (from make run: output.txt, minimal: any output file)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (runtime device error)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Hungarian algorithm for assignment problem using SYCL. Runtime failure with device error (UR_RESULT_ERROR_DEVICE_LOST). This may be a device-specific issue.

---

## hwt1d-sycl
- **Args**: size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 8388608 100, minimal: size=1 repeat=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~1.1μs per iteration (for size=1 repeat=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 1D Haar Wavelet Transform (HWT) using SYCL. Verifies results against CPU reference implementation. Minimal test with size=1, repeat=1 completes successfully.

---

## hybridsort-sycl
- **Args**: mode (r for random, s for sorted, rs for reverse sorted)
- **Current**: Not in standard subset
- **Minimal**: ["r"] (from make run: r, minimal: random mode)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~259ms (GPU), ~2495ms (CPU) for random data
- **Result**: PASS
- **Notes**: Not in standard subset. Implements hybrid sort (bucketsort + mergesort) using SYCL. Reports GPU and CPU execution times separately. Verifies results against CPU reference. Minimal test with random mode completes successfully.

---

## hypterm-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A (reports checksum and RMS error)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements hyperbolic term computation using SYCL. The benchmark performs flux computations and reports checksums and RMS errors. Minimal test with repeat=1 completes successfully.

---

## idivide-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: TIMEOUT (takes too long even with repeat=1)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements integer division optimization using SYCL. The benchmark performs functional tests on many divisors and dividends. Times out even with minimal repeat=1, suggesting significant computation time.

---

## interleave-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~156ms (non-interleaved), ~21ms (interleaved) per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements memory access pattern interleaving using SYCL. Compares performance between non-interleaved and interleaved memory access patterns. Minimal test with repeat=1 completes successfully.

---

## interval-sycl
- **Args**: test_type, num_intervals
- **Current**: Not in subset.json
- **Minimal**: ["0", "1"] (from make run: 0 100000 and 1 100000, minimal: test_type=0 num_intervals=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~264ms per test (for num_intervals=1)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements interval arithmetic using SYCL. The benchmark performs interval Newton method tests. Verifies results against host computation. Minimal test with test_type=0, num_intervals=1 completes successfully.

---

## intrinsics-cast-sycl
- **Args**: size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000000 100, minimal: size=1 repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~211ms (from FP), ~3.7ms (to FP) per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements type casting intrinsics using SYCL. The benchmark tests casting from floating-point and to floating-point types. Reports checksums. Minimal test with size=1, repeat=1 completes successfully.

---

## inversek2j-sycl
- **Args**: coord_file, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["coord_in.txt", "1"] (from make run: coord_in.txt 100000, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: N/A (coord file exists, not tested)
- **Result**: PASS (compilation)
- **Notes**: Not in standard subset. Implements inverse kinematics (2-joint) computation using SYCL. The benchmark requires a coordinate input file. Compilation succeeds and coord_in.txt file exists.

---

## ising-sycl
- **Args**: -x width -y height -w warmup -n iterations
- **Current**: Not in subset.json
- **Minimal**: ["-x", "2", "-y", "2", "-w", "1", "-n", "1"] (from make run: -x 5120 -y 5120 -w 10 -n 1000, minimal: width=2 height=2 warmup=1 iterations=1, dimensions must be even)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (dimension requirement)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Ising model simulation using SYCL. The benchmark requires lattice dimensions to be even values. With width=1, height=1, the operation fails. Minimal test with width=2, height=2 would be needed.

---

## iso2dfd-sycl
- **Args**: n1, n2, iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 2048 2048 1000, minimal: n1=1 n2=1 iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~0.1ms per iteration (for 1x1 grid)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 2D isotropic finite difference wave propagation using SYCL. Verifies results against CPU reference. Minimal test with 1x1 grid completes successfully.

---

## is-sycl
- **Args**: nx, ny, nz
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation errors)
- **Compilation**: FAIL (9 errors, 3 warnings - SYCL kernel compilation issues)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Image Segmentation using SYCL. Compilation fails with multiple SYCL kernel errors. Error: "called by 'kernel_parallel_for<rank7, sycl::nd_item<>, (lambda at main.cpp:312:52)>'". Requires code fixes.

---

## jaccard-sycl
- **Args**: num_sets, set_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1024 512 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (segfault with minimal args)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Jaccard similarity computation between sets using SYCL. Compiles successfully but segfaults with minimal arguments. May require minimum set size.

---

## jacobi-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS
- **Execution Time**: ~5.3s total
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Jacobi iterative method for solving linear systems using SYCL. No command-line arguments required. Completes successfully with default input.

---

## jenkins-hash-sycl
- **Args**: num_strings, string_length, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 256 16777216 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.2ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Jenkins hash function computation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## kalman-sycl
- **Args**: num_frames, num_objects, num_features, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 1000 100 3 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (runtime error)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Kalman filter for object tracking using SYCL. Compiles successfully but fails at runtime with kernel name error: "UR_RESULT_ERROR_INVALID_KERNEL_NAME". Requires kernel name fixes.

---

## keccaktreehash-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS
- **Execution Time**: ~0.25s total
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Keccak tree hash computation using SYCL. No command-line arguments required. Completes successfully with default input.

---

## keogh-sycl
- **Args**: query_length, subject_length, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 256 20000000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~56ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Keogh lower bound computation for time series using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## kernelLaunch-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000000, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~92us (small args), ~19us (medium args), ~43us (large args)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements kernel launch overhead measurement using SYCL. Tests different kernel argument sizes. Minimal test completes successfully.

---

## kiss-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: N/A (outputs random numbers)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements KISS (Keep It Simple, Stupid) random number generator using SYCL. Outputs random numbers. Minimal test completes successfully.

---

## kmc-sycl
- **Args**: -v num_vectors, data_file
- **Current**: Not in subset.json
- **Minimal**: N/A (data file not found)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements K-means clustering using SYCL with oneMKL. Requires data file (gisette_scale). Error: "no matches found: ../kmc-cuda/*.scale". Data file not found.

---

## kmeans-sycl
- **Args**: -r -n num_clusters -m max_iterations -l min_change -o -i data_file
- **Current**: Not in subset.json
- **Minimal**: N/A (data file not found)
- **Compilation**: PASS (with warnings about treating .c as .c++)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements K-means clustering using SYCL. Requires data file (kdd_cup). Error: "no matches found: ../data/kmeans/*". Data file not found.

---

## knn-sycl
- **Args**: num_points
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_points=1)
- **Compilation**: PASS
- **Execution Time**: ~21ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements K-nearest neighbors computation using SYCL. Verifies precision and index accuracy. Minimal test completes successfully.

---

## kurtosis-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (missing oneapi/dpl/algorithm)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/algorithm' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements kurtosis computation using SYCL with oneDPL. Compilation fails due to missing oneDPL headers. Requires oneDPL installation.

---

## lanczos-sycl
- **Args**: -g graph_file -n num_nodes -k num_eigenvalues -d data_type
- **Current**: Not in subset.json
- **Minimal**: N/A (data file not found)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Lanczos algorithm for eigenvalue computation using SYCL. Requires graph file (data/social-large-800k.txt). Error: "no matches found: data/*.txt". Data file not found.

---

## langevin-sycl
- **Args**: num_particles, num_steps
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 268435456 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (runtime error)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Langevin dynamics simulation using SYCL. Compiles successfully but fails at runtime: "Non-uniform work-groups are not supported by the target device". Requires work-group size fixes.

---

## langford-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS
- **Execution Time**: N/A (runtime error)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Langford sequence generation using SYCL. Compiles successfully but fails at runtime: "UR_RESULT_ERROR_DEVICE_LOST". Device error during execution.

---

## laplace3d-sycl
- **Args**: nx, ny, nz, iterations, output
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 128 128 128 100 1, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (exit code 1, no output)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements 3D Laplace equation solver using SYCL. Compiles successfully but exits with code 1 and no output. May require minimum grid size.

---

## laplace-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: N/A (missing oneapi/dpl/execution)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements 2D Laplace equation solver using SYCL with oneDPL. Compilation fails due to missing oneDPL headers. Requires oneDPL installation.

---

## lavaMD-sycl
- **Args**: -boxes1d num_boxes
- **Current**: Not in subset.json
- **Minimal**: ["-boxes1d", "1"] (from make run: -boxes1d 30, minimal: num_boxes=1)
- **Compilation**: PASS
- **Execution Time**: ~0.12s device offload, ~2.9ms kernel execution
- **Result**: PASS
- **Notes**: Not in standard subset. Implements molecular dynamics simulation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## layernorm-sycl
- **Args**: test_case
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1 or 2, minimal: test_case=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.78ms per block size
- **Result**: PASS
- **Notes**: Not in standard subset. Implements layer normalization using SYCL. Tests different block sizes. Minimal test completes successfully.

---

## layout-sycl
- **Args**: num_elements
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: num_elements=1)
- **Compilation**: PASS
- **Execution Time**: ~3.3ms (AoS), ~0.67ms (SoA)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements layout comparison (Array of Structures vs Structure of Arrays) using SYCL. Tests both AoS and SoA layouts. Minimal test completes successfully.

---

## lci-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements LCI (likely a computational kernel) using SYCL. Compiles successfully but times out during execution. May require very long runtime or has infinite loop.

---

## lda-sycl
- **Args**: num_topics
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_topics=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~261ms (training), ~0.8ms (validation)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Latent Dirichlet Allocation using SYCL. Computes training and validation loss. Minimal test completes successfully.

---

## ldpc-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements Low-Density Parity-Check code decoder using SYCL. Compiles successfully but times out during execution. May require very long runtime or has infinite loop.

---

## lebesgue-sycl
- **Args**: num_points, test_case
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000000 2, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~29ms total
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Lebesgue constant computation using SYCL. Tests Fejer2 points. Minimal test completes successfully.

---

## leukocyte-sycl
- **Args**: video_file, num_frames
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation errors)
- **Compilation**: FAIL (7 errors - undeclared identifier 'gicov_acc')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements leukocyte detection in video using SYCL. Compilation fails with multiple errors. Error: "use of undeclared identifier 'gicov_acc'". Requires code fixes. Also requires AVI video file.

---

## lfib4-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 2000000000, minimal: num_iterations=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements LFIB4 random number generator using SYCL. Compiles successfully but times out during execution. May require very long runtime.

---

## libor-sycl
- **Args**: num_paths
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_paths=1)
- **Compilation**: PASS
- **Execution Time**: ~18ms (first kernel), ~268ms (second kernel)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements LIBOR (London Interbank Offered Rate) Monte Carlo simulation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## lid-driven-cavity-sycl
- **Args**: (none - uses default input)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: ./main, no args)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements lid-driven cavity flow simulation using SYCL. Compiles successfully but times out during execution. May require very long runtime or has infinite loop.

---

## lif-sycl
- **Args**: num_neurons, num_steps, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1000 1000 400, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.4ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Leaky Integrate-and-Fire neuron model using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## linearprobing-sycl
- **Args**: num_keys, num_queries
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 16 8, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements linear probing hash table using SYCL. Compiles successfully but times out during execution. May require very long runtime.

---

## log2-sycl
- **Args**: config_file
- **Current**: Not in subset.json
- **Minimal**: ["../log2-cuda/log2_parameters.config"] (from make run: ../log2-cuda/log2_parameters.config)
- **Compilation**: PASS
- **Execution Time**: N/A (outputs RMSE values)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements log2 approximation using SYCL. Outputs RMSE values for different precision levels. Minimal test completes successfully.

---

## logan-sycl
- **Args**: input_file, num_seeds, num_iterations, num_threads
- **Current**: Not in subset.json
- **Minimal**: ["../logan-cuda/inputs/example.txt", "1", "1", "1"] (from make run: ../logan-cuda/inputs/100k.txt 17 100 1, minimal: all=1)
- **Compilation**: PASS (with warnings and OpenMP path issues)
- **Execution Time**: ~0.39s total
- **Result**: PASS
- **Notes**: Not in standard subset. Implements LOGAN (Local Graph Alignment) using SYCL with OpenMP. Requires input file. Minimal test completes successfully.

---

## logic-resim-sycl
- **Args**: intermediate_file, vcd_file, start_time, end_time, output_file
- **Current**: Not in subset.json
- **Minimal**: N/A (complex input files required)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements logic resimulation using SYCL. Requires intermediate.file and VCD file. Complex input format. Not tested with minimal args due to file requirements.

---

## logprob-sycl
- **Args**: batch_size, num_heads, vocab_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 1024 8 50257 100, minimal: all=1)
- **Compilation**: PASS (with OpenMP warnings)
- **Execution Time**: ~139us per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements log probability computation using SYCL with group reduce. Verifies results against CPU reference. Minimal test completes successfully.

---

## lombscargle-sycl
- **Args**: num_points
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_points=1)
- **Compilation**: PASS
- **Execution Time**: ~4.1ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Lomb-Scargle periodogram computation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## loopback-sycl
- **Args**: mode, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["0", "1"] (from make run: 0 100, minimal: mode=0 num_iterations=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~226ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements loopback test for memory operations using SYCL. Tests different memory access patterns. Minimal test completes successfully.

---

## lrn-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements Local Response Normalization using SYCL. Compiles successfully but times out during execution. May require very long runtime.

---

## lr-sycl
- **Args**: num_samples, mode
- **Current**: Not in subset.json
- **Minimal**: ["1", "0"] (from make run: 100000 0, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (outputs equation)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Linear Regression using SYCL. Outputs regression equation. Minimal test completes successfully.

---

## lsqt-sycl
- **Args**: input_file
- **Current**: Not in subset.json
- **Minimal**: N/A (input file requires para.in)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements LSQT (likely quantum transport) simulation using SYCL. Requires input file with para.in. Error: "cannot open ../lsqt-cuda/examples/fan2018cpc/lattice/diffusive/para.in". Input file structure not found.

---

## ludb-sycl
- **Args**: matrix_size
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: matrix_size=1)
- **Compilation**: PASS
- **Execution Time**: ~29ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements LU decomposition with oneMKL using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## lud-sycl
- **Args**: -s matrix_size
- **Current**: Not in subset.json
- **Minimal**: N/A (minimum size requirement)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements LU decomposition using SYCL. Requires minimum matrix size. Error: "Matrix dimension of 1 not supported by the benchmark" and "Matrix dimension of 2 not supported by the benchmark". Minimum size requirement not met.

---

## lulesh-sycl
- **Args**: -i iterations -s size -r refinement -b balance -c cost
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation errors)
- **Compilation**: FAIL (3 errors, 25 warnings - unused variable and other issues)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements LULESH (Livermore Unstructured Lagrangian Explicit Shock Hydrodynamics) using SYCL. Compilation fails with multiple errors. Requires code fixes.

---

## lut-gemm-sycl
- **Args**: test_case, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements Look-Up Table GEMM using SYCL with oneMKL. Compiles successfully but times out during execution. May require very long runtime.

---

## lzss-sycl
- **Args**: -i input_file
- **Current**: Not in subset.json
- **Minimal**: N/A (missing oneDPL)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements LZSS (Lempel-Ziv-Storer-Szymanski) compression using SYCL with oneDPL. Compilation fails due to missing oneDPL headers. Requires oneDPL installation.

---

## mallocFree-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 536870912, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~21us (malloc_host), ~0.4us (free)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements malloc/free performance test using SYCL. Tests host memory allocation and deallocation. Minimal test completes successfully.

---

## mandelbrot-sycl
- **Args**: image_size
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: image_size=1)
- **Compilation**: PASS
- **Execution Time**: ~0.26s (serial), ~4.3ms (parallel), ~0.29ms (kernel)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Mandelbrot set computation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## marchingCubes-sycl
- **Args**: grid_size
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: grid_size=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~120ms per iteration
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Marching Cubes algorithm using SYCL. Generates triangles but verification fails. Error: "FAIL" in output. May require minimum grid size or has correctness issues.

---

## mask-sycl
- **Args**: width, height, depth, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 512 512 512 100, minimal: all=1)
- **Compilation**: PASS (with OpenMP warnings)
- **Execution Time**: N/A (segfault with minimal args)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements mask operation using SYCL with OpenMP. Compiles successfully but segfaults with minimal arguments. May require minimum dimensions.

---

## match-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_iterations=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~17ms (MatchGPU9), ~18ms (MatchGPU10)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements pattern matching using SYCL. Verifies results (0 incorrect matches). Minimal test completes successfully.

---

## matern-sycl
- **Args**: num_points, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 300 100, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (segfault with minimal args)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Matern covariance function computation using SYCL. Compiles successfully but segfaults with minimal arguments. May require minimum number of points.

---

## matrix-rotate-sycl
- **Args**: num_iterations, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 5000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~2.8ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements matrix rotation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## matrixT-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation error - fabsf undeclared)
- **Compilation**: FAIL (error: use of undeclared identifier 'fabsf')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements matrix transpose using SYCL. Compilation fails due to missing fabsf declaration. Requires include <cmath> or similar fix.

---

## maxFlops-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 5000, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~55ms (MAdd8), ~49ms (MulMAdd1-2), ~55ms (MulMAdd4-8)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements maximum FLOPS measurement using SYCL. Tests different kernel types. Minimal test completes successfully.

---

## maxpool3d-sycl
- **Args**: width, height, depth, count, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 16384 16384 200, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (usage message, exit code 1)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements 3D max pooling using SYCL. Compiles successfully but shows usage message and exits. May require minimum dimensions.

---

## mcmd-sycl
- **Args**: (runs from dataset directory with mcmd.inp)
- **Current**: Not in subset.json
- **Minimal**: N/A (requires dataset directory)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements MCMD (Monte Carlo Molecular Dynamics) using SYCL. Requires dataset directory with mcmd.inp file. Complex input format. Not tested with minimal args.

---

## mcpr-sycl
- **Args**: csv_file, num_iterations
- **Current**: Not in subset.json
- **Minimal**: N/A (csv file not found)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MCPR (likely Monte Carlo) using SYCL. Requires CSV file (alphas.csv). Error: "no matches found: ../mcpr-cuda/*.csv". Data file not found.

---

## md5hash-sycl
- **Args**: num_keys, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1 4, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (outputs hash results)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MD5 hash computation using SYCL. Outputs found index, key, and digest. Minimal test completes successfully.

---

## mdh-sycl
- **Args**: -itmax num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["-itmax", "1"] (from make run: -itmax 100, minimal: num_iterations=1)
- **Compilation**: PASS (with OpenMP warnings and path issues)
- **Execution Time**: ~8ms (kernel), ~14ms (GPU time)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MDH (likely molecular dynamics) using SYCL with OpenMP. Verifies results against CPU reference. Minimal test completes successfully.

---

## md-sycl
- **Args**: num_particles, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 3 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.58ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Molecular Dynamics simulation using SYCL. Verifies results against CPU reference (max error: 5.72e-06). Minimal test completes successfully.

---

## meanshift-sycl
- **Args**: data_file, centroids_file
- **Current**: Not in subset.json
- **Minimal**: N/A (csv files found but not tested)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements Mean Shift clustering using SYCL. Requires data.csv and centroids.csv files. Files found but not tested with minimal args.

---

## medianfilter-sycl
- **Args**: image_file, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (ppm file found but not tested)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements median filter using SYCL. Requires PPM image file. File found (SierrasRGB.ppm) but not tested with minimal args.

---

## memcpy-sycl
- **Args**: buffer_size
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 8192, minimal: buffer_size=1)
- **Compilation**: PASS
- **Execution Time**: ~200us (host to device), ~507us (device to host)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements memory copy performance test using SYCL. Tests host-to-device and device-to-host transfers. Minimal test completes successfully.
---

## memtest-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_iterations=1)
- **Compilation**: FAIL (10 errors - nd_item template issues)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements memory test using SYCL. Compilation fails with multiple template errors related to nd_item. Requires code fixes.

---

## merge-sycl
- **Args**: array_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000 100, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~4ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements merge operation using SYCL. Verifies results (0 errors). Minimal test completes successfully.

---

## merkle-sycl
- **Args**: (no arguments)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements Merkle tree computation using SYCL. Compiles successfully but times out during execution. May require very long runtime.

---

## metropolis-sycl
- **Args**: -l lattice_x lattice_y -t temp_start temp_step -a alpha_start alpha_step alpha_max alpha_step -h h_field -z seed
- **Current**: Not in subset.json
- **Minimal**: N/A (minimum size requirement)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Metropolis algorithm using SYCL. Requires minimum lattice size. Error: "lattice dimensional size must be multiples of 32". Minimum size requirement not met.

---

## michalewicz-sycl
- **Args**: num_particles, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~70us per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Michalewicz function optimization using SYCL. Outputs global minima and error values. Minimal test completes successfully.

---

## minibude-sycl
- **Args**: --deck data_file --wgsize workgroup_size --iterations num_iterations
- **Current**: Not in subset.json
- **Minimal**: N/A (data file found but not tested)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements miniBUDE (mini Bio-molecular Unfolding and Docking Engine) using SYCL. Requires data file (bm1). File found but not tested with minimal args.

---

## minimap2-sycl
- **Args**: input_file, output_file
- **Current**: Not in subset.json
- **Minimal**: N/A (compilation error)
- **Compilation**: FAIL (fatal error: 'datatypes.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements minimap2 alignment using SYCL. Compilation fails due to missing header file. Requires include path fix.

---

## minimod-sycl
- **Args**: --warm-up --niters num_iterations --grid grid_size --nsteps num_steps
- **Current**: Not in subset.json
- **Minimal**: ["--warm-up", "--niters", "1", "--grid", "1", "--nsteps", "1"] (from make run: --warm-up --niters 1 --grid 256 --nsteps 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (malloc corruption)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements minimod simulation using SYCL. Compiles successfully but crashes with malloc corruption. Error: "malloc(): corrupted top size". May require minimum grid size.

---

## minisweep-sycl
- **Args**: --niterations num_iterations (or --niterations num_iterations --ncell_x x --ncell_y y --ncell_z z --ne ne --na na --nblock_z z)
- **Current**: Not in subset.json
- **Minimal**: ["--niterations", "1"] (from make run: --niterations 100, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~363ms (host), ~363ms (kernel)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements miniSweep (neutron transport) using SYCL. Verification fails. Error: "verify: FAIL" in output. May have correctness issues.

---

## miniWeather-sycl
- **Args**: (runs with mpiexec)
- **Current**: Not in subset.json
- **Minimal**: N/A (timeout)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (timeout after 30s)
- **Result**: TIMEOUT
- **Notes**: Not in standard subset. Implements miniWeather simulation using SYCL with MPI. Compiles successfully but times out during execution. May require very long runtime.

---

## minkowski-sycl
- **Args**: num_points
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_points=1)
- **Compilation**: PASS
- **Execution Time**: ~3.5ms (p=2), ~4.7ms (p=4)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Minkowski distance computation using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## minmax-sycl
- **Args**: array_size, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (missing oneDPL)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements min/max operation using SYCL with oneDPL. Compilation fails due to missing oneDPL headers. Requires oneDPL installation.

---

## mis-sycl
- **Args**: graph_file, num_iterations
- **Current**: Not in subset.json
- **Minimal**: N/A (egr file not found)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Maximum Independent Set using SYCL. Requires graph file (.egr). Error: "no matches found: ../mis-cuda/*.egr". Data file not found.

---

## mixbench-sycl
- **Args**: buffer_size
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 8192, minimal: buffer_size=1)
- **Compilation**: PASS
- **Execution Time**: ~107us per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements mixbench (mixed precision benchmark) using SYCL. Tests compute with global memory. Minimal test completes successfully.

---

## mmcsf-sycl
- **Args**: -i input_file -m mode -R rank -f factor_size -w num_workers
- **Current**: Not in subset.json
- **Minimal**: N/A (missing Boost)
- **Compilation**: FAIL (fatal error: 'boost/sort/sort.hpp' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MMCSF (Multi-Mode Canonical Polyadic Decomposition) using SYCL with Boost. Compilation fails due to missing Boost headers. Requires Boost installation.

---

## mnist-sycl
- **Args**: num_epochs
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 2, minimal: num_epochs=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (input files not found)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MNIST neural network training using SYCL. Requires input images and labels. Error: "Error: input images or labels not found." Data files not found.

---

## moe-sycl
- **Args**: batch_size, hidden_size, num_experts, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 32768 384 1-8 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~94us per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Mixture of Experts using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## morphology-sycl
- **Args**: width, height, depth, width2, height2, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1"] (from make run: 32 32 8192 8192 100, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~3.6ms (dilate), ~95us (erode)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements morphological operations (dilate, erode) using SYCL. Verification fails. Error: "FAIL" in output. May require minimum dimensions.

---

## mpc-sycl
- **Args**: trace_file, mode
- **Current**: Not in subset.json
- **Minimal**: N/A (trace file not found)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MPC (Message Passing Compression) using SYCL. Requires trace file (.trace.out). Error: "no matches found: ../mpc-cuda/*.trace.out". Data file not found.

---

## mrc-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~213us (MRC), ~2.6ms (MRC2)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MRC (likely Monte Carlo) using SYCL. Verifies results against CPU reference. Minimal test completes successfully.
---

## mrg32k3a-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000000 10, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (unsupported device)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MRG32k3a random number generator using SYCL with oneMKL. Compiles successfully but fails at runtime. Error: "oneapi::mkl::rng::mrg32k3a: unsupported device: 13th Gen Intel(R) Core(TM) i9-13900K". Requires GPU device.

---

## mriQ-sycl
- **Args**: input_file, output_file
- **Current**: Not in subset.json
- **Minimal**: N/A (bin file not found)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MRI-Q (MRI reconstruction) using SYCL. Requires input file (.bin). Error: "no matches found: ../mriQ-cuda/datasets/*/input/*.bin". Data file not found.

---

## mr-sycl
- **Args**: num_bases
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_bases=1)
- **Compilation**: PASS
- **Execution Time**: N/A (outputs timing table)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MR (likely Multiple Regression) using SYCL. Outputs timing table for different base counts. Minimal test completes successfully.

---

## mtf-sycl
- **Args**: array_size, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (missing oneDPL)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MTF (Move-To-Front) using SYCL with oneDPL. Compilation fails due to missing oneDPL headers. Requires oneDPL installation.

---

## mt-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: num_iterations=1)
- **Compilation**: FAIL (error: no member named 'fabs' in namespace 'std')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MT (likely Mersenne Twister) using SYCL. Compilation fails due to missing std::fabs. Requires <cmath> include fix.
---

## multimaterial-sycl
- **Args**: width, height (or width, height, alpha, beta, gamma)
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 2000 2000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (missing volfrac.dat)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements multi-material simulation using SYCL. Error: "unable to read volume fractions from file \"volfrac.dat\"". Requires data file.

---

## multinomial-sycl
- **Args**: num_samples, num_categories, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 65536 2048 100, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~201us per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements multinomial sampling using SYCL. Verifies results against CPU reference. Minimal test completes successfully.

---

## murmurhash3-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.7ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MurmurHash3 using SYCL. Verifies hash correctness. Minimal test completes successfully.

---

## mxfp4-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: N/A (minimum size requirement)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements MXFP4 (Mixed Precision Floating Point 4-bit) using SYCL. Error: "Expected qdq_mxfp4 input number of elements to be a multiple of 64, but it is not!". Requires minimum size of 64 elements.

---

## myocyte-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_iterations=1)
- **Compilation**: FAIL (20 errors - template issues)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements myocyte (cardiac cell) simulation using SYCL. Compilation fails with multiple template errors. Requires code fixes.

---

## nbnxm-sycl
- **Args**: num_particles
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000, minimal: num_particles=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~218us (w/o shift), ~2062us (w/ shift)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NBNXM (Non-Bonded Neighbor eXchange Method) using SYCL. Minimal test completes successfully.

---

## nbody-sycl
- **Args**: num_particles, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 16000 10, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~2.8ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements N-body simulation using SYCL. Verifies results. Minimal test completes successfully.

---

## ne-sycl
- **Args**: width, height, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8192 8192 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.2ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NE (likely numerical evolution) using SYCL. Minimal test completes successfully.

---

## nlll-sycl
- **Args**: batch_size, seq_length, hidden_size
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 2048 1000 1000, minimal: all=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~1.8ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NLLL (Negative Log-Likelihood Loss) using SYCL. Minimal test completes successfully.

---

## nms-sycl
- **Args**: input_file, output_file, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["../nms-cuda/detections.txt", "output.txt", "1"] (from make run: ../nms-cuda/detections.txt output.txt 1000, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~119ms (generate_nms_bitmap), ~0.26ms (reduce_nms_bitmap)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NMS (Non-Maximum Suppression) using SYCL. Requires input file. Minimal test completes successfully.

---

## nn-sycl
- **Args**: filelist.txt, -r radius, -lat latitude, -lng longitude, -i num_iterations, -t
- **Current**: Not in subset.json
- **Minimal**: ["filelist.txt", "-r", "1", "-lat", "30", "-lng", "90", "-i", "1", "-t"] (from make run: filelist.txt -r 5 -lat 30 -lng 90 -i 10000 -t, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements nearest neighbor search using SYCL. Error: "error opening a db". Requires filelist.txt input file.

---

## nonzero-sycl
- **Args**: width, height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 2048 2048 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements nonzero operation using SYCL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## norm2-sycl
- **Args**: num_elements
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_elements=1)
- **Compilation**: PASS
- **Execution Time**: ~17ms (256M elements), ~34ms (512M elements)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements L2 norm using SYCL with oneMKL. Verification fails: "FAIL at iteration 0: gold=... actual=...". Results do not match reference.

---

## nosync-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 268435456 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/numeric' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements nosync operation using SYCL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## nqueen-sycl
- **Args**: board_size, num_solutions, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 15 7 100, minimal: all=1)
- **Compilation**: FAIL (error with sycl::ceil)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements N-queens problem using SYCL. Compilation fails with sycl::ceil error. Requires code fix.

---

## ntt-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100000, minimal: repeat=1)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~2.8ms per iteration
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NTT (Number Theoretic Transform) using SYCL. Minimal test completes successfully.

---

## nw-sycl
- **Args**: dimension, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["16", "1"] (from make run: 16384 10, minimal: dimension=16, num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~0.26ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements NW (Needleman-Wunsch) algorithm using SYCL. Requires dimension to be a multiple of 16. Minimal test completes successfully.

---

## openmp-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_iterations=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~48ms (16 threads), ~115ms (32 threads)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements OpenMP interoperability with SYCL. Minimal test completes successfully.

---

## opticalFlow-sycl
- **Args**: input_file1, input_file2
- **Current**: Not in subset.json
- **Minimal**: ["../opticalFlow-cuda/data/frame10.ppm", "../opticalFlow-cuda/data/frame11.ppm"] (from make run: same, minimal: same)
- **Compilation**: PASS (with deprecation warnings)
- **Execution Time**: ~839ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements optical flow computation using SYCL. Requires input PPM files. Minimal test completes successfully.

---

## overlap-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: ~12GB/s (serialized), ~14GB/s (overlapped)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements overlap computation using SYCL. Minimal test completes successfully.

---

## overlay-sycl
- **Args**: width, height
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 640 480, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements overlay operation using SYCL. Minimal test completes successfully.

---

## p2p-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: num_iterations=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements peer-to-peer communication using SYCL. Error: "Two or more GPUs with Peer-to-Peer access capability are required". Requires multi-GPU setup with P2P capabilities.

---

## p4-sycl
- **Args**: num_elements
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000, minimal: num_elements=1)
- **Compilation**: PASS
- **Execution Time**: ~2.9ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements P4 (likely a post-processing kernel) using SYCL. Minimal test completes successfully.

---

## pad-sycl
- **Args**: alpha
- **Current**: Not in subset.json
- **Minimal**: ["0.1"] (from make run: -a 0.1, minimal: alpha=0.1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~3.7s (1005 iterations)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements padding operation using SYCL. Minimal test completes successfully.

---

## page-rank-sycl
- **Args**: -n num_nodes, -i num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["-n", "1", "-i", "1"] (from make run: -n 20000 -i 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements PageRank algorithm using SYCL. Timed out during execution.

---

## particle-diffusion-sycl
- **Args**: num_particles, num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 2000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.2ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements particle diffusion simulation using SYCL. Minimal test completes successfully.

---

## particlefilter-sycl
- **Args**: -x width, -y height, -z depth, -np num_particles
- **Current**: Not in subset.json
- **Minimal**: ["-x", "1", "-y", "1", "-z", "1", "-np", "1"] (from make run: -x 128 -y 128 -z 10 -np 400000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~113ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements particle filter using SYCL. Minimal test completes successfully.

---

## particles-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000, minimal: num_iterations=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~6.6ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements particle simulation using SYCL. Minimal test completes successfully.

---

## pathfinder-sycl
- **Args**: cols, rows, pyramid_height
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 100000 1000 5, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.12s (device offloading)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements pathfinder algorithm using SYCL. Minimal test completes successfully.

---

## pcc-sycl
- **Args**: num_voxels, time_series_length
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 90112 165, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements PCC (Pearson Correlation Coefficient) using SYCL with oneMKL. Minimal test completes successfully.

---

## perlin-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Perlin noise generation using SYCL. Runtime error: "SYCL error at main.cpp:25" - memory allocation failure. Window size (61440 x 34560) may be too large for available memory.

---

## permutate-sycl
- **Args**: input_file
- **Current**: Not in subset.json
- **Minimal**: ["../permutate-cuda/test_data/truerand_1bit.bin"] (from make run: same, minimal: same)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements permutation testing using SYCL. Error: "File open fails. Please re-enter a file path". Requires input file that doesn't exist in the repository.

---

## permute-sycl
- **Args**: batch_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 8 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.1ms (best block size)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements permute operation using SYCL. Tests different block sizes. Minimal test completes successfully.

---

## perplexity-sycl
- **Args**: num_points, perplexity, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 10000 50 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.4ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements perplexity computation using SYCL. Minimal test completes successfully.

---

## phmm-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~54ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements PHMM (Pair Hidden Markov Model) using SYCL. Minimal test completes successfully.

---

## pingpong-sycl
- **Args**: (none, requires MPI)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: FAIL (fatal error: 'mpi.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements pingpong communication using SYCL with MPI. Compilation fails due to missing MPI headers. Requires MPI installation.

---

## pitch-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~3-5ms per test
- **Result**: PASS
- **Notes**: Not in standard subset. Implements pitched memory operations using SYCL. Tests different memory layouts. Minimal test completes successfully.

---

## pnpoly-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~27-81ms (depending on block size)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements point-in-polygon test using SYCL. Tests different block sizes. Minimal test completes successfully.

---

## pns-sycl
- **Args**: N, S, T
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 22 100000 1000000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.13s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements PNS (Petri Net Simulation) using SYCL. Minimal test completes successfully.

---

## pointwise-sycl
- **Args**: seqLength, numLayers, hiddenSize, miniBatch, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 100 8 512 64 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.06ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements pointwise operations using SYCL. Minimal test completes successfully.

---

## pool-sycl
- **Args**: batch, input_channels, input_height, input_width, output_height, output_width, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1", "1"] (from make run: 128 48 224 224 54 54 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~2.9ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements pooling operation using SYCL. Minimal test completes successfully.

---

## popcount-sycl
- **Args**: length, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 16777216 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.05-0.19ms per kernel
- **Result**: PASS
- **Notes**: Not in standard subset. Implements population count (bit counting) using SYCL. Tests different algorithms. Minimal test completes successfully.

---

## prefetch-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~36ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements prefetch operations using SYCL. Tests concurrent managed access with and without prefetch. Minimal test completes successfully.

---

## present-sycl
- **Args**: num_plain_texts, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.29ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements PRESENT cipher using SYCL. Minimal test completes successfully.

---

## prna-sycl
- **Args**: input_file
- **Current**: Not in subset.json
- **Minimal**: ["../prna-cuda/test.seq"] (from make run: ../prna-cuda/HIV1-NL43.seq, minimal: test.seq)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements PRNA (RNA secondary structure prediction) using SYCL. Error: "safe_fopen: could not open file '../prna-cuda/test.seq'". Requires input file that doesn't exist.

---

## projectile-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~20.6ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements projectile motion simulation using SYCL. Minimal test completes successfully.

---

## pso-sycl
- **Args**: num_particles, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 30 10000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements PSO (Particle Swarm Optimization) using SYCL. Minimal test completes successfully.

---

## qem-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~426ms (GPU), ~61.6ms (GPU streams)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements QEM (Quadric Error Metrics) using SYCL. Tests both GPU and GPU streams implementations. Minimal test completes successfully.

---

## qkv-sycl
- **Args**: kernel_num (optional)
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1-4, minimal: kernel_num=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dnnl/dnnl.hpp' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements QKV (Query-Key-Value) attention using SYCL with oneDNN. Compilation fails due to missing oneDNN installation or incorrect include paths.

---

## qrg-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements QRG (Quasi-Random Generator) using SYCL. Minimal test completes successfully.

---

## qtclustering-sycl
- **Args**: --Verbose (or other options)
- **Current**: Not in subset.json
- **Minimal**: ["--Verbose"] (from make run: --Verbose, minimal: same)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements QT clustering using SYCL. Error: "Native API failed. Native API returns: 20 (UR_RESULT_ERROR_DEVICE_LOST)". Runtime error during execution.

---

## quicksort-sycl
- **Args**: num_iterations, widthReSz, heightReSz
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 10 2048 2048, minimal: all=1)
- **Compilation**: FAIL (error with local_ptr<double>)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements quicksort using SYCL. Compilation fails with template matching error for local_ptr<double>. Requires code fix.

---

## radixsort-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~143.7ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements radix sort using SYCL. Minimal test completes successfully.

---

## radixsort2-sycl
- **Args**: -n=num_elements (and optional flags)
- **Current**: Not in subset.json
- **Minimal**: ["-n=1"] (from make run: -n=536870912, minimal: -n=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements radix sort using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## rainflow-sycl
- **Args**: num_history, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~112.9ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements rainflow counting using SYCL. Minimal test completes successfully.

---

## randomAccess-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~340.5ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements random access benchmark using SYCL. Minimal test completes successfully.

---

## rayleighBenardConvection-sycl
- **Args**: timesteps
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10, minimal: timesteps=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~788.8ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Rayleigh-Benard convection simulation using SYCL with oneMKL. Minimal test completes successfully.

---

## reaction-sycl
- **Args**: timesteps
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000, minimal: timesteps=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~154ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements reaction-diffusion simulation using SYCL. Minimal test completes successfully.

---

## recursiveGaussian-sycl
- **Args**: input_image, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../recursiveGaussian-cuda/StoneRGB.ppm", "1"] (from make run: same 1000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements recursive Gaussian filter using SYCL. Requires input PPM file. Minimal test completes successfully.

---

## relu-sycl
- **Args**: count, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 100000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~34.7ms (impl1), ~0.26ms (impl2)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements ReLU activation using SYCL. Tests different implementations. Minimal test completes successfully.

---

## remap-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 1000, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements remap operation using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## resize-sycl
- **Args**: in_width, in_height, out_width, out_height, num_channels, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1"] (from make run: 1920 1080 256 256 512 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.1ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements image resizing using SYCL. Tests nearest neighbor and bilinear resizing. Minimal test completes successfully.

---

## resnet-kernels-sycl
- **Args**: mode, repeat
- **Current**: Not in subset.json
- **Minimal**: ["0", "3"] (from make run: 0-5 100, minimal: mode=0, repeat=3)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements ResNet kernels using SYCL. Error: "Bad file path data/input_14_1_128.bin: (nil), No such file or directory". Requires input data files.

---

## reverse-sycl
- **Args**: iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: iterations=1)
- **Compilation**: PASS
- **Execution Time**: ~50.7ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements reverse operation using SYCL. Minimal test completes successfully.

---

## reverse2D-sycl
- **Args**: nrows, ncols, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8192 8192 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.05ms (rows), ~0.28ms (columns)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 2D reverse operation using SYCL. Tests reverse along rows and columns. Minimal test completes successfully.

---

## rfs-sycl
- **Args**: num_arrays, length
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100 5000000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~77.4ms (sumArray), ~0.24ms (sumArrays)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements RFS (Reduction of Float Arrays) using SYCL. Minimal test completes successfully.

---

## ring-sycl
- **Args**: min_len, max_len, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1 67108864 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements ring communication using SYCL. Segmentation fault (exit code 139) during execution.

---

## rng-wallace-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~65.6ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Wallace random number generator using SYCL. Minimal test completes successfully.

---

## rodrigues-sycl
- **Args**: num_points, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000000 10000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~120.8ms (float3), ~0.32ms (float4)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Rodrigues rotation formula using SYCL. Tests float3 and float4 implementations. Minimal test completes successfully.

---

## romberg-sycl
- **Args**: num_work_groups, work_group_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 128 64 1000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~2.3s
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Romberg integration using SYCL. Verification fails. Results do not match reference.

---

## rotary-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~51.5ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements rotary embedding using SYCL. Minimal test completes successfully.

---

## rowwiseMoments-sycl
- **Args**: batch, channel, width, height, group, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1"] (from make run: 128 128 128 128 4 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~103ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements rowwise moments computation using SYCL. Minimal test completes successfully.

---

## rsbench-sycl
- **Args**: -s size, -m method (and other options)
- **Current**: Not in subset.json
- **Minimal**: ["-s", "small", "-m", "event"] (from make run: -s large -m event, minimal: -s small -m event)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements RSBench (Reactor Simulation Benchmark) using SYCL. Timed out during execution.

---

## rsc-sycl
- **Args**: -f input_file, -g num_gpu_blocks (and other options)
- **Current**: Not in subset.json
- **Minimal**: ["-f", "../rsc-cuda/input/vectors.csv", "-g", "1"] (from make run: -f ../rsc-cuda/input/vectors.csv -g 512, minimal: -g=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~6.3s (1005 iterations)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements RSC (Regression-based Sparse Coding) using SYCL. Minimal test completes successfully.

---

## rsmt-sycl
- **Args**: input_file
- **Current**: Not in subset.json
- **Minimal**: ["../rsmt-cuda/newblue7.kraftwerk70.3d.80.20.82.m8.gr"] (from make run: same, minimal: same)
- **Compilation**: FAIL (fatal error: too many errors with atomic_ref)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements RSMT (Rectilinear Steiner Minimum Tree) using SYCL. Compilation fails with atomic_ref errors. Requires code fix.

---

## rtm8-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~58.9ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements RTM8 (Reverse Time Migration) using SYCL. Minimal test completes successfully.

---

## rushlarsen-sycl
- **Args**: num_timesteps, num_nodes
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100 100000, minimal: all=1)
- **Compilation**: FAIL (error with sycl::sqrt)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Rush-Larsen method using SYCL. Compilation fails with sycl::sqrt error. Requires code fix.

---

## s3d-sycl
- **Args**: -q, -n num_iterations, -s num_steps (and other options)
- **Current**: Not in subset.json
- **Minimal**: ["-q", "-n", "1", "-s", "1"] (from make run: -q -n 100 -s 1, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~114.4ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements S3D (Structured 3D) simulation using SYCL. Minimal test completes successfully.

---

## s8n-sycl
- **Args**: num_batches, num_points, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1513 2048 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~79.9ms (select), ~0.45ms (select2), ~0.32ms (select4)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements S8N (Select 8 Neighbors) using SYCL. Tests different select kernels. Minimal test completes successfully.

---

## sad-sycl
- **Args**: input_image, template_image, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../sad-cuda/coins.bmp", "../sad-cuda/coin.bmp", "1"] (from make run: same 100, minimal: repeat=1)
- **Compilation**: FAIL (fatal error: CL/__spirv/spirv_types.hpp: No such file or directory)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SAD (Sum of Absolute Differences) using SYCL. Compilation fails due to missing SPIRV headers. Requires environment fix.

---

## sampling-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~34.8ms, ~97.2ms, ~3.1ms (different kernels)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements sampling operations using SYCL. Tests different sampling kernels. Minimal test completes successfully.

---

## sa-sycl
- **Args**: dataset_file, dataset_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["genome.txt", "1", "1"] (from make run: genome.txt 1000000 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SA (Simulated Annealing) using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## saxpy-ompt-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SAXPY with OpenMP target offloading using SYCL. Timed out during execution.

---

## scan-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 268435456 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~80us
- **Result**: PASS
- **Notes**: Not in standard subset. Implements scan operation using SYCL. Minimal test completes successfully.

---

## scan2-sycl
- **Args**: repeat, input_length, block_size
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1000 33554432 256, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements scan2 operation using SYCL. Timed out during execution.

---

## scan3-sycl
- **Args**: repeat, input_length
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000 33554432, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements scan3 operation using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## scatter-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (segmentation fault)
- **Notes**: Not in standard subset. Implements scatter operation using SYCL. Segmentation fault during execution.

---

## scatterAdd-sycl
- **Args**: batch_size, output_size, vector_dim, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 10000000 32 8 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~373us
- **Result**: PASS
- **Notes**: Not in standard subset. Implements scatter-add operation using SYCL. Minimal test completes successfully.

---

## scatterThrust-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements scatter operation using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## scel-sycl
- **Args**: outer_size, inner_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 2048 50176 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~78ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SCEL (Sigmoid Cross Entropy with Logits) using SYCL. Minimal test completes successfully.

---

## score-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~132ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements score calculation using SYCL. Minimal test completes successfully.

---

## sc-sycl
- **Args**: -a alpha
- **Current**: Not in subset.json
- **Minimal**: ["-a", "0.1"] (from make run: -a 0.1, minimal: same)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~661ms (105 iterations)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements stream compaction using SYCL. Minimal test completes successfully.

---

## seam-carving-sycl
- **Args**: image_file, num_seams, [options]
- **Current**: Not in subset.json
- **Minimal**: ["../seam-carving-cuda/Broadway_tower.jpg", "1", "-u"] (from make run: same with 100, minimal: seams=1)
- **Compilation**: FAIL (fatal error: CL/__spirv/spirv_types.hpp: No such file or directory)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements seam carving using SYCL. Compilation fails due to missing SPIR-V headers.

---

## secp256k1-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~1.9s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements secp256k1 elliptic curve cryptography using SYCL. Minimal test completes successfully.

---

## segment-reduce-sycl
- **Args**: multiplier, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements segment reduction using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## segsort-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~13ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements segmented sort using SYCL. Minimal test completes successfully.

---

## sheath-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: ~11.3s (1000 time steps)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements sheath simulation using SYCL. Minimal test completes successfully.

---

## shmembench-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~132ms
- **Result**: FAIL (checksum failed)
- **Notes**: Not in standard subset. Implements shared memory bandwidth benchmark using SYCL. Checksum verification failed.

---

## shuffle-sycl
- **Args**: repeat_broadcast, repeat_transpose
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 200000 100, minimal: all=1)
- **Compilation**: FAIL (error: no member named 'shuffle' in 'sycl::sub_group')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements shuffle operations using SYCL. Compilation fails due to unsupported sub_group::shuffle API.

---

## simplemoc-sycl
- **Args**: -s segments, -e energy_groups, -n kernel_runs
- **Current**: Not in subset.json
- **Minimal**: ["-s", "1", "-e", "1", "-n", "1"] (from make run: -s 5000000 -e 128 -n 10, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~17ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SimpleMOC (Method of Characteristics) using SYCL. Minimal test completes successfully.

---

## simpleMultiDevice-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements simple multi-device operations using SYCL. Minimal test completes successfully.

---

## simpleSpmv-sycl
- **Args**: num_nonzero, num_rows, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 16777216 10240 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (segmentation fault)
- **Notes**: Not in standard subset. Implements simple sparse matrix-vector multiplication using SYCL. Segmentation fault during execution.

---

## slit-sycl
- **Args**: transform_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1024 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~1.7ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SLIT (FFT) using SYCL with oneMKL. Minimal test completes successfully.

---

## slu-sycl
- **Args**: -i input_file
- **Current**: Not in subset.json
- **Minimal**: ["-i", "../slu-cuda/src/nicslu/test/add32.mtx"] (from make run: -i ../slu-cuda/src/nicslu/demo/ASIC_100k.mtx, minimal: test file)
- **Compilation**: FAIL (make: ../slu-cuda/src/nicslu/: No such file or directory)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements sparse LU factorization using SYCL. Compilation fails due to missing dependency directory.

---

## snake-sycl
- **Args**: read_length, read_file, num_reads, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "../snake-cuda/Datasets/ERR240727_1_E2_30000Pairs.txt", "1", "1"] (from make run: 100 same 30000 1000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~273us per kernel
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SNAKE sequence alignment using SYCL. Minimal test completes successfully.

---

## sobel-sycl
- **Args**: image_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["SobelFilter_Input.bmp", "1"] (from make run: SobelFilter_Input.bmp 100000, minimal: repeat=1)
- **Compilation**: FAIL (error: use of undeclared identifier 'powf')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Sobel filter using SYCL. Compilation fails due to missing math function declaration.

---

## sobol-sycl
- **Args**: num_vectors, num_dimensions, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1000000 1000 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Sobol quasi-random number generation using SYCL. Minimal test completes successfully.

---

## softmax-sycl
- **Args**: num_slices, slice_size, implementation, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "0", "1"] (from make run: 100000 784 0 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~18ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements softmax operation using SYCL. Minimal test completes successfully.

---

## softmax-fused-sycl
- **Args**: batch, head, query_length, key_length, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 4 12 256 256 1000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (segmentation fault)
- **Notes**: Not in standard subset. Implements fused softmax operation using SYCL. Segmentation fault during execution.

---

## softmax-online-sycl
- **Args**: kernel_num
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1, minimal: kernel_num=1)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements online softmax operation using SYCL. Timed out during execution.

---

## sort-sycl
- **Args**: problem_size, num_passes
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 3 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements sort operation using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## sortKV-sycl
- **Args**: num_keys, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 1000000 100, minimal: all=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements key-value sort using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## sosfil-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~108ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SOSFIL (Second Order Section Filter) using SYCL. Minimal test completes successfully.

---

## sparkler-sycl
- **Args**: --num_vector, --num_field, --num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["--num_vector", "2", "--num_field", "1", "--num_iterations", "1"] (from make run: --num_vector 4000 --num_field 90000 --num_iterations 10, minimal: all=1)
- **Compilation**: FAIL (make: mpiicpc: No such file or directory)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements Sparkler using SYCL with MPI. Compilation fails due to missing MPI compiler.

---

## spgeam-sycl
- **Args**: M, K, nnz, repeat, verify
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1"] (from make run: 20082 20082 150616 1000 1, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~337ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements sparse matrix element-wise addition using SYCL with oneMKL. Minimal test completes successfully.

---

## spgemm-sycl
- **Args**: M, K, N, A_nnz, repeat, verify
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1"] (from make run: 1024 1024 1024 1024 1000 1, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~59ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements sparse matrix-dense matrix multiplication using SYCL with oneMKL. Minimal test completes successfully.

---

## sph-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SPH (Smoothed Particle Hydrodynamics) using SYCL. Timed out during execution.

---

## split-sycl
- **Args**: num_keys, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 33554432 1000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~59ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements split operation using SYCL. Minimal test completes successfully.

---

## spm-sycl
- **Args**: dimension, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 256 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~88ms
- **Result**: FAIL (verification failed)
- **Notes**: Not in standard subset. Implements SPM (Sparse Matrix) operations using SYCL. Verification failed during execution.

---

## spmv-sycl
- **Args**: num_nonzero, num_rows, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 16777216 10240 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~69ms (CSR), ~50ms (COO)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements sparse matrix-vector multiplication using SYCL with oneMKL. Minimal test completes successfully.

---

## spsort-sycl
- **Args**: M, N, nnz, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 20082 20082 150616 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (usage error)
- **Notes**: Not in standard subset. Implements sparse matrix column index sorting using SYCL with oneMKL. Requires proper argument format.

---

## sptrsv-sycl
- **Args**: matrix_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["lp1.mtx", "1"] (from make run: lp1.mtx 2000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (segmentation fault)
- **Notes**: Not in standard subset. Implements sparse triangular solve using SYCL. Segmentation fault during execution, likely due to missing matrix file.

---

## srad-sycl
- **Args**: repeat, lambda, num_rows, num_cols
- **Current**: Not in subset.json
- **Minimal**: ["1", "0.5", "1", "1"] (from make run: 1000 0.5 502 458, minimal: all=1)
- **Compilation**: FAIL (error: use of undeclared identifier 'true')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SRAD (Speckle Reducing Anisotropic Diffusion) using SYCL. Compilation fails due to missing stdbool.h include in C code.

---

## ssim-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SSIM (Structural Similarity Index) using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## sssp-sycl
- **Args**: -g num_gpu_blocks, -t num_threads, -w warmup, -r repeat, -f input_file
- **Current**: Not in subset.json
- **Minimal**: ["-g", "1", "-t", "1", "-w", "1", "-r", "1"] (from make run: -g 120 -t 1 -w 10 -r 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (missing input file)
- **Notes**: Not in standard subset. Implements SSSP (Single Source Shortest Path) using SYCL. Error: "failed to read file input/NYR_input.dat". Requires input data file.

---

## sss-sycl
- **Args**: data_file
- **Current**: Not in subset.json
- **Minimal**: ["f9_n150_p50"] (from make run: f9_n150_p50, minimal: same)
- **Compilation**: FAIL (fatal error: 'gsl/gsl_integration.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements SSS (Structured Stochastic Search) using SYCL with GSL. Compilation fails due to missing GSL installation or incorrect include paths.

---

## ss-sycl
- **Args**: file_path, substring, repeat
- **Current**: Not in subset.json
- **Minimal**: ["StringSearch_Input.txt", "test", "1"] (from make run: StringSearch_Input.txt clEnqueueNDRangeKernel 20000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (search pattern too short)
- **Notes**: Not in standard subset. Implements string search using SYCL. Error: "Search pattern size should be longer than 16". Requires longer search pattern.

---

## stddev-sycl
- **Args**: D, N, repeat
- **Current**: Not in subset.json
- **Minimal**: ["32", "1", "1"] (from make run: 65536 16384 100, minimal: D=32, N=1, repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~0.33ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements standard deviation computation using SYCL. Minimal test completes successfully.

---

## stencil1d-sycl
- **Args**: length, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 134217728 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (non-uniform work-groups not supported)
- **Notes**: Not in standard subset. Implements 1D stencil computation using SYCL. Runtime error: "Non-uniform work-groups are not supported by the target device".

---

## stencil3d-sycl
- **Args**: grid_dimension, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 512 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (device lost)
- **Notes**: Not in standard subset. Implements 3D stencil computation using SYCL. Runtime error: "Native API failed. Native API returns: 20 (UR_RESULT_ERROR_DEVICE_LOST)".

---

## streamcluster-sycl
- **Args**: k1, k2, d, n, chunksize, clustersize, infile, outfile, nproc
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1", "1", "1", "none", "output.txt", "1"] (from make run: 10 20 256 65536 65536 1000 none output.txt 1, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements stream clustering using SYCL. Minimal test completes successfully.

---

## streamCreateCopyDestroy-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A (timeout)
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements stream create/copy/destroy operations using SYCL. Timed out during execution.

---

## streamPriority-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: ~168ms (high priority), ~181ms (no priority)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements stream priority operations using SYCL. Minimal test completes successfully.

---

## streamUM-sycl
- **Args**: num_threads, num_tasks, verify
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 4 1000 1, minimal: all=1)
- **Compilation**: FAIL (undefined reference to OpenMP functions)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements unified memory stream operations using SYCL with OpenMP. Compilation fails due to missing OpenMP library linkage.

---

## stsg-sycl
- **Args**: parameter_file
- **Current**: Not in subset.json
- **Minimal**: ["example.txt"] (from make run: example.txt, minimal: same)
- **Compilation**: FAIL (fatal error: 'gdal/gdal_priv.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements STSG using SYCL with GDAL. Compilation fails due to missing GDAL installation or incorrect include paths.

---

## su3-sycl
- **Args**: -i iterations, -l ldim, -t threads_per_group, -v verbosity, -w warmups
- **Current**: Not in subset.json
- **Minimal**: ["-i", "1", "-l", "1", "-t", "1", "-v", "0", "-w", "1"] (from make run: -i 1000 -l 32 -t 128 -v 3 -w 1, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~1.6s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements SU(3) lattice gauge theory using SYCL. Minimal test completes successfully.

---

## surfel-sycl
- **Args**: input_height, output_width, output_height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 1024 2960 1440 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.35ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements surfel operations using SYCL. Minimal test completes successfully.

---

## svd3x3-sycl
- **Args**: file_path, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../svd3x3-cuda/Dataset_1M.txt", "1"] (from make run: ../svd3x3-cuda/Dataset_1M.txt 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~109ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 3x3 SVD computation using SYCL. Minimal test completes successfully.

---

## sw4ck-sycl
- **Args**: input_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../sw4ck-cuda/sw4ck.in", "1"] (from make run: ../sw4ck-cuda/sw4ck.in 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (segmentation fault)
- **Notes**: Not in standard subset. Implements SW4CK using SYCL. Segmentation fault during execution.

---

## swish-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~16.6ms (Swish), ~0.27ms (SwishGradient)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Swish activation function using SYCL. Minimal test completes successfully.

---

## tensorAccessor-sycl
- **Args**: num_rows, num_cols, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8192 8192 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~263us (raw_accessor), ~56us (tensor_packed_accessor)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements tensor accessor operations using SYCL. Minimal test completes successfully.

---

## tensorT-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: FAIL (error: subscripted value is not an array, pointer, or vector)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements tensor transpose using SYCL. Compilation fails due to code bug (argv/argc swapped in main function signature).

---

## testSNAP-sycl
- **Args**: --nsteps num_steps
- **Current**: Not in subset.json
- **Minimal**: ["--nsteps", "1"] (from make run: --nsteps 100, minimal: nsteps=1)
- **Compilation**: FAIL (fatal error: 'refdata_2J14_W.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements TestSNAP using SYCL. Compilation fails due to missing reference data header file.

---

## tgvnn-sycl
- **Args**: (command line options)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: FAIL (no Makefile in root directory)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements TGVNN using SYCL. Makefile is in src/ subdirectory, not in root.

---

## thomas-sycl
- **Args**: system_size, num_systems, thread_block_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 1024 16384 64 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~124ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Thomas algorithm using SYCL. Minimal test completes successfully.

---

## threadfence-sycl
- **Args**: repeat, array_length
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100 100000000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~60ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements thread fence operations using SYCL. Minimal test completes successfully.

---

## tissue-sycl
- **Args**: dimension, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 32 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~0.21ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements tissue simulation using SYCL. Minimal test completes successfully.

---

## tonemapping-sycl
- **Args**: image_file, repeat
- **Current**: Not in subset.json
- **Minimal**: ["input.hdr", "1"] (from make run: input.hdr 10000, minimal: repeat=1)
- **Compilation**: FAIL (error: no matching function for call to 'pow')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements tone mapping using SYCL. Compilation fails due to pow function usage issue.

---

## tpacf-sycl
- **Args**: -d data_file, -p data_points, -r random_file, -n random_count, -q random_points, -o output_file, -b bins, -l min_angle, -u max_angle, -j threads
- **Current**: Not in subset.json
- **Minimal**: ["-d", "data", "-p", "1", "-r", "random", "-n", "1", "-q", "1", "-o", "out", "-b", "1", "-l", "1", "-u", "1", "-j", "1"] (from make run: complex args, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (usage error)
- **Notes**: Not in standard subset. Implements TPACF (Two-Point Angular Correlation Function) using SYCL. Requires proper argument format.

---

## tqs-sycl
- **Args**: -f input_file (and other options)
- **Current**: Not in subset.json
- **Minimal**: ["-f", "../tqs-cuda/input/patternsNP100NB512FB25.txt"] (from make run: -f ../tqs-cuda/input/patternsNP100NB512FB25.txt, minimal: same)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (missing input file)
- **Notes**: Not in standard subset. Implements TQS using SYCL. Error: "Unable to open file input/patternsNP100NB512FB25.txt". Requires input data file.

---

## triad-sycl
- **Args**: --passes num_passes, -v (verbose)
- **Current**: Not in subset.json
- **Minimal**: ["--passes", "1", "-v"] (from make run: --passes 100 -v, minimal: passes=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (usage error)
- **Notes**: Not in standard subset. Implements triad operation using SYCL. Requires proper argument format.

---

## tridiagonal-sycl
- **Args**: -num_systems=num (and optional flags)
- **Current**: Not in subset.json
- **Minimal**: ["-num_systems=1"] (from make run: -num_systems=524288, minimal: num_systems=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: PASS
- **Notes**: Not in standard subset. Implements tridiagonal system solver using SYCL. Minimal test completes successfully.

---

## tsa-sycl
- **Args**: matrix_width, matrix_height, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 1024 1024 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~142ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements TSA (Tensor Singular Approximation) using SYCL. Minimal test completes successfully.

---

## tsne-sycl
- **Args**: (command line options)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/numeric' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements t-SNE using SYCL with oneDPL. Compilation fails due to missing oneDPL installation or incorrect include paths.

---

## tsp-sycl
- **Args**: input_file, restart_count, repeat
- **Current**: Not in subset.json
- **Minimal**: ["d493.tsp", "1", "1"] (from make run: d493.tsp 24 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (usage error)
- **Notes**: Not in standard subset. Implements TSP (Traveling Salesman Problem) using SYCL. Requires input TSP file.

---

## unfold-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 1000, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~90ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements unfold operation using SYCL. Minimal test completes successfully.

---

## urng-sycl
- **Args**: file_path, repeat
- **Current**: Not in subset.json
- **Minimal**: ["URNG_Input.bmp", "1"] (from make run: URNG_Input.bmp 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (missing input file)
- **Notes**: Not in standard subset. Implements URNG (Uniform Random Number Generator) using SYCL. Error: "Failed to load file 1". Requires input BMP file.

---

## vanGenuchten-sycl
- **Args**: dimX, dimY, dimZ, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 256 256 256 1000, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~40ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements van Genuchten model using SYCL. Minimal test completes successfully.

---

## vmc-sycl
- **Args**: num_blocks_to_sample
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: no args, minimal: num_blocks=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~5.7ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements VMC (Variational Monte Carlo) using SYCL. Minimal test completes successfully.

---

## vol2col-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~13.4ms (vol2col), ~1ms (col2vol)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements volume to column conversion using SYCL. Minimal test completes successfully.

---

## vote-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10000000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~36us, ~33us (different kernels)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements vote operations using SYCL. Minimal test completes successfully.

---

## voxelization-sycl
- **Args**: data_folder, repeat
- **Current**: Not in subset.json
- **Minimal**: ["../voxelization-cuda/data/test/", "1"] (from make run: ../voxelization-cuda/data/test/ 100000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (missing folder)
- **Notes**: Not in standard subset. Implements voxelization using SYCL. Error: "No such folder: 1". Requires data folder.

---

## mf-sgd-sycl
- **Args**: (command-line flags: --gpu, --k, --num_iters, --lrate, --alpha, --beta, --num_workers, --u_grid, --v_grid, --x_grid, --y_grid, training_file)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args in Makefile, minimal: no args, but requires training file)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: FAIL (missing training file)
- **Notes**: Not in standard subset. Implements Matrix Factorization with Stochastic Gradient Descent using SYCL. Requires training data file. Error: "file --help open failed" when run with --help.

---

## miniFE-sycl
- **Args**: (optional command-line arguments via get_parameters)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~0.003s
- **Result**: PASS
- **Notes**: Not in standard subset. Implements MiniFE (Finite Element) using SYCL. Runs with default mesh size when no arguments provided. Solution verification passes.

---

## si-sycl
- **Args**: (uses cxxopts for argument parsing)
- **Current**: Not in subset.json
- **Minimal**: [] (from CMakeLists.txt: uses CMake build system)
- **Compilation**: N/A (CMake build system, needs cmake configuration)
- **Execution Time**: N/A
- **Result**: N/A
- **Notes**: Not in standard subset. Implements SI (likely Similarity Index) using SYCL. Uses CMake build system instead of Makefile. Requires proper CMake configuration to build.

---

## snicit-sycl
- **Args**: -k benchmark, -p root_data_path, -n num_input, -b batch_size, -t threshold
- **Current**: Not in subset.json
- **Minimal**: ["-k", "A", "-n", "100", "-b", "100"] (from make run: ./run.sh, minimal: small inputs)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: N/A (requires dataset)
- **Notes**: Not in standard subset. Implements SNICIT (Sparse Neural Network Inference) using SYCL. Requires dataset at root_data_path. Benchmark options: A, B, C, D.

---

## quant3MatMul-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~0.84ms (faster kernel)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements 3-bit quantized matrix multiplication using SYCL. Minimal test completes successfully.

---

## quantAQLM-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: ~101ms (first kernel), ~0.44-0.50ms (subsequent kernels)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements AQLM (Additive Quantization for Language Models) quantized operations using SYCL. No arguments required, runs with hardcoded problem size.

---

## quantBnB-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 100000000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~77.4ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements BnB (Bits and Bytes) quantization using SYCL. Minimal test completes successfully.

---

## quantVLLM-sycl
- **Args**: num_tokens, hidden_size, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 4096 5137 1000, minimal: all=1)
- **Compilation**: FAIL (error: unknown argument: '-foffload-fp32-prec-div')
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements VLLM (Very Large Language Model) quantization using SYCL. Compilation fails due to unsupported compiler flag `-foffload-fp32-prec-div` in Intel oneAPI compiler. Requires Makefile modification to remove this flag.

---

## warpexchange-sycl
- **Args**: nrows, ncols, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8192 8192 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~3.3ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements warp exchange operations using SYCL. Minimal test completes successfully.

---

## warpsort-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: FAIL (fatal error: 'boost/preprocessor/repetition/repeat.hpp' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements warp-level sorting using SYCL. Compilation fails due to missing Boost Preprocessor headers. Requires Boost library installation.

---

## wedford-sycl
- **Args**: width, height, depth, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1", "1"] (from make run: 512 512 8192 100, minimal: all=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~3.3ms
- **Result**: FAIL (correctness error: "Error at index 0")
- **Notes**: Not in standard subset. Implements Wedford algorithm using SYCL. Compiles and runs but fails correctness verification.

---

## winograd-sycl
- **Args**: (none)
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: no args, minimal: no args)
- **Compilation**: PASS
- **Execution Time**: ~0.29s (co-execution), ~0.92s (total)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements Winograd convolution using SYCL. No arguments required, runs with hardcoded problem size.

---

## wlcpow-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 1000, minimal: repeat=1)
- **Compilation**: FAIL (template errors related to DEVICE_IMPL_TEMPLATE_CUSTOM_DELEGATE macro)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements WLC (Weighted Linear Combination) power operations using SYCL. Compilation fails with template expansion errors.

---

## wmma-sycl
- **Args**: m, n, k, repeat, verify
- **Current**: Not in subset.json
- **Minimal**: ["256", "256", "256", "1", "1"] (from make run: multiple sizes, minimal: 256x256x256)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (runtime error: "joint_matrix with parameters matrix_type::fp16, use::a, Rows=16, Cols=16 is not supported on this device")
- **Notes**: Not in standard subset. Implements WMMA (Warp Matrix Multiply-Accumulate) using SYCL. Compiles but fails at runtime due to unsupported joint_matrix configuration on the device.

---

## word2vec-sycl
- **Args**: -train file, -output file, -cbow, -size, -window, -negative, -hs, -sample, -threads, -binary, -iter
- **Current**: Not in subset.json
- **Minimal**: [] (from make run: requires text8 training file, minimal: no args but needs file)
- **Compilation**: PASS
- **Execution Time**: N/A
- **Result**: FAIL (missing training file)
- **Notes**: Not in standard subset. Implements Word2Vec using SYCL. Requires text8 training data file. Error: "ERROR: training data file not found!" when run without file.

---

## wordcount-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10, minimal: num_iterations=1)
- **Compilation**: FAIL (fatal error: 'oneapi/dpl/execution' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements word counting using SYCL. Compilation fails due to missing oneDPL (oneAPI Data Parallel Library) headers. Requires oneDPL installation.

---

## wsm5-sycl
- **Args**: num_iterations
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 10, minimal: num_iterations=1)
- **Compilation**: FAIL (template errors related to DEVICE_IMPL_TEMPLATE_CUSTOM_DELEGATE macro)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements WSM5 (WRF Single-Moment 5-class microphysics scheme) using SYCL. Compilation fails with template expansion errors.

---

## wyllie-sycl
- **Args**: num_elements, num_iterations, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1", "1"] (from make run: 8000000 1 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: N/A (crashed with exit code 136)
- **Result**: FAIL (runtime crash)
- **Notes**: Not in standard subset. Implements Wyllie algorithm using SYCL. Compiles but crashes at runtime (likely segmentation fault).

---

## xlqc-sycl
- **Args**: precision (sp or dp)
- **Current**: Not in subset.json
- **Minimal**: ["sp"] (from make run: sp and dp, minimal: single precision)
- **Compilation**: FAIL (fatal error: 'gsl/gsl_matrix.h' file not found)
- **Execution Time**: N/A
- **Result**: FAIL
- **Notes**: Not in standard subset. Implements XLQC (Extended Linearized Quantum Chemistry) using SYCL. Compilation fails due to missing GSL (GNU Scientific Library) headers. Requires GSL installation.

---

## xsbench-sycl
- **Args**: -s size, -m method, -r repeat (and other options)
- **Current**: Not in subset.json
- **Minimal**: ["-s", "small", "-m", "event", "-r", "1"] (from make run: -s large -m event -r 10, minimal: small size, 1 repeat)
- **Compilation**: PASS
- **Execution Time**: ~0.77s
- **Result**: FAIL (checksum mismatch: "Verification checksum: 50959929 != 50945140")
- **Notes**: Not in standard subset. Implements XSBench (Cross-Section Benchmark) using SYCL. Compiles and runs but fails checksum verification.

---

## zerocopy-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS
- **Execution Time**: ~91.7ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements zero-copy memory operations using SYCL. Minimal test completes successfully.

---

## zeropoint-sycl
- **Args**: num_elements, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "1"] (from make run: 10000000 100, minimal: all=1)
- **Compilation**: PASS
- **Execution Time**: ~7.4ms
- **Result**: PASS
- **Notes**: Not in standard subset. Implements zero-point quantization using SYCL. Minimal test completes successfully.

---

## zmddft-sycl
- **Args**: repeat
- **Current**: Not in subset.json
- **Minimal**: ["1"] (from make run: 100, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: N/A
- **Result**: N/A (requires correct usage)
- **Notes**: Not in standard subset. Implements ZMDDFT (Zero-Memory Distributed Discrete Fourier Transform) using SYCL. Compiles successfully.

---

## zoom-sycl
- **Args**: batch, channel, height, width, repeat
- **Current**: Not in subset.json
- **Minimal**: ["1", "3", "2160", "4096", "1"] (from make run: 1 3 2160 4096 1000, minimal: repeat=1)
- **Compilation**: PASS (with warnings)
- **Execution Time**: ~88.3ms (zoom-in), ~1.1ms (zoom-out)
- **Result**: PASS
- **Notes**: Not in standard subset. Implements zoom operations using SYCL. Minimal test completes successfully.