#!/bin/bash -l
set -e
export REPEATS=1
export WARMPUP=1
export CHIP_L0_COLLECT_EVENTS_TIMEOUT=5
export CHIP_DEVICE_TYPE=gpu
export CHIP_LOGLEVEL=crit
export CACHE=1
export CHIP_LAZY_JIT=OFF
if [ $CACHE -eq 0 ]; then
    export CHIP_MODULE_CACHE_DIR=""
else
    export CHIP_MODULE_CACHE_DIR=${HOME}/chipStarCache
fi


# SYCL Stuff

# ain.cpp:1:10: fatal error: 'oneapi/dpl/execution' file not found
#    1 | #include <oneapi/dpl/execution>
export CPLUS_INCLUDE_PATH=/space/pvelesko/install/oneapi/dpl/2022.3/include:$CPLUS_INCLUDE_PATH

module load llvm/18.0-lto # for OpenMP
module load opencl/ocl-icd-loader

# Function to run benchmarks for a specific ChipStar version
function run_chipStar_benchmarks() {
    local RUNTIME=$1
    local DEVICE=$2
    local RUNTIME=${DEVICE}-chipStar-${RUNTIME}
    
    # OpenCL benchmark
    if [ "$DEVICE" == "pocl" ]; then
        module load pocl/6.0
    else
        module load opencl/${DEVICE}
    fi

    rm -f ${RUNTIME}_oclBE.csv
    ./scripts/autohecbench.py --clean --warmup ${WARMPUP} --repeat ${REPEATS} \
        -o ${RUNTIME}-oclBE.csv hip 2>&1 | \
        tee ${RUNTIME}-ocl_benchmark.log
    
    if [ "$DEVICE" == "pocl" ]; then
        module unload pocl/6.0
    else
        module unload opencl/${DEVICE}
    fi

    # if cpu or pocl, skip level zero
    if [ "$DEVICE" == "cpu" ] || [ "$DEVICE" == "pocl" ]; then
        return
    fi

    # Level Zero benchmark
    # module load level-zero/${DEVICE}
    # export CHIP_BE=level0
    # rm -f ${RUNTIME}-l0BE.csv
    # ./scripts/autohecbench.py --warmup ${WARMPUP} --repeat ${REPEATS} \
    #     -o ${RUNTIME}-l0BE.csv hip 2>&1 | \
    #     tee ${RUNTIME}-l0_benchmark.log
    # module unload level-zero/${DEVICE}
}

function run_sycl_benchmarks() {
    RUNTIME=$1
    DEVICE=$2
    RUNTIME=${DEVICE}-sycl-${RUNTIME}
    module load oneapi/2024.2.2
    sycl-ls

    if [ "$DEVICE" == "dgpu" ]; then
        export ONEAPI_DEVICE_SELECTOR="opencl:0"
        echo "ONEAPI_DEVICE_SELECTOR: ${ONEAPI_DEVICE_SELECTOR}"
        #export ONEAPI_DEVICE_SELECTOR="level_zero:0"
    elif [ "$DEVICE" == "igpu" ]; then
        export ONEAPI_DEVICE_SELECTOR="opencl:1"
        echo "ONEAPI_DEVICE_SELECTOR: ${ONEAPI_DEVICE_SELECTOR}"
        #export ONEAPI_DEVICE_SELECTOR="level_zero:1"
    elif [ "$DEVICE" == "cpu" ]; then
        export ONEAPI_DEVICE_SELECTOR="opencl:2"
        echo "ONEAPI_DEVICE_SELECTOR: ${ONEAPI_DEVICE_SELECTOR}"
        #export ONEAPI_DEVICE_SELECTOR="level_zero:2"
    elif [ "$DEVICE" == "pocl" ]; then
        return
    fi

    rm -f ${RUNTIME}-oclBE.csv
    ./scripts/autohecbench.py -c --warmup ${WARMPUP} --repeat ${REPEATS} --extra-compile-flags="-fno-sycl-instrument-device-code" -o ${RUNTIME}-oclBE.csv --sycl-type opencl-cpu sycl 2>&1 | \
        tee ${RUNTIME}-ocl_benchmark.log

    # rm -f ${RUNTIME}-sycl-l0BE.csv
    # ./scripts/autohecbench.py -c --warmup ${WARMPUP} --repeat ${REPEATS} --extra-compile-flags="-fno-sycl-instrument-device-code" -o ${RUNTIME}-l0BE.csv --sycl-type opencl sycl 2>&1 | \
    #     tee ${RUNTIME}-sycl-l0_benchmark.log

    module unload oneapi/2024.2.2
}


function run_opencl_benchmarks() {
    RUNTIME=$1
    DEVICE=$2
    RUNTIME=${DEVICE}-opencl-${RUNTIME}
    module load oneapi/2024.2.2
    sycl-ls

    module load opencl/cpu  
    rm -f ${RUNTIME}-oclBE.csv
    ./scripts/autohecbench.py -c --warmup ${WARMPUP} --repeat ${REPEATS} -o ${RUNTIME}-oclBE.csv opencl 2>&1 | \
        tee ${RUNTIME}-ocl_benchmark.log
    module unload opencl/cpu
    module unload oneapi/2024.2.2
}


##################################### Run dGPU benchmarks #####################################
export DEVICE="dgpu"
export CHIP_JIT_FLAGS=""
export SYCL_PROGRAM_COMPILE_OPTIONS=""

# run_sycl_benchmarks "" dgpu
# run_sycl_benchmarks "" igpu
# run_sycl_benchmarks "" cpu
run_opencl_benchmarks "" cpu
exit 0

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0" ${DEVICE}
# module unload HIP/chipStar/v1.2.0

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "" ${DEVICE}
# module unload oneapi/2024.2.2


export CHIP_JIT_FLAGS="-cl-fast-relaxed-math"
export SYCL_PROGRAM_COMPILE_OPTIONS="-cl-fast-relaxed-math"

# Test v1.2.1
module load HIP/chipStar/v1.2.1
run_chipStar_benchmarks "v1.2.1-fast-relaxed-math" ${DEVICE}
module unload HIP/chipStar/v1.2.1

#RUN SYCL BENCHMARKS
module load oneapi/2024.2.2
run_sycl_benchmarks "fast-relaxed-math" ${DEVICE}
module unload oneapi/2024.2.2

# Test v1.1.0
module load HIP/chipStar/v1.1.0
run_chipStar_benchmarks "v1.1.0-fast-relaxed-math" ${DEVICE}
module unload HIP/chipStar/v1.1.0

# Test v1.2.0
module load HIP/chipStar/v1.2.0
run_chipStar_benchmarks "v1.2.0-fast-relaxed-math" ${DEVICE}
module unload HIP/chipStar/v1.2.0


# ##################################### Run iGPU benchmarks #####################################
# export DEVICE="igpu"
# export CHIP_JIT_FLAGS=""
# export SYCL_PROGRAM_COMPILE_OPTIONS=""

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0" ${DEVICE}
# module unload HIP/chipStar/v1.2.0

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "" ${DEVICE}
# module unload oneapi/2024.2.2


# export CHIP_JIT_FLAGS="-cl-fast-relaxed-math"
# export SYCL_PROGRAM_COMPILE_OPTIONS="-cl-fast-relaxed-math"

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "fast-relaxed-math" ${DEVICE}
# module unload oneapi/2024.2.2

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.0




# ##################################### Run CPU benchmarks #####################################
# export DEVICE="cpu"
# export CHIP_JIT_FLAGS=""
# export SYCL_PROGRAM_COMPILE_OPTIONS=""

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0" ${DEVICE}
# module unload HIP/chipStar/v1.2.0

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "" ${DEVICE}
# module unload oneapi/2024.2.2


# export CHIP_JIT_FLAGS="-cl-fast-relaxed-math"
# export SYCL_PROGRAM_COMPILE_OPTIONS="-cl-fast-relaxed-math"

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "fast-relaxed-math" ${DEVICE}
# module unload oneapi/2024.2.2

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.0



# ##################################### Run PoCL benchmarks #####################################
# export DEVICE="pocl"
# export CHIP_JIT_FLAGS=""
# export SYCL_PROGRAM_COMPILE_OPTIONS=""

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0" ${DEVICE}
# module unload HIP/chipStar/v1.2.0

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "" ${DEVICE}
# module unload oneapi/2024.2.2


# export CHIP_JIT_FLAGS="-cl-fast-relaxed-math"
# export SYCL_PROGRAM_COMPILE_OPTIONS="-cl-fast-relaxed-math"

# # Test v1.2.1
# module load HIP/chipStar/v1.2.1
# run_chipStar_benchmarks "v1.2.1-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.1

# # RUN SYCL BENCHMARKS
# module load oneapi/2024.2.2
# run_sycl_benchmarks "fast-relaxed-math" ${DEVICE}
# module unload oneapi/2024.2.2

# # Test v1.1.0
# module load HIP/chipStar/v1.1.0
# run_chipStar_benchmarks "v1.1.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.1.0

# # Test v1.2.0
# module load HIP/chipStar/v1.2.0
# run_chipStar_benchmarks "v1.2.0-fast-relaxed-math" ${DEVICE}
# module unload HIP/chipStar/v1.2.0