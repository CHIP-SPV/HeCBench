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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../clink-cuda

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

# OpenMP parallelizes the CPU reference() verification (../clink-cuda/reference.h),
# which otherwise runs serially over N*SAMPLE_TEST_LEN and dominates the runtime.
# rpath the toolchain's own libomp so the binary runs without LD_LIBRARY_PATH.
OMP_LIBDIR := $(dir $(shell $(CC) -print-file-name=libomp.so))
CFLAGS  += -fopenmp
LDFLAGS += -fopenmp -Wl,-rpath,$(OMP_LIBDIR)

#===============================================================================
# Targets to Build
#===============================================================================

$(program): $(obj) Makefile
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu ../clink-cuda/kernel.h ../clink-cuda/reference.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 10

smoke: $(program)
	$(LAUNCHER) ./$(program) 1
