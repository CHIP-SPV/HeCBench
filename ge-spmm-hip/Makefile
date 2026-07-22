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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../ge-spmm-cuda

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

%.o: %.cu ../ge-spmm-cuda/kernels.h ../ge-spmm-cuda/util/*.hpp Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

# SuiteSparse/SNAP amazon0302 matrix, fetched on first use (4.6 MB tar.gz).
SPMM_MTX = ../ge-spmm-cuda/data/snap/amazon0302/amazon0302.mtx
$(SPMM_MTX):
	mkdir -p $(dir $@)
	wget -q -O - https://suitesparse-collection-website.herokuapp.com/MM/SNAP/amazon0302.tar.gz | tar -xz -C $(dir $@) --strip-components=1

run: $(program) $(SPMM_MTX)
	$(LAUNCHER) ./$(program) $(SPMM_MTX) 8 1000

smoke: $(program) $(SPMM_MTX)
	$(LAUNCHER) ./$(program) $(SPMM_MTX) 8 1000
