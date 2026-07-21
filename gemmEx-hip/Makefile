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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../gemmEx-cuda

# Linker Flags (hipcc adds -L<install>/lib where libhipblas lives)
LDFLAGS = -lhipblas

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

%.o: %.cu ../gemmEx-cuda/utils.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) 4096 4096 4096 100

# Smaller GEMM for the smoke: 4096^3 x100 x4 dtypes takes >200s on B570.
# Note: fp16 prints inf and int8 prints zeros — H4I-HipBLAS backend gaps
# (the bench prints compare values by design and does not verify-exit).
smoke: $(program)
	$(LAUNCHER) ./$(program) 1024 1024 1024 10
