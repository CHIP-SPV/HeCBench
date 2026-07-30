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

# hipBLAS/MKLShim live in the HIP SDK prefix (derived from hipcc on PATH);
# override for a split installation.
SDK_PREFIX := $(patsubst %/bin/hipcc,%,$(shell command -v $(CC)))
HIPBLAS_PATH ?= $(SDK_PREFIX)
MKLSHIM_PATH ?= $(SDK_PREFIX)

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall -I$(HIPBLAS_PATH)/include

# Linker Flags
LDFLAGS = -L$(HIPBLAS_PATH)/lib -L$(MKLSHIM_PATH)/lib -lhipblas -lMKLShim

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
	$(LAUNCHER) ./$(program) 16384 16384 200

smoke: $(program)
	$(LAUNCHER) ./$(program) 64 64 5
