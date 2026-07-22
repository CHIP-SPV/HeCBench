#===============================================================================
# Top-level delegating Makefile for daphne-hip (points2image).
# The real Makefile lives in src/points2image; forward the common targets.
#===============================================================================

BENCH_DIR = src/points2image

.PHONY: all clean smoke

all:
	$(MAKE) -C $(BENCH_DIR) all

clean:
	$(MAKE) -C $(BENCH_DIR) clean

smoke:
	$(MAKE) -C $(BENCH_DIR) smoke
