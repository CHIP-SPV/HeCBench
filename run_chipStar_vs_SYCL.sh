#!/bin/bash

export REPEATS=2
export WARMPUP=0
export CHIP_L0_COLLECT_EVENTS_TIMEOUT=5
export CHIP_DEVICE_TYPE=gpu
export CHIP_LOGLEVEL=crit
export CHIP_MODULE_CACHE_DIR=""

# Load base modules
source /etc/profile.d/modules.sh
module load oneapi/2024.2.2

# Function to run benchmarks for a specific ChipStar version
run_benchmarks() {
    local VERSION=$1
    local RUNTIME="chipStar-${VERSION}"
    
    # OpenCL benchmark
    module load opencl/dgpu
    ./scripts/autohecbench.py --warmup ${WARMPUP} --repeat ${REPEATS} \
        -o ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv hip 2>&1 | \
        tee ${RUNTIME}_ocl_benchmark.log
    module unload opencl/dgpu
    
    # Level Zero benchmark
    module load level-zero/dgpu
    ./scripts/autohecbench.py --warmup ${WARMPUP} --repeat ${REPEATS} \
        -o ${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv hip 2>&1 | \
        tee ${RUNTIME}_l0_benchmark.log
    module unload level-zero/dgpu
    
    # Generate plot
    ./scripts/plot.py -g -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
        -t "HeCBench, Intel Arc770, chipStar-${VERSION}(L0) vs chipStar-${VERSION}(OCL) speedup" \
        -b ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv \
        -c ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv \
        -o chipStar-${VERSION}_ocl_vs_l0.png
}

# Test v1.2.1
module load HIP/chipStar/v1.2.1
run_benchmarks "v1.2.1"
module unload HIP/chipStar/v1.2.1