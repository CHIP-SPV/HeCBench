#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no

# Parboil tpacf "large" dataset: 10391 points per file (Datapnts.1, Randompnts.1-100)
POINTS    = 10391
DATAPARS  = -d ../tpacf-cuda/data/small/Datapnts.1 -p $(POINTS)
RANDPARS  = -r ../tpacf-cuda/data/small/Randompnts -n 100 -q $(POINTS)
ANALPARS  = -b 5 -l 1 -u 10000 -a -j 10
OUTFILE   = ./small_results_test_g200.dat

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = main.c args.c compute.cu

obj = main.o args.o compute.o

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall -I../tpacf-cuda

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

main.o: ../tpacf-cuda/main.c ../tpacf-cuda/args.h Makefile
	$(CC) -x hip $(CFLAGS) -c $< -o $@

args.o: ../tpacf-cuda/args.c ../tpacf-cuda/args.h Makefile
	$(CC) -x hip $(CFLAGS) -c $< -o $@

compute.o: compute.cu ../tpacf-cuda/args.h ../tpacf-cuda/model_io.cu \
           ACF_kernel.cu histogram_kernel.cu Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj) $(OUTFILE)

# Parboil 2.5 tpacf large dataset (UIUC IMPACT; the original NCSA URL is
# dead), fetched from the palmer-dabbelt/parboil mirror on first use:
# Datapnts.1 + Randompnts.1..100, 10391 "ra dec" points each.
TPACF_DIR = ../tpacf-cuda/data/small
TPACF_URL = https://raw.githubusercontent.com/palmer-dabbelt/parboil/master/datasets/tpacf/large/input
$(TPACF_DIR)/Datapnts.1:
	mkdir -p $(TPACF_DIR)
	wget -q -O $@ $(TPACF_URL)/Datapnts.1
	for i in $$(seq 1 100); do wget -q -O $(TPACF_DIR)/Randompnts.$$i $(TPACF_URL)/Randompnts.$$i; done

run: $(program) $(TPACF_DIR)/Datapnts.1
	./$(program) $(DATAPARS) $(RANDPARS) $(ANALPARS) -o $(OUTFILE)

smoke: $(program) $(TPACF_DIR)/Datapnts.1
	./$(program) -d $(TPACF_DIR)/Datapnts.1 -p 4096 -r $(TPACF_DIR)/Randompnts -n 5 -q 4096 -b 5 -l 1 -u 10000 -a -j 2 -o ./smoke.dat
