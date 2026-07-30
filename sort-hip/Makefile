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

source = main.cu

obj = $(source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall
# The HIP SDK ships rocThrust with a real HIP device backend (-> rocPRIM); use it so
# the op runs on the GPU (matches the SYCL variant's make_device_policy). Pin the SDK's rocThrust
# ahead of the apt /usr/include/thrust (upstream NVIDIA thrust, no HIP backend) which the host
# compile pass otherwise picks up via -idirafter/CPATH.
HIP_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(HIP_ROOT)/include
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

%.o: %.cu *.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 3 100

smoke: $(program)
	$(LAUNCHER) ./$(program) 3 100
