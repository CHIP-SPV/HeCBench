#===============================================================================
# User Options
#===============================================================================
MPI_ROOT=/usr/lib/x86_64-linux-gnu/openmpi
MPI_BIN=/usr/bin
# hipBLAS and the HIP runtime live in the SDK prefix (derived from hipcc on
# PATH); override for a split installation.
SDK_PREFIX := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
HIPBLAS_ROOT ?= $(SDK_PREFIX)
HIPRT_ROOT ?= $(SDK_PREFIX)

# Compiler can be set below, or via environment variable
CC        = hipcc
LD        = hipcc
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
CFLAGS := $(EXTRA_CFLAGS) -I$(MPI_ROOT)/include -std=c++11 -Wall -fPIE

# Linker Flags
LDFLAGS = -L$(MPI_ROOT)/lib -lmpi -lmpi_cxx \
	  -L$(HIPBLAS_ROOT)/lib -lhipblas

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

$(program): $(obj)
	$(LD) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(MPI_BIN)/mpirun -n 4 ./$(program) --num_vector 4000 --num_field 90000 --num_iterations 30

smoke: $(program)
	$(MPI_BIN)/mpirun -n 4 ./$(program) --num_vector 4000 --num_field 90000 --num_iterations 10
