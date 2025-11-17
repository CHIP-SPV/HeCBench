# chipStar vs SYCL Performance Comparison

This directory contains performance comparison data and visualizations between chipStar (HIP) and SYCL implementations on Intel Arc770 GPU.

## Files

### Full Dataset (53 benchmarks)
- `chipStar(jitopt).csv` - chipStar timing data with JIT optimization
- `sycl(fp-fast+jitopt).csv` - SYCL timing data with fast floating-point model and JIT optimization
- `chipStar-vs-sycl-speedup.pdf` - Bar chart showing speedup ratios for all 53 benchmarks

### Truncated Dataset (22 benchmarks)
- `chipStar(jitopt)-truncated.csv` - chipStar timing data (excluding benchmarks with speedup 0.95-1.05)
- `sycl(fp-fast+jitopt)-truncated.csv` - SYCL timing data (excluding benchmarks with speedup 0.95-1.05)
- `chipStar-vs-sycl-speedup-truncated.pdf` - Bar chart showing speedup ratios excluding near-equal performance benchmarks

The truncated version excludes benchmarks where the speedup ratio is between 0.95 and 1.05, focusing on benchmarks with meaningful performance differences.

## Results Summary

**Full Dataset (53 benchmarks):**
- Geometric mean speedup: 1.07x
- Speedup range: 0.51x (adam - slowdown) to 9.66x (gaussian - outlier)
- Benchmarks with speedup < 1.0: 13 benchmarks showing slowdown
- Benchmarks with speedup = 1.0: 10 benchmarks showing equal performance
- Benchmarks with speedup > 1.0: 30 benchmarks showing speedup

**Truncated Dataset (22 benchmarks):**
- Excludes 31 benchmarks with speedup ratios between 0.95 and 1.05
- Focuses on benchmarks with significant performance differences (>5% difference)

## Configuration

- **Platform:** Intel Arc770 GPU
- **chipStar version:** v1.2.1 with JIT optimization
- **SYCL configuration:** Fast floating-point model (-fp-model=fast) with JIT optimization
- **Benchmark suite:** HeCBench

## Generating the Plots

To regenerate the full plot:

```bash
python3 scripts/plot.py -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
  -t "Arc770 chipStar-v1.2.1+JITopt speedup over SYCL(-fp-model=fast)+JITopt" \
  -c chipStar\(jitopt\).csv -b sycl\(fp-fast+jitopt\).csv \
  -o chipStar-vs-sycl-speedup.pdf
```

To regenerate the truncated plot:

```bash
python3 scripts/plot.py -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
  -t "Arc770 chipStar-v1.2.1+JITopt speedup over SYCL(-fp-model=fast)+JITopt (excluding near-equal performance)" \
  -c chipStar\(jitopt\)-truncated.csv -b sycl\(fp-fast+jitopt\)-truncated.csv \
  -o chipStar-vs-sycl-speedup-truncated.pdf
```

## CSV Format

Each CSV file contains benchmark timing data with the following columns:
- `benchmark_name`: Benchmark name with backend suffix (-hip or -sycl)
- `min_time`: Minimum execution time (seconds)
- `mean_time`: Mean execution time (seconds)
- `stddev`: Standard deviation
- `coefficient_of_variation`: Coefficient of variation

## Notes

- Speedup is calculated as: `SYCL_time / chipStar_time`
- Values > 1.0 indicate chipStar is faster
- Values < 1.0 indicate SYCL is faster
- The gaussian benchmark shows a significant outlier (9.66x speedup)
- All plots include accessibility features: colorblind-friendly colors, patterns, and high contrast

