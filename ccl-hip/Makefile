#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no
MPI_ROOT  = /usr/lib/x86_64-linux-gnu/openmpi
# chipRCCL (github.com/CHIP-SPV/chipRCCL) supports single-rank communicators
# only (one visible HIP device), so launch a single rank. Cloned and built on
# first use at the pinned commit below.
LAUNCHER ?= /usr/bin/mpirun -n 1
CHIPRCCL_DIR    = chipRCCL
CHIPRCCL_COMMIT = bfd6e9e6cd9de6f0518a6174c9d282eaf5dd4fd5

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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -I$(MPI_ROOT)/include -I$(CHIPRCCL_DIR)/include -Wall

# Linker Flags (librccl.a from chipRCCL provides the used NCCL subset)
LDFLAGS = $(CHIPRCCL_DIR)/lib/librccl.a -L$(MPI_ROOT)/lib -Wl,-rpath,$(MPI_ROOT)/lib -lmpi

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

$(program): $(obj) Makefile $(CHIPRCCL_DIR)/lib/librccl.a
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

$(obj): | $(CHIPRCCL_DIR)/lib/librccl.a

%.o: %.cu Makefile
	$(CC) $(CFLAGS) -c $< -o $@

$(CHIPRCCL_DIR)/lib/librccl.a:
	test -d $(CHIPRCCL_DIR) || git clone https://github.com/CHIP-SPV/chipRCCL $(CHIPRCCL_DIR)
	cd $(CHIPRCCL_DIR) && git checkout -q $(CHIPRCCL_COMMIT)
	$(MAKE) -C $(CHIPRCCL_DIR) CC=$(CC)

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 50

smoke: $(program)
	$(LAUNCHER) ./$(program) 1
