#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = clang++
OPTIMIZE  = yes
DEBUG     = no

GPU       = yes
CUDA      = no
CUDA_ARCH = sm_70
HIP       = no
HIP_ARCH  = gfx908
GCC_TOOLCHAIN = "/auto/software/gcc/x86_64/gcc-9.1.0/"
LAUNCHER  =

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = gemm.cpp

obj = $(source:.cpp=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I${MKLROOT}/include -DMKL_ILP64 -fsycl

ifeq ($(VENDOR), AdaptiveCpp)
CFLAGS := $(filter-out -fsycl,$(CFLAGS))
endif

# Linker Flags
LDFLAGS = -L${MKLROOT}/lib -lmkl_sycl -lmkl_intel_ilp64 -lmkl_tbb_thread -lmkl_core \
          -fsycl-device-code-split=per_kernel \
          -ltbb -lsycl -lOpenCL -lpthread -lm -ldl

ifeq ($(CUDA), yes)
  CFLAGS += -fsycl-targets=nvptx64-nvidia-cuda \
            -Xsycl-target-backend --cuda-gpu-arch=$(CUDA_ARCH) \
            --gcc-toolchain=$(GCC_TOOLCHAIN)
endif

ifeq ($(HIP), yes)
  CFLAGS += -fsycl-targets=amdgcn-amd-amdhsa \
	    -Xsycl-target-backend --offload-arch=$(HIP_ARCH) 
endif

# Debug Flags
ifeq ($(DEBUG),yes)
  CFLAGS  += -g -DDEBUG
  LDFLAGS += -g
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  CFLAGS += -O3
endif

ifeq ($(GPU),yes)
  CFLAGS +=-DUSE_GPU
endif
#===============================================================================
# Targets to Build
#===============================================================================

$(program): $(obj)
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 100

smoke: $(program)
	$(LAUNCHER) ./$(program) 100
