#!/bin/bash

REPEATS=3

export CHIP_DEVICE_TYPE=cpu
export CHIP_LOGLEVEL=crit
export CHIP_LAZY_JIT=0
export CHIP_BE=opencl
unset CHIP_PLATFORM

export POCL_MAX_WORK_GROUP_SIZE=1024
export POCL_CACHE_DIR=/tmp/POCL_CACHE
#export POCL_DEBUG=err,warn

SAVED_PATH=$PATH

export PATH=/home/user/0/install/bin:$SAVED_PATH

# RUNTESTS=(compute-score-hip dct8x8-hip entropy-hip fft-hip haversine-hip jenkins-hash-hip linearprobing-hip murmurhash3-hip overlap-hip softmax-hip sort-hip adam-hip)

echo "HIPCC: "
which hipcc || exit 1
sleep 3
### rm data && git clean -f -d -x && ln -s /home/user/0/source/data .
./scripts/autohecbench.py --verbose --warmup true --repeat ${REPEATS} -o /home/user/test_FULL_${REPEATS}_x_with_abort_strictmath.csv hip
 # ${RUNTESTS[@]}

exit 14

##############################

echo "HIPCC: "
which hipcc || exit 1
sleep 3
####rm data && git clean -f -d -x && ln -s /home/user/0/source/data .
./scripts/autohecbench.py --clean --warmup true --repeat ${REPEATS} --extra-compile-flags="-ffast-math"  -o /home/user/test_FULL_${REPEATS}_x_with_abort_fastmath.csv # ${RUNTESTS[@]}
