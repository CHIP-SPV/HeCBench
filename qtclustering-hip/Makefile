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

cpp_source = main.cpp Option.cpp OptionParser.cpp comm.cpp libdata.cpp
hip_source = QTC.cu 

obj = $(cpp_source:.cpp=.o) $(hip_source:.cu=.o)

#===============================================================================
# Sets Flags
#===============================================================================

# Standard Flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall 

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

main.o: main.cpp OptionParser.h Utility.h 
	$(CC) $(CFLAGS) -c $< -o $@

comm.o: comm.cpp comm.h
	$(CC) $(CFLAGS) -c $< -o $@

libdata.o: libdata.cpp libdata.h
	$(CC) $(CFLAGS) -c $< -o $@

Option.o: Option.cpp Option.h 
	$(CC) $(CFLAGS) -c $< -o $@

OptionParser.o: OptionParser.cpp OptionParser.h Utility.h
	$(CC) $(CFLAGS) -c $< -o $@

QTC.o: QTC.cu hipcommon.h qtclib.h OptionParser.h libdata.h \
       tuningParameters.h comm.h kernels_compact_storage.h kernels_common.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj)

run: $(program)
	$(LAUNCHER) ./$(program) --Verbose
	#./$(program) --SaveOutput

# Smallest fast invocation: size 1 is the minimum supported problem size
# (4096 points). PointCount is overridden by the size switch, so --size 1 is
# the fastest run that exercises all kernels and exits 0 (~1s).
smoke: $(program)
	$(LAUNCHER) ./$(program) --size 1 --Verbose
