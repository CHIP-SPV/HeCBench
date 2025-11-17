# Weak Scaling Results: chipStar vs SYCL

This directory contains the data and visualization for weak scaling comparison between chipStar (HIP) and SYCL implementations across HeCBench benchmarks.

## Files

### CSV Data Files
- `chipStar-speedup-vs-sycl-wallclock-1x-chipstar.csv` - chipStar timing data for 1x problem size
- `chipStar-speedup-vs-sycl-wallclock-5x-chipstar.csv` - chipStar timing data for 5x problem size
- `chipStar-speedup-vs-sycl-wallclock-1x-sycl.csv` - SYCL timing data for 1x problem size
- `chipStar-speedup-vs-sycl-wallclock-5x-sycl.csv` - SYCL timing data for 5x problem size

Each CSV file contains benchmark timing data with columns: benchmark_name, min_time, mean_time, stddev, coefficient_of_variation.

### Visualization
- `chipstar_vs_sycl_combined.pdf` - Combined bar chart showing speedup ratios for both 1x and 5x problem sizes

## Benchmarks

The analysis includes 9 HeCBench benchmarks where chipStar outperforms SYCL:
- bscan
- gaussian
- hogbom
- mrc
- nlll
- overlay
- scan2
- sssp
- urng

## Results Summary

**1x Problem Size:**
- Geometric mean speedup: 1.31x
- Speedup range: 1.14x (sssp) to 2.20x (gaussian)

**5x Problem Size:**
- Geometric mean speedup: 1.17x
- Speedup range: 1.02x (gaussian) to 1.40x (scan2)

## Generating the Plot

To regenerate the combined plot:

```bash
python3 scripts/plot.py -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel \
  -t "HecBench tests where chipStar outperforms SYCL" \
  -c chipStar-speedup-vs-sycl-wallclock-1x-chipstar.csv -b chipStar-speedup-vs-sycl-wallclock-1x-sycl.csv \
  --input-file-compared-2 chipStar-speedup-vs-sycl-wallclock-5x-chipstar.csv \
  --input-file-baseline-2 chipStar-speedup-vs-sycl-wallclock-5x-sycl.csv \
  --group-label-1 "1x" --group-label-2 "5x" \
  -o chipstar_vs_sycl_combined.pdf
```

