#!/usr/bin/env python3
#
# Script to run HeCBench benchmarks and gather results

import re, time, sys, subprocess, multiprocessing, os
import argparse
import json
import statistics

class Benchmark:
    def __init__(self, args, name, res_regex, run_args = [], binary = "main", invert = False):
        if name.endswith('sycl'):
            self.MAKE_ARGS = ['GCC_TOOLCHAIN="{}"'.format(args.gcc_toolchain)]
            if args.sycl_type == 'cuda':
                self.MAKE_ARGS.append('CUDA=yes')
                self.MAKE_ARGS.append('CUDA_ARCH=sm_{}'.format(args.nvidia_sm))
            elif args.sycl_type == 'hip':
                self.MAKE_ARGS.append('HIP=yes')
                self.MAKE_ARGS.append('HIP_ARCH={}'.format(args.amd_arch))
            elif args.sycl_type == 'opencl':
                self.MAKE_ARGS.append('CUDA=no')
                self.MAKE_ARGS.append('HIP=no')
                self.MAKE_ARGS.append('CC=icpx')
                self.MAKE_ARGS.append('CXX=icpx')
        elif name.endswith('cuda'):
            self.MAKE_ARGS = ['CUDA_ARCH=sm_{}'.format(args.nvidia_sm)]
        elif name.endswith('hip'):
            self.MAKE_ARGS = []
            self.MAKE_ARGS.append('CC=hipcc')
            self.MAKE_ARGS.append('CXX=hipcc')
        else:
            self.MAKE_ARGS = []

        if args.extra_compile_flags:
            flags = args.extra_compile_flags.replace(',',' ')
            self.MAKE_ARGS.append('EXTRA_CFLAGS={}'.format(flags))

        if name.endswith('opencl') and args.opencl_inc_dir:
            self.MAKE_ARGS.append('OPENCL_INC={}'.format(args.opencl_inc_dir))

        if args.bench_dir:
            self.path = os.path.realpath(os.path.join(args.bench_dir, name))
        else:
            self.path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', name)

        self.name = name
        self.binary = binary
        self.res_regex = res_regex
        self.args = run_args
        self.invert = invert
        self.clean = args.clean
        self.verbose = args.verbose

    def compile(self):
        if self.clean:
            subprocess.run(["make", "clean"], cwd=self.path).check_returncode()
            time.sleep(1) # required to make sure clean is done before building, despite run waiting on the invoked executable

        out = subprocess.DEVNULL
        if self.verbose:
            out = subprocess.PIPE

        proc = subprocess.run(["make"] + self.MAKE_ARGS, cwd=self.path, capture_output=True, encoding="ascii")
        try:
            proc.check_returncode()
        except subprocess.CalledProcessError as e:
            print(f'Failed compilation in {self.path}.\n{e}')
            if e.stdout:
                print(e.stdout, file=sys.stderr)
            if e.stderr:
                print(e.stderr, file=sys.stderr)
            raise(e)

        if self.verbose:
            print(proc.stdout)

    def run(self, vtune_root_prefix = None, vtune_root_suffix = None,  numactl_args = None, extra_env = None):
        cmd = []
        if numactl_args:
            cmd.append("numactl")
            cmd.extend(numactl_args.split())
        if vtune_root_prefix:
            vtune_r = vtune_root_prefix + self.name
            if vtune_root_suffix:
                vtune_r += vtune_root_suffix
            cmd.extend(["vtune", '-collect', 'gpu-hotspots', '-r', vtune_r])
        cmd.append("./" + self.binary)
        cmd.extend(self.args)
        print("Running: " + " ".join(cmd))
        proc = subprocess.run(cmd, cwd=self.path, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, encoding="ascii", timeout=5200, env=extra_env)
        out = proc.stdout
        if self.verbose:
            print(out)
        proc.check_returncode()
        res = re.findall(self.res_regex, out)
        if not res:
            raise Exception(self.path + ":\nno regex match for " + self.res_regex + " in\n" + out)
        res = sum([float(i) for i in res]) #in case of multiple outputs sum them
        if self.invert:
            res = 1/res
        return res

    def dry_run(self):
        cmd = ["make", "run", "-n"]
        proc = subprocess.run(cmd, cwd=self.path, capture_output=True, encoding="ascii")
        try:
            proc.check_returncode()
        except subprocess.CalledProcessError as e:
            print(f'Failed dry run in {self.path}.\n{e}')
            if e.stdout:
                print(e.stdout, file=sys.stderr)
            if e.stderr:
                print(e.stderr, file=sys.stderr)
            raise(e)
        
        # Extract the actual command being executed
        lines = proc.stdout.split('\n')
        for line in lines:
            if './' in line:  # This assumes the command starts with './'
                return line.strip()
        return None

def comp(b):
    print("compiling: {}".format(b.name))
    b.compile()

def get_bench_map(lang):
    base_map = {
        'adam': './main 10000 200 100',
        'aes': './main 100 0 ../urng-sycl/URNG_Input.bmp',
        'aidw': './main 10 1 100',
        'all-pairs-distance': './main 10000',
        'asmooth': './main 8192 2000 9 100',
        'asta': './main',
        'atomicReduction': './main',
        'bezier-surface': './main -n 8192',
        'bfs': './main ../data/bfs/graph1MW_6.txt',
        'bilateral': './main 2960 1440 0.5 0.5 1000',
        'boxfilter': './main ../boxfilter-sycl/data/lenaRGB.ppm 10000',
        'bitonic-sort': './main 25 2',
        'bscan': './main 1000',
        'ced': './main -a 0',
        'chemv': './main',
        'chi2': './main ../chi2-cuda/traindata 4000 400000 2000 2000 256 1000',
        'colorwheel': './main 10 4096 100',
        'columnarSolver': './main ../columnarSolver-cuda/data',
        'compute-score': './main -p=1000',
        'crossEntropy': './main 100',
        'dct8x8': './main 8192 8192 100',
        'eigenvalue': './main 2048 10000',
        'entropy': './main 8192 8192 100',
        'f16max': './main 100',
        'fft': './main 3 100',
        'floydwarshall': './main 1024 100 16',
        'fsm': './main 65536',
        'haccmk': './main 1000',
        'hausdorff': './main 100000 100000 100',
        'hellinger': './main 100',
        'histogram': './main --i=100',
        'hogbom': './main ../hogbom-cuda/data/dirty_4096.img ../hogbom-cuda/data/psf_4096.img 1000',
        'hwt1d': './main 8388608 100',
        'hybridsort': './main r',
        'is': './main 256 256 256',
        'jenkins-hash': './main 256 16777216 100',
        'keogh': './main 256 20000000 100',
        'layout': './main 1000',
        'lfib4': './main 2000000000',
        'linearprobing': './main 16 8',
        'lombscargle': './main 100',
        'mandelbrot': './main 1000',
        'matern': './main 300 100',
        'maxpool3d': './main 2048 2048 96 100',
        'minisweep': './main --niterations 100',
        'minkowski': './main 100',
        'mrc': './main 10000000 1000',
        'mr': './main',
        'murmurhash3': './main 100000 100',
        'nlll': './main 2048 1024 1000 100',
        'nw': './main 16384 10',
        'overlap': './main',
        'overlay': './main 640 480',
        'p2p': './main 100',
        'pad': './main -a 0.1',
        'perplexity': './main 10000 50 100',
        'pnpoly': './main 100',
        'pool': './main 128 48 224 224 54 54 100',
        'present': './main 100000 100',
        'quicksort': './main 10 2048 2048',
        'radixsort': './main 1000',
        'romberg': './main 128 64 1000',
        'rsbench': './main -s large -m event',
        'scan2': './main 1000 33554432 256',
        'scan': './main 268435456 100',
        'sc': './main -a 0.1',
        'shuffle': './main 200000 100',
        'snake': './main 100 ../snake-cuda/Datasets/ERR240727_1_E2_30000Pairs.txt 30000 1000',
        'sobel': './main ../sobel-sycl/SobelFilter_Input.bmp 100000',
        'softmax': './main 100000 784 100',
        'sort': './main 3 100',
        'ss': './main ../ss-sycl/StringSearch_Input.txt clEnqueueNDRangeKernel 20000',
        'sssp': './main -g 120 -t 1 -w 10 -r 100',
        'stddev': './main 65536 16384 100',
        'stencil1d': './main 134217728 1000',
        'svd3x3': './main ../svd3x3-cuda/Dataset_1M.txt 100',
        'swish': './main 10000000 1000',
        'tensorAccessor': './main 8192 8192 1000',
        'tensorT': './main 100',
        'tqs': './main -f ../tqs-cuda/input/patternsNP100NB512FB25.txt',
        'tsa': './main 1024 1024 100',
        'urng': './main ../urng-sycl/URNG_Input.bmp 16 16 1000',
        'vanGenuchten': './main 256 256 256 1000',
        'wyllie': './main 8000000 1 100',
    }
    
    return {f"{k}-{lang}": v for k, v in base_map.items()}

def main():
    parser = argparse.ArgumentParser(description='HeCBench runner')
    parser.add_argument('--output', '-o',
                        help='Output file for csv results')
    parser.add_argument('--repeat', '-r', type=int, default=1,
                        help='Repeat benchmark run')
    parser.add_argument('--warmup', '-w', type=bool, default=True,
                        help='Run a warmup iteration')
    parser.add_argument('--sycl-type', '-s', choices=['cuda', 'hip', 'opencl'], default='cuda',
                        help='Type of SYCL device to use')
    parser.add_argument('--nvidia-sm', type=int, default=60,
                        help='NVIDIA SM version')
    parser.add_argument('--amd-arch', default='gfx908',
                        help='AMD Architecture')
    parser.add_argument('--gcc-toolchain', default='',
                        help='GCC toolchain location')
    parser.add_argument('--opencl-inc-dir', default='/usr/include',
                        help='Include directory with CL/cl.h')
    parser.add_argument('--extra-compile-flags', '-e', default='',
                        help='Additional compilation flags (inserted before the predefined CFLAGS)')
    parser.add_argument('--clean', '-c', action='store_true',
                        help='Clean the builds')
    parser.add_argument('--verbose', '-v', action='store_true',
                        help='Clean the builds')
    parser.add_argument('--bench-dir', '-b',
                        help='Benchmark directory')
    parser.add_argument('--bench-data', '-d',
                        help='Benchmark data')
    parser.add_argument('--bench-fails', '-f',
                        help='List of failing benchmarks to ignore')
    parser.add_argument('bench', nargs='+',
                        help='Either specific benchmark name or sycl, cuda, hip or opencl')
    parser.add_argument('--extra-env', default='',
                        help='Additional environment')
    parser.add_argument('--numactl-args', default=None,
                        help='numactl args')
    parser.add_argument('--vtune-root-prefix', default=None,
                        help='vtune report root directory base')
    parser.add_argument('--vtune-root-suffix', default=None,
                        help='vtune report root directory suffix ')
    parser.add_argument('--generate-map', action='store_true',
                        help='Generate a map of benchmark commands')

    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Load benchmark data
    if args.bench_data:
        bench_data = args.bench_data
    else:
        bench_data = os.path.join(script_dir, 'benchmarks', 'subset.json')

    with open(bench_data) as f:
        benchmarks = json.load(f)

    # Load fail file
    if args.bench_fails:
        bench_fails = os.path.abspath(args.bench_fails)
    else:
        bench_fails = os.path.join(script_dir, 'benchmarks', 'subset-fails.txt')

    with open(bench_fails) as f:
        fails = f.read().splitlines()

    # Build benchmark list
    benches = []
    for b in args.bench:
        if b in ['sycl', 'cuda', 'hip', 'opencl']:
            benches.extend([Benchmark(args, k, *v)
                            for k, v in benchmarks.items()
                            if k.endswith(b) and k not in fails])
            continue

        benches.append(Benchmark(args, b, *benchmarks[b]))

    t0 = time.time()
    try:
        with multiprocessing.Pool(8) as p:
            p.map(comp, benches)
    except Exception as e:
        print("Compilation failed, exiting")
        print(e)
        sys.exit(1)

    t_compiled = time.time()
    if args.repeat == 0:
        print("compilation took {} s.".format(t_compiled-t0))
        print("Repeat value is zero. Exiting.")
        return

    outfile = sys.stdout
    existing = {}
    if args.output:
        if os.path.isfile(args.output):
            outfile = open(args.output, 'r+t')
        else:
            outfile = open(args.output, 'w+t')
        for line in outfile:
            bench, *rest = line.split(',')
            print("Found bench: {}", bench)
            existing[bench] = True
        outfile.seek(0, 2)

    extra_env = {}
    extra_env.update(os.environ)
    if args.extra_env:
        env_strs = args.extra_env.split(";")
        for e in env_strs:
            key, val = e.split("=", 1)
            extra_env[key] = val
    if args.numactl_args or args.vtune_root_prefix:
        args.warmup = False
        args.repeat = 1

    if args.generate_map:
        benchmark_map = {}
        for b in benches:
            try:
                print(f"Dry running: {b.name}")
                cmd = b.dry_run()
                if cmd:
                    benchmark_map[b.name] = cmd
                else:
                    print(f"Warning: Could not extract command for {b.name}")
            except Exception as err:
                print(f"Error dry running: {b.name}")
                print(err)

        print("\nBenchmark Command Map:")
        print("benchmark_map = {")
        for name, cmd in benchmark_map.items():
            print(f"    '{name}': '{cmd}',")
        print("}")
        exit(0)
    
    for i, b in enumerate(benches):
        try:
            print("\nrunning {}/{}: {}".format(i, len(benches), b.name), flush=True)
            if b.name in existing:
                print("result already exists, skipping", flush=True)
                continue
            if (b.name.startswith("tensorAccessor")
                or b.name.startswith("matern")
                or b.name.startswith("wyllie")
                or b.name.startswith("sort-sycl")):
                print("will likely timeout, skipping", flush=True)
                continue
            time.sleep(1)

            if args.warmup:
                b.run()

            all_res = []
            for i in range(args.repeat):
                all_res.append(b.run(args.vtune_root_prefix, args.vtune_root_suffix,
                                     args.numactl_args, extra_env))
            # take the minimum result
            res_min = min(all_res)
            res_avg = sum(all_res) / len(all_res)
            if args.repeat > 1:
                res_stddev = statistics.stdev(all_res)
                res_coefvar = res_stddev / res_avg
            else:
                res_stddev = 0
                res_coefvar = 0

            print(b.name + "," + str(res_min)  + "," + str(res_avg)  + "," + str(res_stddev) +
                  "," + str(res_coefvar), file=outfile, flush=True)
        except Exception as err:
            print("Error running: {}".format(b.name), flush=True)
            print(err, flush=True)
            time.sleep(1)


    if args.output:
        outfile.close()

    t_done = time.time()
    print("compilation took {} s, runnning took {} s.".format(t_compiled-t0, t_done-t_compiled))



if __name__ == "__main__":
    main()
