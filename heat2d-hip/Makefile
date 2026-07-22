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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall

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

$(program): $(obj) Makefile
	$(CC) $(CFLAGS) $(obj) -o $@ $(LDFLAGS)

%.o: %.cu defs.h io.c lapl_ss.c Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj) data.txt smoke_data.txt result.dat

# main requires a binary float32 input file of Lx*Ly elements (see mkinit.py)
data.txt: mkinit.py
	python3 mkinit.py 4096 4096 data.txt

smoke_data.txt: mkinit.py
	python3 mkinit.py 256 256 smoke_data.txt

run: $(program) data.txt
	$(LAUNCHER) ./$(program) 4096 4096 1000 data.txt

smoke: $(program) smoke_data.txt
	$(LAUNCHER) ./$(program) 256 256 1 smoke_data.txt
