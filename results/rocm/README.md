# Radeon PRO VII Performance Comparison

This directory contains performance comparison data and visualizations between ROCm and chipStar/rusticl/radeonsi implementations on AMD Radeon PRO VII GPU.

## Files

### Dataset (32 benchmarks)
- `rocm-baseline.csv` - ROCm timing data
- `chipstar-compared.csv` - chipStar/rusticl/radeonsi timing data
- `rocm-vs-chipstar.pdf` - Bar chart showing performance ratios for all 32 benchmarks

## Results Summary

**Full Dataset (32 benchmarks):**
- Geometric mean speedup: 0.75x
- Speedup range: 0.15x (murmurhash3 - ROCm slower) to 2.15x (pnpoly - ROCm faster)
- Benchmarks with speedup < 1.0: 19 benchmarks showing ROCm slower than chipStar/rusticl/radeonsi
- Benchmarks with speedup = 1.0: 1 benchmark showing equal performance (maxpool3d)
- Benchmarks with speedup > 1.0: 12 benchmarks showing ROCm faster

## Configuration

- **Platform:** AMD Radeon PRO VII GPU
- **ROCm:** AMD ROCm implementation
- **chipStar/rusticl/radeonsi:** Open-source OpenCL implementation stack
- **Benchmark suite:** HeCBench

## Generating the Plot

To regenerate the plot:

```bash
python3 scripts/plot.py -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel --log-scale \
  -t "Radeon PRO VII ROCm speedup over chipStar/rusticl/radeonsi" \
  -c rocm-baseline.csv -b chipstar-compared.csv \
  -o rocm-vs-chipstar.pdf
```

## CSV Format

Each CSV file contains benchmark timing data with the following columns:
- `benchmark_name`: Benchmark name with backend suffix (-hip)
- `min_time`: Minimum execution time (seconds)
- `mean_time`: Mean execution time (seconds)
- `stddev`: Standard deviation
- `coefficient_of_variation`: Coefficient of variation

## Notes

- Speedup is calculated as: `chipStar_time / ROCm_time`
- Values > 1.0 indicate ROCm is faster
- Values < 1.0 indicate chipStar/rusticl/radeonsi is faster
- The geometric mean of 0.75 indicates that, on average, ROCm performs 25% slower than chipStar/rusticl/radeonsi across the benchmark suite
- All plots include accessibility features: colorblind-friendly colors, patterns, and high contrast

