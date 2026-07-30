#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no
MPI_ROOT  = /usr/lib/x86_64-linux-gnu/openmpi
# The bundled rccl_shim supports single-rank communicators only (one visible
# HIP device), so launch a single rank.
LAUNCHER ?= /usr/bin/mpirun -n 1

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = main.cu

obj = $(source:.cu=.o) rccl_shim/rccl_shim.o

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -I$(MPI_ROOT)/include -Irccl_shim -Wall

# Linker Flags (no librccl: the used NCCL subset is provided by rccl_shim)
LDFLAGS = -L$(MPI_ROOT)/lib -Wl,-rpath,$(MPI_ROOT)/lib -lmpi

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

rccl_shim/rccl_shim.o: rccl_shim/rccl_shim.cc rccl_shim/rccl/rccl.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 50

smoke: $(program)
	$(LAUNCHER) ./$(program) 1
