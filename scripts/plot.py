#!/usr/bin/python3

# example for GPU vs CPU comparison:
# ./plot.py -g -s seaborn-v0_8-bright -t "HeCBench, GPU vs CPU speedup" -c hecbench_GPU.csv -b hecbench_CPU.csv

#### CONFIG USED BY CHIPSTAR PAPER:


# ./plot.py -v -r --color '#b7cce9' -m 0.8 -s seaborn-v0_8-pastel -t "HeCBench, Intel Arc750, HIP vs SYCL speedup" -c test_20_strict_hip_oclBE_arc_after.csv -b test_20_strict_sycl_oclBE_arc_after.csv -o hecbench_intel_arc750_hip_vs_sycl.pdf

# ./plot.py -v -r --color '#b7cce9' -s seaborn-v0_8-pastel -t "PowerVR BXE-4-32 GPU vs StarFive JH7110 CPU" -b CPU_3_x_with_abort_strictmath.csv -c GPU_3_x_with_abort_strictmath.csv -o hecbench_visionfive2_gpu_vs_cpu.pdf


from optparse import OptionParser
import matplotlib.pyplot as plt
import csv
import numpy as np

import math

#### CONFIG
FONT_SIZE_TICKS = 20.28
FONT_SIZE_AXIS_LABELS = 23.66
FONT_SIZE_TITLE = 16
FONT_SIZE_BAR_LABELS = 16.9
#### END CONFIG
outlier_factor = 30

def geomean(xs):
        return math.exp(math.fsum(math.log(x) for x in xs) / len(xs))

parser = OptionParser(description="Takes as input two CSV files produced by HeCBench's runner script (autohecbench.py), and produces a matplotlib chart with data from one CSV normalized to other CSV. Note that since hecbench.py produces CSV with timings, the input files are internally swapped to produce relative speedups (A = 3x faster B) rather than relative timing (A = 0.33 of B's time).")
parser.add_option("-b", "--input-file-baseline", dest="input_base",
                  help="CSV file with baseline data", metavar="PATH")
parser.add_option("-c", "--input-file-compared", dest="input_comp",
                  help="CSV file with compared data", metavar="PATH")
parser.add_option("--input-file-baseline-2", dest="input_base_2", default=None,
                  help="CSV file with baseline data for second dataset (for grouped bars)", metavar="PATH")
parser.add_option("--input-file-compared-2", dest="input_comp_2", default=None,
                  help="CSV file with compared data for second dataset (for grouped bars)", metavar="PATH")
parser.add_option("--group-label-1", dest="group_label_1", default="1x",
                  help="Label for first group of bars", metavar="STRING")
parser.add_option("--group-label-2", dest="group_label_2", default="5x",
                  help="Label for second group of bars", metavar="STRING")
parser.add_option("-o", "--output-file", dest="output", default=None, metavar="PATH",
                  help="if specified, write output to this file (SVG,PDF,..) otherwise show chart on screen")

parser.add_option("-e", "--errorbars", dest="errbars", default=False, action="store_true",
                  help="draw error bars, default = don't draw")

parser.add_option("-g", "--geomean", dest="geomean", default=False, action="store_true",
                  help="draw geometric mean, default = don't draw")

parser.add_option("--color", dest="color", default=None,
                  help="Adjust chart bar color (optional, default = None)", metavar="STRING")

parser.add_option("--ecolor", dest="ecolor", default=None,
                  help="Adjust chart bar error color (optional, default = None)", metavar="STRING")


parser.add_option("-m", "--bottom", dest="bottom", default=0.0,  type="float",
                  help="Adjust chart bottom (optional, default = 0.0)", metavar="FLOAT")

parser.add_option("-r", "--refline", dest="refline", default=False, action="store_true",
                  help="draw dotted line @ y=1.0, default = don't draw")

parser.add_option("-s", "--style", dest="style", default=None,
                  help="chart style (optional, default = None)", metavar="STRING")

parser.add_option("-t", "--title", dest="title", default=None,
                  help="chart title (optional)", metavar="TITLE")

parser.add_option("-x", "--xlabel", dest="xlabel", default=None,
                  help="X axis label (optional)", metavar="XLABEL")
parser.add_option("-y", "--ylabel", dest="ylabel", default=None,
                  help="Y axis label (optional)", metavar="YLABEL")
parser.add_option("-z", "--zlabel", dest="zlabel", default=None,
                  help="Label embedded into chart (optional)", metavar="ZLABEL")

parser.add_option("-v", "--bar-values", dest="bar_values", default=True, action="store_false",
                  help="do not draw values of each bar, default = draw")
parser.add_option("--log-scale", dest="log_scale", default=True, action="store_false",
                  help="plot y-axis on a logarithmic scale, default = True")

parser.add_option("--bar-labels", dest="bar_labels", default=True, action="store_false",
                  help="place speedup labels at the top of each bar, default = True")

(options, args) = parser.parse_args()
if (not options.input_comp) or (not options.input_base):
	parser.error("both input files must be specified")

has_second_dataset = (options.input_base_2 is not None) and (options.input_comp_2 is not None)
if (options.input_base_2 is None) != (options.input_comp_2 is None):
	parser.error("both second dataset input files must be specified together")

Baseline = {}
Compared = {}

# baseline and compared are switched here, because we want the
# graph of speedup (3x faster) which is inverse of time (0.33 time),
# and the data in CSV are recorded times
f = open(options.input_comp,'r')
reader = csv.reader(f, delimiter = ',')
for row in reader:
	K = row[0]
	if K.endswith('-hip'):
		K = K[:-4]
	if K.endswith('-cuda'):
		K = K[:-5]
	if K.endswith('-sycl'):
		K = K[:-5]
	Baseline[K] = {
	'min': float(row[1]),
	'mean': float(row[2]),
	'stddev': float(row[3]),
	'var': float(row[4]) }
f.close()

f = open(options.input_base,'r')
reader = csv.reader(f, delimiter = ',')
for row in reader:
	K = row[0]
	if K.endswith('-hip'):
		K = K[:-4]
	if K.endswith('-cuda'):
		K = K[:-5]
	if K.endswith('-sycl'):
		K = K[:-5]
	Compared[K] = {
	'min': float(row[1]),
	'mean': float(row[2]),
	'stddev': float(row[3]),
	'var': float(row[4]) }
f.close()

# Process second dataset if provided
Baseline2 = {}
Compared2 = {}
if has_second_dataset:
	f = open(options.input_comp_2,'r')
	reader = csv.reader(f, delimiter = ',')
	for row in reader:
		if len(row) == 0:
			continue
		K = row[0]
		if K.endswith('-hip'):
			K = K[:-4]
		if K.endswith('-cuda'):
			K = K[:-5]
		if K.endswith('-sycl'):
			K = K[:-5]
		Baseline2[K] = {
		'min': float(row[1]),
		'mean': float(row[2]),
		'stddev': float(row[3]),
		'var': float(row[4]) }
	f.close()

	f = open(options.input_base_2,'r')
	reader = csv.reader(f, delimiter = ',')
	for row in reader:
		if len(row) == 0:
			continue
		K = row[0]
		if K.endswith('-hip'):
			K = K[:-4]
		if K.endswith('-cuda'):
			K = K[:-5]
		if K.endswith('-sycl'):
			K = K[:-5]
		Compared2[K] = {
		'min': float(row[1]),
		'mean': float(row[2]),
		'stddev': float(row[3]),
		'var': float(row[4]) }
	f.close()

bench_names = []
mins = []
means = []
stddevs = []
#vars = []

for K in Baseline.keys():
	if not K in Compared.keys():
		print("skipping bench: ", K)
		continue
	
	Comp = max(Compared[K]['min'] / Baseline[K]['min'], Baseline[K]['min'] / Compared[K]['min'])
	if Comp > outlier_factor:
		print(f"Outlier, exceeding factor {outlier_factor}:", K, " compared: ", Compared[K]['min'], " baseline: ", Baseline[K]['min'], " compared/base: ", Comp)
		continue
	bench_names.append(K)
	mins.append(Compared[K]['min'] / Baseline[K]['min'])
	means.append(Compared[K]['mean'] / Baseline[K]['mean'])
	stddevs.append(Compared[K]['stddev'] / Baseline[K]['mean'])

# Process second dataset
mins2 = []
means2 = []
stddevs2 = []
if has_second_dataset:
	for K in bench_names:
		if K in Baseline2.keys() and K in Compared2.keys():
			Comp = max(Compared2[K]['min'] / Baseline2[K]['min'], Baseline2[K]['min'] / Compared2[K]['min'])
			if Comp > outlier_factor:
				print(f"Outlier (2nd dataset), exceeding factor {outlier_factor}:", K)
				mins2.append(None)
				means2.append(None)
				stddevs2.append(None)
			else:
				mins2.append(Compared2[K]['min'] / Baseline2[K]['min'])
				means2.append(Compared2[K]['mean'] / Baseline2[K]['mean'])
				stddevs2.append(Compared2[K]['stddev'] / Baseline2[K]['mean'])
		else:
			mins2.append(None)
			means2.append(None)
			stddevs2.append(None)

# Sort by first dataset's values
zipped_data = zip(bench_names, mins, means, stddevs)
sorted_data = sorted(zipped_data, key = lambda x: x[1])
sorted_bench_names, sorted_mins, sorted_means, sorted_stddevs = zip(*sorted_data)

# Reorder second dataset to match sorted order
if has_second_dataset:
	name_to_val = {name: val for name, val in zip(bench_names, mins2)}
	sorted_mins2 = [name_to_val.get(name, None) for name in sorted_bench_names]
	name_to_val = {name: val for name, val in zip(bench_names, means2)}
	sorted_means2 = [name_to_val.get(name, None) for name in sorted_bench_names]
	name_to_val = {name: val for name, val in zip(bench_names, stddevs2)}
	sorted_stddevs2 = [name_to_val.get(name, None) for name in sorted_bench_names]

errs = sorted_stddevs
if not options.errbars:
	errs = None

if options.style:
	plt.style.use(options.style)

# Adjust figure size for full HD (1920x1080)
plt.figure(figsize=(19.2, 10.8), dpi=100)  # Full HD resolution

if has_second_dataset:
	# Grouped bars
	x = np.arange(len(sorted_bench_names))
	bar_width = 0.35
	offset = bar_width / 2
	
	# Filter out None values for second dataset
	mins1_vals = [x-float(options.bottom) for x in sorted_mins]
	mins2_vals = [(x-float(options.bottom)) if x is not None else 0 for x in sorted_mins2]
	errs2 = [x if x is not None else 0 for x in sorted_stddevs2] if options.errbars else None
	
	# Accessibility: Use colorblind-friendly colors and patterns
	# Choose colors - use provided color for first, colorblind-friendly alternative for second
	if options.color:
		color1 = options.color
		# Use a colorblind-friendly alternative color (blue to orange/red)
		import matplotlib.colors as mcolors
		# Convert to RGB and create a distinct colorblind-friendly alternative
		rgb = mcolors.hex2color(options.color)
		# Use orange/red as alternative (distinguishable for most colorblind types)
		color2 = '#ff7f0e'  # Orange - colorblind-friendly alternative
		# Ensure sufficient contrast
		edge_color1 = '#000000'  # Black edges for contrast
		edge_color2 = '#000000'
		edge_width = 1.0
	else:
		# Default colorblind-friendly palette
		color1 = '#1f77b4'  # Blue
		color2 = '#ff7f0e'  # Orange
		edge_color1 = '#000000'
		edge_color2 = '#000000'
		edge_width = 1.0
	
	# Create bars with patterns for accessibility
	bar1 = plt.bar(x - offset, mins1_vals, bar_width, align='center',
	               yerr=errs, color=color1, ecolor=options.ecolor or '#000000',
	               edgecolor=edge_color1, linewidth=edge_width,
	               label=options.group_label_1, bottom=float(options.bottom))
	bar2 = plt.bar(x + offset, mins2_vals, bar_width, align='center',
	               yerr=errs2, color=color2, ecolor=options.ecolor or '#000000',
	               edgecolor=edge_color2, linewidth=edge_width,
	               hatch='///',  # Add diagonal pattern for accessibility
	               label=options.group_label_2, bottom=float(options.bottom))
	
	plt.xticks(x, sorted_bench_names, rotation=45, fontsize=FONT_SIZE_TICKS, ha='right')
	# Accessibility: Legend with better positioning and frame
	plt.legend(fontsize=FONT_SIZE_TICKS, frameon=True, fancybox=False, shadow=False, 
	           edgecolor='black', framealpha=1.0)
else:
	# Single set of bars (original behavior)
	bar_width = 0.68
	# Accessibility: Add edge color for contrast
	edge_color = '#000000'  # Black edges for accessibility
	edge_width = 1.0
	bar1 = plt.bar(sorted_bench_names, [x-float(options.bottom) for x in sorted_mins], bar_width, align='center',
	               yerr=errs, color=options.color, ecolor=options.ecolor or '#000000',
	               edgecolor=edge_color, linewidth=edge_width,
	               label=options.zlabel, bottom=float(options.bottom))
	plt.xticks(rotation=45, fontsize=FONT_SIZE_TICKS, ha='right')


if options.xlabel:
	plt.xlabel(options.xlabel, fontsize=FONT_SIZE_AXIS_LABELS)
if options.ylabel:
	plt.ylabel(options.ylabel, fontsize=FONT_SIZE_AXIS_LABELS)
if options.title:
	plt.title(options.title, fontsize=FONT_SIZE_TITLE, pad=15)

# More conservative margins
plt.margins(x=0.01, y=0.15)

# Refined subplot parameters
plt.subplots_adjust(left=0.12, right=0.95, bottom=0.25, top=0.92)

if options.refline:
	# Accessibility: Use darker, higher contrast line
	plt.axhline(1.0, ls='dashed', color='#333333', alpha=0.7, linewidth=1.5)
# Always show geomean and sample count
# Accessibility: High contrast text boxes
g = geomean(sorted_mins)
s = f"Geomean = {g:.2f}"
y_pos = 0.95
plt.text(0.02, y_pos, s, transform=plt.gca().transAxes, 
		 verticalalignment='top', horizontalalignment='left',
		 fontsize=FONT_SIZE_TICKS, color='black',
		 bbox=dict(facecolor='white', alpha=0.95, edgecolor='black', linewidth=1.5))

if has_second_dataset:
	# Show geomean for second dataset
	g2_vals = [x for x in sorted_mins2 if x is not None]
	if len(g2_vals) > 0:
		g2 = geomean(g2_vals)
		s2 = f"Geomean ({options.group_label_2}) = {g2:.2f}"
		y_pos -= 0.05
		plt.text(0.02, y_pos, s2, transform=plt.gca().transAxes, 
				 verticalalignment='top', horizontalalignment='left',
				 fontsize=FONT_SIZE_TICKS, color='black',
				 bbox=dict(facecolor='white', alpha=0.95, edgecolor='black', linewidth=1.5))

# Add the number of samples being plotted
n_samples = len(sorted_mins)
n_text = f"N = {n_samples}"
y_pos -= 0.05
plt.text(0.02, y_pos, n_text, transform=plt.gca().transAxes, 
		 verticalalignment='top', horizontalalignment='left',
		 fontsize=FONT_SIZE_TICKS, color='black',
		 bbox=dict(facecolor='white', alpha=0.95, edgecolor='black', linewidth=1.5))

# Only show one set of bar labels to reduce clutter
if options.bar_labels:
	if has_second_dataset:
		plt.bar_label(bar1, labels=[f'{x:.2f}' for x in sorted_mins], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)
		plt.bar_label(bar2, labels=[f'{x:.2f}' if x is not None else '' for x in sorted_mins2], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)
	else:
		plt.bar_label(bar1, labels=[f'{x:.2f}' for x in sorted_mins], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)
elif options.bar_values:  # Don't show both types of labels
	if has_second_dataset:
		plt.bar_label(bar1, labels=[f'{x:.2f}' for x in sorted_mins], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)
		plt.bar_label(bar2, labels=[f'{x:.2f}' if x is not None else '' for x in sorted_mins2], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)
	else:
		plt.bar_label(bar1, labels=[f'{x:.2f}' for x in sorted_mins], 
					 label_type='edge', rotation=45, fontsize=FONT_SIZE_BAR_LABELS, padding=5)

if options.log_scale:
	plt.yscale('log')

plt.tight_layout()

if options.output:
	plt.savefig(options.output, bbox_inches='tight', dpi=100)  # Full HD resolution
else:
	plt.show()

