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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../laplace-cuda

# Linker Flags
LDFLAGS = 

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
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu timer.h  ../laplace-cuda/kernels.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj) main-smoke main-smoke.o temperature.dat

run: $(program)
	$(LAUNCHER) ./$(program)

# Smoke uses a smaller grid (NUM=256, the minimum for the launch geometry with
# BLOCK_SIZE=128). At the default NUM=1024 the single-threaded CPU reference
# needs the same ~27k SOR sweeps as the GPU and runs 5-15 minutes; at 256 the
# whole run (GPU + CPU reference + full verification) completes in seconds.
main-smoke.o: main.cu timer.h ../laplace-cuda/kernels.h
	$(CC) $(CFLAGS) -DNUM=256 -c $< -o $@

main-smoke: main-smoke.o
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

smoke: main-smoke
	$(LAUNCHER) ./main-smoke
