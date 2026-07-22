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

inc = ../cmp-cuda

obj = main.o reference.o su_cdp.o su_gather.o su_trace.o log.o parser.o

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I$(inc)

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

log.o : $(inc)/log.cpp $(inc)/log.hpp
	$(CC) $(CFLAGS) -c $< -o $@

parser.o: $(inc)/parser.cpp $(inc)/parser.hpp  
	$(CC) $(CFLAGS) -c $< -o $@

su_cdp.o : $(inc)/su_cdp.cpp $(inc)/su_cdp.hpp $(inc)/log.hpp
	$(CC) $(CFLAGS) -c $< -o $@

su_gather.o : $(inc)/su_gather.cpp $(inc)/su_gather.hpp $(inc)/log.hpp $(inc)/su_trace.hpp
	$(CC) $(CFLAGS) -c $< -o $@

su_trace.o : $(inc)/su_trace.cpp $(inc)/su_trace.hpp $(inc)/log.hpp
	$(CC) $(CFLAGS) -c $< -o $@

main.o : main.cu $(inc)/log.hpp $(inc)/utils.hpp $(inc)/parser.hpp $(inc)/su_gather.hpp
	$(CC) $(CFLAGS) -c $< -o $@

reference.o : $(inc)/reference.cpp $(inc)/utils.hpp
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

# Seismic input: the original UNICAMP hpg-cepetro dataset, mirrored by the
# derived FPGA study repo. Fetched on first use (94 MB).
CMP_DATA = ../cmp-cuda/data/simple-synthetic.su
$(CMP_DATA):
	mkdir -p $(dir $@)
	wget -q -O $@ https://raw.githubusercontent.com/menotti/oil_gas_fpga/master/datasets/simple-synthetic.su

run: $(program) $(CMP_DATA)
	$(LAUNCHER) ./$(program) -c0 1.98e-7 -c1 1.77e-6 -nc 5 -aph 600 -tau 0.002 -v 2 -i $(CMP_DATA)

smoke: $(program) $(CMP_DATA)
	$(LAUNCHER) ./$(program) -c0 1.98e-7 -c1 1.77e-6 -nc 5 -aph 600 -tau 0.002 -v 2 -i $(CMP_DATA)
