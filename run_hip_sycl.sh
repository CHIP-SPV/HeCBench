#!/bin/bash

export LEVEL0=1
export OPENCL=1
export REPEATS=2

export CHIP_L0_COLLECT_EVENTS_TIMEOUT=5
export WARMPUP=1
# export CHIP_DUMP_SPIRV=1
# export SYCL_DUMP_IMAGES=1

export CHIP_DEVICE_TYPE=gpu
export CHIP_LOGLEVEL=crit

# -------------------
#source /etc/profile.d/modules.sh
#module load oneapi/2024.2.2
module load HIP/chipStar/v1.2.1
#export CHIP_MODULE_CACHE_DIR=""

# Check if hipcc is in PATH
if ! command -v hipcc &> /dev/null; then
    echo "Error: hipcc not found in PATH"
    exit 1
fi

RUNTIME=SYCL
if [ $OPENCL -ne 0 ]; then
  export SYCL_CACHE_PERSISTENT=0
  export ONEAPI_DEVICE_SELECTOR="opencl:gpu"
  
  ./scripts/autohecbench.py --clean --warmup ${WARMPUP} --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o ${RUNTIME}_FULL_${REPEATS}_x_sycl_strict_oclBE.csv --sycl-type opencl sycl
fi

if [ $LEVEL0 -ne 0 ]; then
  export SYCL_CACHE_PERSISTENT=0
  export ONEAPI_DEVICE_SELECTOR="level_zero:gpu"
  ./scripts/autohecbench.py --clean --warmup ${WARMPUP} --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o ${RUNTIME}_FULL_${REPEATS}_x_sycl_strict_l0BE.csv --sycl-type opencl sycl
fi

# Generate plot
#	./scripts/plot.py -g -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
#	    -t "HeCBench, Intel Arc770, ${RUNTIME}(OCL) vs ${RUNTIME}(L0) speedup" \
#	    -b ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_oclBE.csv \
#	    -c ./${RUNTIME}_FULL_${REPEATS}_x_hip_strict_l0BE.csv \
#	    -o ${RUNTIME}_ocl_vs_l0.png


#############################################
