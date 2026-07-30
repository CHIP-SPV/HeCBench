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
# Standard Parallelism Acceleration library. the HIP SDK ships no such library
# ("error: cannot find HIP Standard Parallelism Acceleration library"), so
# --hipstdpar/--hipstdpar-path and the AMD-only --offload-arch=gfx90a and
# -munsafe-fp-atomics are dropped. The one algorithm that needed it is served
# by chipStdPar (github.com/CHIP-SPV/chipStdPar), which forwards to rocThrust
# instead; cloned on first use at the pinned commit below.
CHIPSTDPAR_DIR    = chipStdPar
CHIPSTDPAR_COMMIT = fd1b1e1a32294f1e8d251220404ef02c02db8225
#
# The HIP SDK ships rocThrust with a working HIP device backend (-> rocPRIM). Pin
# the SDK's copy ahead of any system /usr/include/thrust (upstream NVIDIA
# thrust, whose CUDA backend needs an unavailable CUB) which the host compile
# pass would otherwise pick up via -idirafter/CPATH.
HIP_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(HIP_ROOT)/include
CFLAGS += -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP
CFLAGS += -I$(CHIPSTDPAR_DIR)/include

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

$(obj): | $(CHIPSTDPAR_DIR)/include/stdpar_shim.h

$(CHIPSTDPAR_DIR)/include/stdpar_shim.h:
	test -d $(CHIPSTDPAR_DIR) || git clone https://github.com/CHIP-SPV/chipStdPar $(CHIPSTDPAR_DIR)
	cd $(CHIPSTDPAR_DIR) && git checkout -q $(CHIPSTDPAR_COMMIT)

%.o: %.cu shrUtils.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 268435456 1000

smoke: $(program)
	$(LAUNCHER) ./$(program) 4194304 20
