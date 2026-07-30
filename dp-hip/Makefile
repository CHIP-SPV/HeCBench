#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no
LAUNCHER  =

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = main.cu shrUtils.cu

obj = $(source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall

# Upstream built this with clang's --hipstdpar so that the std::execution
# parallel algorithms over device pointers were rewritten onto ROCm's HIP
# Standard Parallelism Acceleration library. chipStar ships no such library
# ("error: cannot find HIP Standard Parallelism Acceleration library"), so
# --hipstdpar/--hipstdpar-path and the AMD-only --offload-arch=gfx90a and
# -munsafe-fp-atomics are dropped. The one algorithm that needed it is served
# by stdpar_shim.h, which forwards to rocThrust instead.
#
# chipStar ships rocThrust with a working HIP device backend (-> rocPRIM). Pin
# chipStar's copy ahead of any system /usr/include/thrust (upstream NVIDIA
# thrust, whose CUDA backend needs an unavailable CUB) which the host compile
# pass would otherwise pick up via -idirafter/CPATH.
CHIPSTAR_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(CHIPSTAR_ROOT)/include
CFLAGS += -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP

# Linker Flags
LDFLAGS = -lhipblas

# Debug Flags
ifeq ($(DEBUG),yes)
  CFLAGS += -g
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

%.o: %.cu shrUtils.h stdpar_shim.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 268435456 1000

smoke: $(program)
	$(LAUNCHER) ./$(program) 4194304 20
