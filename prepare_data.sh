#!/bin/bash

SCRIPT=$(readlink -f $0)
HECBENCH=$(dirname $SCRIPT)

for F in bsw-cuda/test-data.tar.gz ced-hip/frames.tar.gz columnarSolver-cuda/data.tar.gz sssp-cuda/data.tar.gz geodesic-sycl/locations.tar.gz snake-cuda/Datasets.tar.gz sssp-cuda/data.tar.gz urng-sycl/image.tar.gz ss-sycl/input.tar.gz sobel-sycl/data.tar.gz ; do

  echo "############ UNPACKING $F"

  D=$(dirname $F)
  cd $HECBENCH/$D && tar xzf $HECBENCH/$F

done

##############

cd $HECBENCH/sssp-hip ; ln -s ../sssp-cuda/input . ; ln -s ../sssp-cuda/output .

cd $HECBENCH/sssp-sycl ; ln -s ../sssp-cuda/input . ; ln -s ../sssp-cuda/output .

################

cd $HECBENCH/hogbom-cuda

mkdir -p data
cd data

if [ ! -e dirty_4096.img ] ; then
  wget https://github.com/ATNF/askap-benchmarks/raw/master/data/dirty_4096.img
fi
if [ ! -e psf_4096.img ] ; then
  wget https://github.com/ATNF/askap-benchmarks/raw/master/data/psf_4096.img
fi

###################

cd $HECBENCH/svd3x3-cuda

if [ ! -e Dataset_1M.txt ]; then
  wget https://github.com/kuiwuchn/3x3_SVD_CUDA/raw/master/svd3x3/svd3x3/Dataset_1M.txt
fi

###################

<<<<<<< Updated upstream
=======
cd $HECBENCH

mkdir -p rodinia_3.1

if [ ! -e rodinia_3.1.tar.bz2 ]; then
  wget http://www.cs.virginia.edu/\~skadron/lava/Rodinia/Packages/rodinia_3.1.tar.bz2
  tar xjf rodinia_3.1.tar.bz2 -C rodinia_3.1 --strip-components=1
fi

mkdir data

cp -r rodinia_3.1/data/* ./data

###################

>>>>>>> Stashed changes
cd $HECBENCH/chi2-cuda
if [ ! -e traindata ]; then
  echo "############ DOWNLOADING traindata for chi2 benchmark"
  wget https://web.njit.edu/~usman/courses/cs677_spring19/traindata.gz
  gunzip traindata.gz
fi

<<<<<<< Updated upstream


cd $HECBENCH
mkdir -p rodinia_3.1

if [ ! -e rodinia_3.1.tar.bz2 ]; then
  wget http://www.cs.virginia.edu/\~skadron/lava/Rodinia/Packages/rodinia_3.1.tar.bz2
  tar xjf rodinia_3.1.tar.bz2 -C rodinia_3.1 --strip-components=1
fi

mkdir data
cp -r rodinia_3.1/data/* ./data

=======
#####################

cd $HECBENCH/ced-sycl

if [ ! -d "frames" ]; then
  if [ -e "frames.tar.gz" ]; then
    tar xzf frames.tar.gz
  else
    echo "frames.tar.gz not found!"
  fi
else
  echo "frames directory already exists. Skipping unzipping."
fi

#####################

cd $HECBENCH/aes-cuda
if [ ! -e dots.bmp ]; then
  echo "############ DOWNLOADING dots.bmp for aes-cuda"
  wget https://people.math.sc.edu/Burkardt/data/bmp/dots.bmp
fi
>>>>>>> Stashed changes
