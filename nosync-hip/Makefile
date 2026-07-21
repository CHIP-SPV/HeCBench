#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = main.cu

obj = $(source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
# When install Thrust from source
# git clone --recursive https://github.com/NVIDIA/thrust.git
# The Thrust include path (-I<thrust repo root>)
# The CUB include path, if using the CUDA device system (-I<thrust repo root>/dependencies/cub/)

CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall
# chipStar 2026.07.20 ships rocThrust with a real HIP device backend (-> rocPRIM); use it so
# the op runs on the GPU (matches the SYCL variant's make_device_policy). Pin chipStar's rocThrust
# ahead of the apt /usr/include/thrust (upstream NVIDIA thrust, no HIP backend) which the host
# compile pass otherwise picks up via -idirafter/CPATH.
CHIPSTAR_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(CHIPSTAR_ROOT)/include
CFLAGS += -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP

# Linker Flags
LDFLAGS = 

# Debug Flags
ifeq ($(DEBUG),yes)
  CFLAGS += -g -DDEBUG
  LDFLAGS  += -g
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  CFLAGS += -O3
endif
#===============================================================================
# Targets to Build
#===============================================================================

$(program): $(obj) Makefile
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	./$(program) 268435456 100

smoke: $(program)
	$(LAUNCHER) ./$(program) ./$(program) 268435456 100
