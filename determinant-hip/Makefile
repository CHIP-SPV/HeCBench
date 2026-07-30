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

# hipSOLVER/MKLShim live in the HIP SDK prefix (derived from hipcc on PATH);
# override HIPSOLVER_PATH/MKLSHIM_PATH for a split installation.
SDK_PREFIX := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
HIPSOLVER_PATH ?= $(SDK_PREFIX)
MKLSHIM_PATH  ?= $(SDK_PREFIX)

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall -I$(HIPSOLVER_PATH)/include
# The HIP SDK ships rocThrust with a real HIP device backend (-> rocPRIM); use it so
# the op runs on the GPU (matches the SYCL variant's make_device_policy). Pin the SDK's rocThrust
# ahead of the apt /usr/include/thrust (upstream NVIDIA thrust, no HIP backend) which the host
# compile pass otherwise picks up via -idirafter/CPATH.
HIP_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(HIP_ROOT)/include
CFLAGS += -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_HIP
# H4I-HipSOLVER only exports non-Dn potrf; redirect Dn variants to non-Dn equivalents.
CFLAGS += -DhipsolverDnSpotrf_bufferSize=hipsolverSpotrf_bufferSize
CFLAGS += -DhipsolverDnSpotrf=hipsolverSpotrf

# Linker Flags
LDFLAGS = -L$(HIPSOLVER_PATH)/lib -L$(MKLSHIM_PATH)/lib -lhipsolver -lMKLShim

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
	$(LAUNCHER) ./$(program) 1000

smoke: $(program)
	$(LAUNCHER) ./$(program) 100
