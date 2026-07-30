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
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall -I../mpc-cuda

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

%.o: %.cu ../mpc-cuda/utils.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(program) $(obj) *.txt fpc smoke_input.bin

run: $(program)
        # compression
	$(LAUNCHER) ./$(program) ../mpc-cuda/msg_sp.trace.out 1
        # decompression
	$(LAUNCHER) ./$(program) compression.txt
	diff ../mpc-cuda/msg_sp.trace.out decompression.txt

# Fast smoke test: the real dataset (../mpc-cuda/msg_sp.trace.out) is a large
# external download and is not bundled. Use a small SINGLE-CHUNK input (<=1024
# longs / <=8 KiB). MPCcompress uses a grid-wide inter-block spin-lock (the
# goffset ring) across chunks, which has no forward-progress guarantee on
# some HIP runtimes/devices: multi-chunk inputs co-schedule nondeterministically and run
# from ~15 ms to an indefinite hang. A single chunk avoids that path entirely
# and compresses in ~10 ms regardless of content. 4 KiB = 512 longs = 1 chunk.
smoke: $(program)
	head -c 4096 /dev/zero > smoke_input.bin
	$(LAUNCHER) ./$(program) smoke_input.bin 1
