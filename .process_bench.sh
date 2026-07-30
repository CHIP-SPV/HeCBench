#!/usr/bin/env bash
# Usage: process_bench.sh <bench> <variant>   variant=hip|sycl
set -u
. /tmp/hecbench-env.sh >/dev/null 2>&1

bench="$1"
variant="$2"
dir="/space/pvelesko/HecBench/individual-fixes/${bench}-${variant}"
log="/tmp/${bench}-${variant}.log"
: > "$log"

if [ ! -d "$dir" ]; then
  echo "MISSING_DIR"
  exit 0
fi
cd "$dir"

if [ ! -f Makefile ]; then
  echo "NO_MAKEFILE"
  exit 0
fi

make clean >/dev/null 2>&1 || true

if [ "$variant" = "hip" ]; then
  timeout 240 make CC=hipcc CXX=hipcc -j > "$log" 2>&1
else
  timeout 240 make GPU=yes CC=icpx CXX=icpx CUDA=no HIP=no -j > "$log" 2>&1
fi
build_rc=$?

if [ $build_rc -ne 0 ] || [ ! -x ./main ]; then
  echo "BUILD_FAIL:$build_rc"
  exit 0
fi

if ! grep -qE '^smoke:' Makefile; then
  echo "NO_SMOKE"
  exit 0
fi

if [ "$variant" = "hip" ]; then
  timeout 60 make smoke > "${log}.l0" 2>&1
  l0_rc=$?
  CHIP_BE=opencl timeout 60 make smoke > "${log}.ocl" 2>&1
  ocl_rc=$?
  echo "HIP:l0=$l0_rc:ocl=$ocl_rc"
else
  timeout 60 make smoke > "${log}.run" 2>&1
  rc=$?
  echo "SYCL:$rc"
fi
