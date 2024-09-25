import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

outlier_threshold = 0.5

def read_csv(filename, suffix):
    df = pd.read_csv(filename, header=None, names=['benchmark', 'min', 'mean', 'std', 'cv'])
    df['benchmark'] = df['benchmark'].str.replace(suffix, '')
    return df.set_index('benchmark')

def geometric_mean(series):
    return np.exp(np.mean(np.log(series)))

def geometric_mean_without_outliers(series, threshold=outlier_threshold):
    log_series = np.log(series)
    return np.exp(np.mean(log_series[(log_series > np.log(1-threshold)) & (log_series < np.log(1+threshold))]))

sycl_df = read_csv('test_FULL_4_x_sycl_strict_oclBE.csv', '-sycl')
hip_ocl_df = read_csv('test_FULL_4_x_hip_strict_oclBE.csv', '-hip')
hip_l0_df = read_csv('test_FULL_4_x_hip_strict_l0BE.csv', '-hip')

common_benchmarks = sycl_df.index.intersection(hip_ocl_df.index).intersection(hip_l0_df.index)

sycl_df = sycl_df.loc[common_benchmarks]
hip_ocl_df = hip_ocl_df.loc[common_benchmarks]
hip_l0_df = hip_l0_df.loc[common_benchmarks]

df = pd.DataFrame({
    'Benchmark': common_benchmarks,
    'SYCL': sycl_df['mean'],
    'HIP (OCL)': hip_ocl_df['mean'],
    'HIP (L0)': hip_l0_df['mean']
})

df['OCL_Speedup'] = df['SYCL'] / df['HIP (OCL)']
df['L0_Speedup'] = df['SYCL'] / df['HIP (L0)']
df['L0_vs_OCL_Speedup'] = df['HIP (OCL)'] / df['HIP (L0)']

ocl_geo_mean = geometric_mean(df['OCL_Speedup'])
l0_geo_mean = geometric_mean(df['L0_Speedup'])
l0_vs_ocl_geo_mean = geometric_mean(df['L0_vs_OCL_Speedup'])

ocl_geo_mean_no_outliers = geometric_mean_without_outliers(df['OCL_Speedup'])
l0_geo_mean_no_outliers = geometric_mean_without_outliers(df['L0_Speedup'])
l0_vs_ocl_geo_mean_no_outliers = geometric_mean_without_outliers(df['L0_vs_OCL_Speedup'])

df = df.sort_values('SYCL', ascending=False)

plt.figure(figsize=(20, 12))
sns.set(style="whitegrid")

x = range(len(df))
width = 0.35

plt.bar(x, df['OCL_Speedup'], width, label='HIP (OCL)', color='skyblue')
plt.bar([i + width for i in x], df['L0_Speedup'], width, label='HIP (L0)', color='orange')

for i, (ocl, l0) in enumerate(zip(df['OCL_Speedup'], df['L0_Speedup'])):
    plt.text(i, ocl, f'{ocl:.2f}x', ha='center', va='bottom', rotation=90)
    plt.text(i + width, l0, f'{l0:.2f}x', ha='center', va='bottom', rotation=90)

plt.xlabel('Benchmarks', fontsize=12)
plt.ylabel('Speedup relative to SYCL (higher is better)', fontsize=12)
plt.title('chipStar Speedup Relative to SYCL', fontsize=16)
plt.xticks([i + width/2 for i in x], df['Benchmark'], rotation=90, ha='right')
plt.legend()

plt.axhline(y=1, color='r', linestyle='--', label='SYCL Baseline')

plt.yscale('log')

geomean_text = (
    f'Outlier threshold: {outlier_threshold}\n'
    f'Geo Mean Speedup (with/without outliers):\n'
    f'OCL: {ocl_geo_mean:.2f}x / {ocl_geo_mean_no_outliers:.2f}x\n'
    f'L0: {l0_geo_mean:.2f}x / {l0_geo_mean_no_outliers:.2f}x\n'
    f'L0 vs OCL: {l0_vs_ocl_geo_mean:.2f}x / {l0_vs_ocl_geo_mean_no_outliers:.2f}x'
)

plt.text(0.95, 0.95, geomean_text, 
         transform=plt.gca().transAxes, ha='right', va='top', 
         bbox=dict(facecolor='white', alpha=0.5, edgecolor='black'))

plt.tight_layout()
plt.savefig('benchmark_comparison_bar_log.png', dpi=300)
plt.close()

print(f"Plot saved as 'benchmark_comparison_bar_log.png'")
print(f"Number of common benchmarks: {len(common_benchmarks)}")