#!/bin/bash

export LEVEL0=1
export OPENCL=1
export REPEATS=1

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
source /etc/profile.d/modules.sh
module load oneapi/2024.1.0
module load HIP/chipStar/v1.2

# ╭─pvelesko@cupcake /space/pvelesko/HeCBench ‹chipStar-bench●› 
# ╰─$ clinfo -l                                                                                                                                                                                                             130 ↵
# Platform #0: Intel(R) OpenCL
#  `-- Device #0: 13th Gen Intel(R) Core(TM) i9-13900K
# Platform #1: Intel(R) OpenCL Graphics
#  `-- Device #0: Intel(R) Arc(TM) A770 Graphics
# Platform #2: Intel(R) OpenCL Graphics
#  `-- Device #0: Intel(R) UHD Graphics 770

if [ $OPENCL -ne 0 ]; then
  export SYCL_CACHE_PERSISTENT=0
  export ONEAPI_DEVICE_SELECTOR="opencl:gpu"
  
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o test_FULL_${REPEATS}_x_sycl_strict_oclBE.csv --sycl-type opencl sycl
fi

if [ $LEVEL0 -ne 0 ]; then
  export SYCL_CACHE_PERSISTENT=0
  export ONEAPI_DEVICE_SELECTOR="level0:gpu"
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} --extra-compile-flags="-fp-model=precise -fno-sycl-instrument-device-code" -o test_FULL_${REPEATS}_x_sycl_strict_l0BE.csv --sycl-type opencl sycl
fi


#############################################

if [ $OPENCL -ne 0 ]; then

  # export CHIP_BE=opencl
  # export CHIP_PLATFORM=1
  module load opencl/dgpu
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} -o chipStar-v1.2-test_FULL_${REPEATS}_x_hip_strict_oclBE.csv hip
  module unload opencl/dgpu
fi

# -------------------

if [ $LEVEL0 -ne 0 ]; then

  module load level-zero/dgpu
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} -o chipStar-v1.2-test_FULL_${REPEATS}_x_hip_strict_l0BE.csv hip
  module unload level-zero/dgpu
fi

#############################################


module unload HIP/chipStar/v1.2
module load HIP/chipStar/v1.1

#############################################

if [ $OPENCL -ne 0 ]; then

  # export CHIP_BE=opencl
  # export CHIP_PLATFORM=1
  module load opencl/dgpu
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} -o chipStar-v1.1-test_FULL_${REPEATS}_x_hip_strict_oclBE.csv hip
  module unload opencl/dgpu
fi

# -------------------

if [ $LEVEL0 -ne 0 ]; then

  module load level-zero/dgpu
  ./scripts/autohecbench.py --warmup false --repeat ${REPEATS} -o chipStar-v1.1-test_FULL_${REPEATS}_x_hip_strict_l0BE.csv hip
  module unload level-zero/dgpu
fi

#############################################