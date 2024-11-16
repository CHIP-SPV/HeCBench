#!/bin/bash

export REPEATS=2
export WARMPUP=1
export CHIP_L0_COLLECT_EVENTS_TIMEOUT=5
export CHIP_DEVICE_TYPE=gpu
export CHIP_LOGLEVEL=crit
export CACHE1=1

if [ $CACHE1 -eq 0 ]; then
    export CHIP_MODULE_CACHE_DIR=""
fi  

# Load base modules
source /etc/profile.d/modules.sh
module load oneapi/2024.2.2

# Function to run benchmarks for a specific ChipStar version
run_benchmarks() {
    local VERSION=$1
    local RUNTIME="chipStar-${VERSION}-Warmup${WARMPUP}-cache"
    
    # # OpenCL benchmark
    # module load opencl/dgpu
    # rm -f ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv
    # ./scripts/autohecbench.py --warmup ${WARMPUP} --repeat ${REPEATS} \
    #     -o ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv hip 2>&1 | \
    #     tee ${RUNTIME}_ocl_benchmark.log
    # module unload opencl/dgpu
    
    # Level Zero benchmark
    module load level-zero/dgpu
    rm -f ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv
    ./scripts/autohecbench.py --warmup ${WARMPUP} --repeat ${REPEATS} \
        -o ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv hip 2>&1 | \
        tee ${RUNTIME}_l0_benchmark.log
    module unload level-zero/dgpu
    
    # Generate plot
    ./scripts/plot.py -g -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
        -t "HeCBench, Intel Arc770, ${RUNTIME}(OCL) vs ${RUNTIME}(L0) speedup" \
        -b ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv \
        -c ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv \
        -o ${RUNTIME}_ocl_vs_l0.png
}

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_benchmarks "v1.1.0"
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_benchmarks "v1.2.0"
# module unload HIP/chipStar/v1.2.0

# Test v1.2.1
module load HIP/chipStar/v1.2.1
run_benchmarks "v1.2.1"
module unload HIP/chipStar/v1.2.1