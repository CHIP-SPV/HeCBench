#===============================================================================
# User Options
#===============================================================================

# Compiler can be set below, or via environment variable
CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no

#===============================================================================
# Program name & source code list
#===============================================================================

program = main

source = main.cu Filter.cu

obj = $(source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++14 -Wall -I../stsg-cuda

# Linker Flags
LDFLAGS = -lgdal

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

Filter.o: ../stsg-cuda/Filter.cu Makefile
	$(CC) $(CFLAGS) -c $< -o $@

main.o: main.cu ../stsg-cuda/Filter.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

# TestData: fetched from github.com/HPSCIL/cuSTSG and cropped to 150x150 on
# first use (needs python GDAL bindings; see fetch_testdata.py).
STSG_DATA = ../stsg-cuda/TestData/NDVI/NDVI_test_2001
$(STSG_DATA):
	python3 fetch_testdata.py

run: $(program) $(STSG_DATA)
	./$(program) example.txt

smoke: $(program) $(STSG_DATA)
	$(LAUNCHER) ./$(program) example.txt
