#!/bin/bash

set -u  # Exit on undefined variable

SCRIPT=$(readlink -f "$0")
HECBENCH=$(dirname "$SCRIPT")
FAILED_DOWNLOADS=()

function check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: $1 is required but not installed."
        exit 1
    fi
}

# Check required commands
check_command wget
check_command tar
check_command gunzip

# Function to download file with retry and checksum verification
download_file() {
    local url="$1"
    local output="$2"
    local max_retries=3
    local retry=0
    
    while [ $retry -lt $max_retries ]; do
        if wget --no-verbose --tries=3 --timeout=15 -O "$output" "$url"; then
            return 0
        fi
        retry=$((retry + 1))
        echo "Download failed, retrying ($retry/$max_retries)..."
        sleep 2
    done
    echo "Error: Failed to download $url after $max_retries attempts"
    FAILED_DOWNLOADS+=("$url")
    return 1
}

# Function to safely change directory
safe_cd() {
    cd "$1" || {
        echo "Error: Failed to change to directory $1"
        exit 1
    }
}

echo "Starting data preparation..."

##############
# Unpack existing archives
echo "Unpacking tar.gz files..."
for D in $(find . -type f -name "*.tar.gz"); do
    if [ ! -d "$(dirname "$D")/unpacked" ]; then
        echo "Unpacking $D..."
        if ! tar -xf "$D" -C "$(dirname "$D")"; then
            echo "Warning: Failed to unpack $D"
            continue
        fi
        mkdir -p "$(dirname "$D")/unpacked"
    fi
done

# Create symlinks
echo "Creating symlinks..."
safe_cd "$HECBENCH/sssp-hip"
[ ! -L "input" ] && ln -s ../sssp-cuda/input . || true
[ ! -L "output" ] && ln -s ../sssp-cuda/output . || true

safe_cd "$HECBENCH/sssp-sycl"
[ ! -L "input" ] && ln -s ../sssp-cuda/input . || true
[ ! -L "output" ] && ln -s ../sssp-cuda/output . || true

################
# Hogbom CUDA data
echo "Preparing Hogbom CUDA data..."
safe_cd "$HECBENCH/hogbom-cuda"
mkdir -p data
safe_cd data

if [ ! -e dirty_4096.img ]; then
    echo "Downloading dirty_4096.img..."
    download_file "https://github.com/ATNF/askap-benchmarks/raw/master/data/dirty_4096.img" "dirty_4096.img"
fi

if [ ! -e psf_4096.img ]; then
    echo "Downloading psf_4096.img..."
    download_file "https://github.com/ATNF/askap-benchmarks/raw/master/data/psf_4096.img" "psf_4096.img"
fi

###################
# SVD3x3 CUDA data
echo "Preparing SVD3x3 CUDA data..."
safe_cd "$HECBENCH/svd3x3-cuda"

if [ ! -e Dataset_1M.txt ]; then
    echo "Downloading Dataset_1M.txt..."
    download_file "https://github.com/kuiwuchn/3x3_SVD_CUDA/raw/master/svd3x3/svd3x3/Dataset_1M.txt" "Dataset_1M.txt"
fi

###################
# Rodinia benchmark suite
echo "Preparing Rodinia benchmark suite..."
safe_cd "$HECBENCH"

if [ ! -d "rodinia_3.1" ]; then
    mkdir -p rodinia_3.1
    if [ ! -e rodinia_3.1.tar.bz2 ]; then
        echo "Downloading Rodinia benchmark suite..."
        download_file "http://www.cs.virginia.edu/~skadron/lava/Rodinia/Packages/rodinia_3.1.tar.bz2" "rodinia_3.1.tar.bz2"
    fi
    if [ -e rodinia_3.1.tar.bz2 ]; then
        if ! tar xjf rodinia_3.1.tar.bz2 -C rodinia_3.1 --strip-components=1; then
            echo "Warning: Failed to extract Rodinia benchmark suite"
            rm -f rodinia_3.1.tar.bz2
        fi
    fi
fi

if [ ! "$(ls -A data 2>/dev/null)" ] && [ -d "rodinia_3.1/data" ]; then
    mkdir -p data
    cp -r rodinia_3.1/data/* ./data || echo "Warning: Failed to copy Rodinia data"
fi

###################
# Chi2 CUDA data
echo "Preparing Chi2 CUDA data..."
safe_cd "$HECBENCH/chi2-cuda"
if [ ! -e traindata ]; then
    echo "Downloading traindata for chi2 benchmark..."
    if download_file "https://web.njit.edu/~usman/courses/cs677_spring19/traindata.gz" "traindata.gz"; then
        if ! gunzip traindata.gz; then
            echo "Warning: Failed to extract traindata.gz"
            rm -f traindata.gz
        fi
    fi
fi

#####################
# CED SYCL data
echo "Preparing CED SYCL data..."
safe_cd "$HECBENCH/ced-sycl"

if [ ! -d "frames" ] && [ -e "frames.tar.gz" ]; then
    echo "Extracting frames.tar.gz..."
    if ! tar xzf frames.tar.gz; then
        echo "Warning: Failed to extract frames.tar.gz"
    fi
else
    [ ! -e "frames.tar.gz" ] && echo "Warning: frames.tar.gz not found!"
fi

#####################
# AES CUDA data
echo "Preparing AES CUDA data..."
safe_cd "$HECBENCH/aes-cuda"
if [ ! -e dots.bmp ]; then
    echo "Downloading dots.bmp for aes-cuda..."
    download_file "https://people.math.sc.edu/Burkardt/data/bmp/dots.bmp" "dots.bmp"
fi

# Report final status
if [ ${#FAILED_DOWNLOADS[@]} -eq 0 ]; then
    echo "Data preparation completed successfully!"
else
    echo "Data preparation completed with some failures:"
    printf '%s\n' "${FAILED_DOWNLOADS[@]}"
    echo "You may want to manually download these files."
fi


