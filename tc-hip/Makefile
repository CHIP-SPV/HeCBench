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

source = tc.cu main.cu

obj = $(source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../mis-cuda

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

%.o: %.cu tc.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)
	# the tc.cu driver writes a TSV next to the input graph; remove it too
	rm -f ../mis-cuda/internet.egr.o.*

# Full run uses the recommended internet.egr input.
run: $(program)
	$(LAUNCHER) ./$(program) ../mis-cuda/internet.egr 100

# Smoke: internet.egr is small (avg degree ~3.1) so it runs in well under a
# second and is verified against the CPU reference.
smoke: $(program)
	$(LAUNCHER) ./$(program) ../mis-cuda/internet.egr 100
