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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../page-rank-cuda

# Linker Flags
, := ,
LLVM_OMP_DIR := $(shell $(CC) --print-file-name libomp.so 2>/dev/null | xargs dirname 2>/dev/null)
LDFLAGS = -fopenmp $(if $(LLVM_OMP_DIR),-Wl$(,)-rpath$(,)$(LLVM_OMP_DIR))

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

%.o: %.cu ../page-rank-cuda/reference.h Makefile 
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) -n 20000 -i 100

smoke: $(program)
	$(LAUNCHER) ./$(program) -n 2000 -i 10
