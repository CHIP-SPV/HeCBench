#!/bin/bash

LEVEL0=1
OPENCL=1
REPEATS=4

export CHIP_L0_COLLECT_EVENTS_TIMEOUT=5
export CHIP_L0_IMM_CMD_LISTS=1
# export CHIP_DUMP_SPIRV=1
# export SYCL_DUMP_IMAGES=1


for D in $(echo *-hip *-sycl); do
  mkdir -p $D/l0_cache
done

export CHIP_DEVICE_TYPE=gpu
export CHIP_LOGLEVEL=crit

# -------------------

if [ $OPENCL -ne 0 ]; then

  export CHIP_BE=opencl
  export CHIP_PLATFORM=1

  ./scripts/autohecbench.py --warmup true --repeat ${REPEATS} -o test_FULL_${REPEATS}_x_hip_strict_oclBE.csv hip
fi

# -------------------

if [ $LEVEL0 -ne 0 ]; then

  unset CHIP_PLATFORM
  export CHIP_BE=level0

  ./scripts/autohecbench.py --warmup true --repeat ${REPEATS} -o test_FULL_${REPEATS}_x_hip_strict_l0BE.csv hip
fi

#############################################

source /opt/intel/oneapi/setvars.sh

if [ $OPENCL -ne 0 ]; then
  export SYCL_DEVICE_FILTER=opencl:gpu:2
  ./scripts/autohecbench.py --warmup true --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o test_FULL_${REPEATS}_x_sycl_strict_oclBE.csv --sycl-type opencl sycl
fi

if [ $LEVEL0 -ne 0 ]; then
  export SYCL_DEVICE_FILTER=ext_oneapi_level_zero:gpu:0
  ./scripts/autohecbench.py --warmup true --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o test_FULL_${REPEATS}_x_sycl_strict_l0BE.csv --sycl-type opencl sycl
fi
