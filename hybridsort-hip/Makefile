CC        = hipcc
OPTIMIZE  = yes
DEBUG     = no
LAUNCHER  =

# Standard flags
CFLAGS := $(EXTRA_CFLAGS) -std=c++17 -Wall

# Linker flags
LDFLAGS = -lm

# Debug Flags
ifeq ($(DEBUG),yes)
  CFLAGS += -g #-DDEBUG
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  CFLAGS += -O3
endif


ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

ifdef TIMER
override TIMER = -DTIMER
endif

main: hybridsort.o bucketsort.o mergesort.o
	$(CC) $(CFLAGS) -o main $(VERIFY) $(OUTPUT) $(TIMER) \
		hybridsort.o bucketsort.o mergesort.o $(LDFLAGS)

hybridsort.o: hybridsort.cu bucketsort.h mergesort.h
	$(CC) $(CFLAGS) -o hybridsort.o -c hybridsort.cu

bucketsort.o: bucketsort.cu \
	kernel_bucketprefix.h \
	kernel_histogram.h \
	kernel_bucketcount.h \
       	kernel_bucketsort.h  
	$(CC) $(CFLAGS) -o bucketsort.o -c bucketsort.cu

mergesort.o: mergesort.cu mergesort.h kernel_mergeSortPass.h
	$(CC) $(CFLAGS) -o mergesort.o -c mergesort.cu

main-smoke: hybridsort.cu bucketsort.cu mergesort.cu mergesort.h bucketsort.h kernel_mergeSortPass.h kernel_histogram.h kernel_bucketcount.h kernel_bucketsort.h kernel_bucketprefix.h
	$(CC) $(CFLAGS) -DSMOKE -c hybridsort.cu -o hybridsort-smoke.o
	$(CC) $(CFLAGS) -DSMOKE -c bucketsort.cu -o bucketsort-smoke.o
	$(CC) $(CFLAGS) -DSMOKE -c mergesort.cu -o mergesort-smoke.o
	$(CC) $(CFLAGS) -DSMOKE -o main-smoke hybridsort-smoke.o bucketsort-smoke.o mergesort-smoke.o $(LDFLAGS)

run: main
	$(LAUNCHER) ./main r

smoke: main-smoke
	$(LAUNCHER) ./main-smoke r

clean:
	rm -f *.o main
