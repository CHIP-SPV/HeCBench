cmake_minimum_required(VERSION 3.21)

# chipStar compiles HIP .cpp sources through hipcc as ordinary C++; enabling the
# first-class HIP language pulls in ROCm-only flags (-amdgpu-*, /opt/rocm) that
# chipStar's clang rejects, so keep this a CXX project and use hipcc as CXX.
project(set_intersection_eval CXX)

list(APPEND CMAKE_PREFIX_PATH /opt/rocm/hip /opt/rocm)
find_package(hip)

# hipBLAS discovery.
# ROCm ships a working CMake package that exports roc::hipblas. The chipStar /
# H4I hipBLAS package in this install has a broken hipblasConfig.cmake (it
# include()s a non-existent hipblas.cmake and aborts configuration), so we only
# use find_package(hipblas) when its config is self-consistent and otherwise
# locate the library and header directly.
set(HIPBLAS_TARGET "")
find_path(_hipblas_cmake_dir NAMES hipblasConfig.cmake
    HINTS ${CMAKE_PREFIX_PATH} ENV HIP_PATH /opt/rocm
    PATH_SUFFIXES lib/cmake/hipblas lib64/cmake/hipblas)
if(_hipblas_cmake_dir AND EXISTS "${_hipblas_cmake_dir}/hipblas.cmake")
    find_package(hipblas)
    if(TARGET roc::hipblas)
        set(HIPBLAS_TARGET roc::hipblas)
    elseif(TARGET H4I::hipblas)
        set(HIPBLAS_TARGET H4I::hipblas)
    endif()
endif()
if(NOT HIPBLAS_TARGET)
    find_library(HIPBLAS_LIBRARY NAMES hipblas
        HINTS ${CMAKE_PREFIX_PATH} ENV HIP_PATH /opt/rocm
        PATH_SUFFIXES lib lib64)
    find_path(HIPBLAS_INCLUDE_DIR NAMES hipblas.h
        HINTS ${CMAKE_PREFIX_PATH} ENV HIP_PATH /opt/rocm
        PATH_SUFFIXES include)
    if(NOT HIPBLAS_LIBRARY OR NOT HIPBLAS_INCLUDE_DIR)
        message(FATAL_ERROR "hipBLAS not found (lib=${HIPBLAS_LIBRARY} inc=${HIPBLAS_INCLUDE_DIR})")
    endif()
    add_library(si_hipblas INTERFACE)
    target_link_libraries(si_hipblas INTERFACE ${HIPBLAS_LIBRARY})
    target_include_directories(si_hipblas INTERFACE ${HIPBLAS_INCLUDE_DIR})
    set(HIPBLAS_TARGET si_hipblas)
endif()

set(CMAKE_CXX_STANDARD 14)

include(FetchContent)

# CXX options library
FetchContent_Declare(
        cxxopts
        GIT_REPOSITORY https://github.com/jarro2783/cxxopts.git
        GIT_TAG        v2.2.1
)
FetchContent_MakeAvailable(cxxopts)
# Adds cxxopts

# Formatting library
FetchContent_Declare(
        fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git
        GIT_TAG        7.1.2
)
FetchContent_MakeAvailable(fmt)
# Adds fmt::fmt

# Zipf header library
FetchContent_Declare(
        zipf
        GIT_REPOSITORY https://github.com/llersch/cpp_random_distributions.git
        GIT_TAG        "6ae38ecf5dbeb1150b80ecf051cb43cb88ba697a"
)
FetchContent_MakeAvailable(zipf)

# Progress bar library
FetchContent_Declare(
        progressbar
        GIT_REPOSITORY https://github.com/prakhar1989/progress-cpp.git
        GIT_TAG        "7bfba0d22d19c41323aa35541618b6ebec9d737c"
)
FetchContent_MakeAvailable(progressbar)


# Generate dataset binary
add_executable(generate_dataset src/generate_dataset.cpp)
target_include_directories(generate_dataset PRIVATE include ${zipf_SOURCE_DIR} ${progressbar_SOURCE_DIR}/include/progresscpp/)
target_link_libraries(generate_dataset PRIVATE cxxopts fmt::fmt)

# Optimized binary search binary using matrix multiplication
add_executable(main src/main.cpp)
target_link_libraries(main PRIVATE cxxopts fmt::fmt hip::host hip::device ${HIPBLAS_TARGET})
target_include_directories(main PRIVATE include)
target_compile_options(main PRIVATE -m64)
