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

HIPSOLVER_PATH = /space/pvelesko/install/HIP/chipStar/H4I-HipSOLVER/2026.04.16
MKLSHIM_PATH  = /space/pvelesko/install/HIP/chipStar/H4I-MKLShim/2026.04.16

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall -I$(HIPSOLVER_PATH)/include
# chipStar 2026.07.20 ships rocThrust with a real HIP device backend (-> rocPRIM); use it so
# the op runs on the GPU (matches the SYCL variant's make_device_policy). Pin chipStar's rocThrust
# ahead of the apt /usr/include/thrust (upstream NVIDIA thrust, no HIP backend) which the host
# compile pass otherwise picks up via -idirafter/CPATH.
CHIPSTAR_ROOT := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
CFLAGS += -isystem $(CHIPSTAR_ROOT)/include
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
