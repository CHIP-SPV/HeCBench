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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I. -I../testSNAP-omp \
          -DREFDATA_TWOJ=14

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

%.o: %.cu snap.h utils.cu
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

../testSNAP-omp/refdata_2J14_W.h: ../testSNAP-omp/refdata.tar.gz
	cd ../testSNAP-omp && tar xzf refdata.tar.gz

run: $(program) ../testSNAP-omp/refdata_2J14_W.h
	$(LAUNCHER) ./$(program) --nsteps 15

smoke: $(program) ../testSNAP-omp/refdata_2J14_W.h
	$(LAUNCHER) ./$(program) --nsteps 5
