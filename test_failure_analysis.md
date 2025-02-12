# HeCBench Test Failure Analysis

This document summarizes the runtime errors encountered in the HeCBench test suite across different configurations.

## Runtime Errors by Configuration

### SYCL Configurations
| Configuration | Failed Tests |
|--------------|--------------|
| SYCL-dgpu-fast-relaxed-math-sycl-ocl | hybridsort-sycl, vanGenuchten-sycl |
| SYCL-dgpu-fast-relaxed-math-sycl-l0 | vanGenuchten-sycl |
| SYCL-dgpu-sycl-ocl | hybridsort-sycl |

### ChipStar Configurations
| Configuration | Failed Tests |
|--------------|--------------|
| chipstar-v1.2.1-dgpu-fast-relaxed-math-ocl | eigenvalue-hip, pnpoly-hip, vanGenuchten-hip |
| chipstar-v1.2.1-dgpu-fast-relaxed-math-l0 | eigenvalue-hip, entropy-hip, pnpoly-hip, vanGenuchten-hip |
| chipstar-v1.2.0-dgpu-fast-relaxed-math-l0 | entropy-hip, keogh-hip, minkowski-hip, pnpoly-hip, vanGenuchten-hip |
| chipstar-v1.1.0-dgpu-fast-relaxed-math-l0 | entropy-hip, keogh-hip, minkowski-hip, pnpoly-hip, vanGenuchten-hip |

## Analysis

1. Common failures across configurations:
   - vanGenuchten test fails in both SYCL and ChipStar implementations
   - hybridsort fails in SYCL OCL configurations
   - pnpoly-hip consistently fails across ChipStar configurations

2. Configuration-specific observations:
   - L0 configurations tend to have more failures than OCL configurations
   - ChipStar configurations show more failures than SYCL configurations
   - Earlier versions of ChipStar (v1.1.0, v1.2.0) show more failures than v1.2.1

### Pre-emptively Skipped Tests
Note: For reference, there are also tests that are pre-emptively skipped due to known issues (doubles not supported, memory constraints, etc). These are not included in this analysis as they are not actual runtime failures. 