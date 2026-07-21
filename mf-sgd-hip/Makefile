# Top-level delegating Makefile for the HecBench sweep.
# The real Makefile lives in src/; forward the standard targets to it.

.PHONY: all clean smoke

all:
	$(MAKE) -C src

clean:
	$(MAKE) -C src clean

smoke:
	$(MAKE) -C src smoke
