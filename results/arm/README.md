# ARM Performance Comparison

This directory contains performance comparison data and visualizations between GPU OpenCL (OCL) using chipStar-v1.2.1+caching and CPU PoCL implementations on ARM platform.

## Files

### Dataset (40 benchmarks)
- `gpu-baseline.csv` - GPU OCL timing data (chipStar-v1.2.1+caching)
- `cpu-compared.csv` - CPU PoCL timing data
- `arm.pdf` - Bar chart showing speedup ratios for all 40 benchmarks

## Results Summary

**Full Dataset (40 benchmarks):**
- Geometric mean speedup: 1.40x
- Speedup range: 0.13x (perplexity - GPU slower) to 18.72x (hybridsort - GPU faster)
- Benchmarks with speedup < 1.0: 17 benchmarks showing GPU slower than CPU
- Benchmarks with speedup = 1.0: 0 benchmarks showing equal performance
- Benchmarks with speedup > 1.0: 23 benchmarks showing GPU faster

## Configuration

- **Platform:** ARM
- **GPU Implementation:** chipStar-v1.2.1 with caching, OpenCL backend
- **CPU Implementation:** PoCL (Portable Computing Language)
- **Benchmark suite:** HeCBench

## Generating the Plot

To regenerate the plot:

```bash
python3 scripts/plot.py -v -r --color '#b7cce9' -m 0.0 -s seaborn-v0_8-pastel \
  -t "ARM chipStar-v1.2.1+caching GPU OCL speedup over CPU PoCL" \
  -c gpu-baseline.csv -b cpu-compared.csv \
  -o arm.pdf
```

## CSV Format

Each CSV file contains benchmark timing data with the following columns:
- `benchmark_name`: Benchmark name with backend suffix (-hip)
- `min_time`: Minimum execution time (seconds)
- `mean_time`: Mean execution time (seconds)
- `stddev`: Standard deviation
- `coefficient_of_variation`: Coefficient of variation

## Notes

- Speedup is calculated as: `GPU_time / CPU_time`
- Values > 1.0 indicate GPU is faster
- Values < 1.0 indicate CPU is faster
- The geometric mean of 1.40 indicates that, on average, GPU performs 40% faster than CPU across the benchmark suite
- The hybridsort benchmark shows the highest speedup at 18.72x
- All plots include accessibility features: colorblind-friendly colors, patterns, and high contrast

