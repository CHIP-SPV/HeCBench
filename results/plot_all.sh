#!/bin/bash

# Script to generate all plots and place them in ./figures directory
# Run from the results directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
FIGURES_DIR="${SCRIPT_DIR}/figures"

# Create figures directory if it doesn't exist
mkdir -p "${FIGURES_DIR}"

echo "Generating all plots..."

# 1. chipStar-vs-sycl: Full plot
echo "Generating chipStar-vs-sycl full plot..."
# -t "Arc770, chipStar+JITopt speedup over SYCL(-fp-model=fast)+JITopt" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/chipStar-vs-sycl/chipStar(jitopt).csv" \
  -b "${SCRIPT_DIR}/chipStar-vs-sycl/sycl(fp-fast+jitopt).csv" \
  -o "${FIGURES_DIR}/chipStar-vs-sycl-speedup.pdf"

# 2. chipStar-vs-sycl: Truncated plot
echo "Generating chipStar-vs-sycl truncated plot..."
# -t "Arc770 chipStar+JITopt speedup over SYCL(-fp-model=fast)+JITopt (excluding near-equal performance)" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/chipStar-vs-sycl/chipStar(jitopt)-truncated.csv" \
  -b "${SCRIPT_DIR}/chipStar-vs-sycl/sycl(fp-fast+jitopt)-truncated.csv" \
  -o "${FIGURES_DIR}/chipStar-vs-sycl-speedup-truncated.pdf"

# 3. ARM plot
echo "Generating ARM plot..."
# -t "ARM, chipStar GPU OCL speedup over CPU PoCL" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/arm/gpu-baseline.csv" \
  -b "${SCRIPT_DIR}/arm/cpu-compared.csv" \
  -o "${FIGURES_DIR}/arm.pdf"

# 4. Radeon PRO VII (rocm) plot
echo "Generating Radeon PRO VII plot..."
# -t "Radeon PRO VII, chipStar/rusticl/radeonsi speedup over ROCm" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/rocm/rocm.csv" \
  -b "${SCRIPT_DIR}/rocm/chipstar.csv" \
  -o "${FIGURES_DIR}/rocm-vs-chipstar.pdf"

# 5. Weak scaling (scaled-wallclock) combined plot
echo "Generating weak scaling combined plot..."
# -t "chipStar speedup over SYCL, scaling wallclock time" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/scaled-wallclock/chipStar-speedup-vs-sycl-wallclock-1x-chipstar.csv" \
  -b "${SCRIPT_DIR}/scaled-wallclock/chipStar-speedup-vs-sycl-wallclock-1x-sycl.csv" \
  --input-file-compared-2 "${SCRIPT_DIR}/scaled-wallclock/chipStar-speedup-vs-sycl-wallclock-5x-chipstar.csv" \
  --input-file-baseline-2 "${SCRIPT_DIR}/scaled-wallclock/chipStar-speedup-vs-sycl-wallclock-5x-sycl.csv" \
  --group-label-1 "1x" --group-label-2 "5x" \
  -o "${FIGURES_DIR}/chipStar-vs-sycl-scaled.pdf"

# 6. RTX 3060 CUDA vs rusticl: Full plot
echo "Generating RTX 3060 CUDA vs rusticl full plot..."
# -t "RTX 3060,  chipStar/rusticl/zink speedup over CUDA" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/cuda/cuda-baseline.csv" \
  -b "${SCRIPT_DIR}/cuda/rusticl-compared.csv" \
  -o "${FIGURES_DIR}/cuda-vs-rusticl.pdf"

# 7. RTX 3060 CUDA vs rusticl: Truncated plot
echo "Generating RTX 3060 CUDA vs rusticl truncated plot..."
# -t "RTX 3060, chipStar/rusticl/zink speedup over CUDA (excluding near-equal performance)" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/cuda/cuda-baseline-truncated.csv" \
  -b "${SCRIPT_DIR}/cuda/rusticl-compared-truncated.csv" \
  -o "${FIGURES_DIR}/cuda-vs-rusticl-truncated.pdf"

# 8. RISC-V GPU vs CPU plot
echo "Generating RISC-V GPU vs CPU plot..."
# -t "PowerVR BXE-4-32G GPU speedup over StarFive JH7110 CPU" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/riscv/gpu-baseline.csv" \
  -b "${SCRIPT_DIR}/riscv/cpu-compared.csv" \
  -o "${FIGURES_DIR}/riscv.pdf"

# 9. Intel UHD 770 iGPU vs CPU plot
echo "Generating Intel UHD 770 iGPU vs CPU plot..."
# -t "Intel UHD 770, chipStar speedup over OpenCL CPU" \
python3 "${BASE_DIR}/scripts/plot.py" -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -c "${SCRIPT_DIR}/igpu-vs-cpu/chipstar-baseline.csv" \
  -b "${SCRIPT_DIR}/igpu-vs-cpu/cpu-compared.csv" \
  -o "${FIGURES_DIR}/igpu-vs-cpu.pdf"

echo "All plots generated successfully in ${FIGURES_DIR}/"
