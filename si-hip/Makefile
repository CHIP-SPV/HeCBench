# Top-level smoke wrapper for the CMake-based si-hip benchmark (chipStar).
#
# Upstream is a CMake project that FetchContent-clones cxxopts / fmt / zipf /
# progressbar. This Makefile configures and builds the GPU 'main' target, then
# runs it on a tiny generated dataset so `make smoke` exits 0 quickly.
#
# Note: the upstream 'generate_dataset' tool depends on boost/dynamic_bitset.hpp
# (not shipped and not required by 'main'); we build only 'main' and synthesize a
# minimal dataset with gen_smoke_dataset.py instead.

HIPCC     ?= hipcc
BUILD_DIR ?= build
LAUNCHER  ?=

# chipStar install prefix, derived from hipcc location (…/bin/hipcc -> …).
CHIP_PREFIX ?= $(shell dirname $(dir $(shell command -v $(HIPCC))))

SMOKE_DATA := smoke_dataset.bin

.PHONY: all build smoke clean

all: main

$(BUILD_DIR)/main:
	cmake -S . -B $(BUILD_DIR) \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_CXX_COMPILER=$(HIPCC) \
	  -DCMAKE_PREFIX_PATH="$(CHIP_PREFIX)" \
	  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
	cmake --build $(BUILD_DIR) --target main -j

main: $(BUILD_DIR)/main
	cp -f $(BUILD_DIR)/main ./main

$(SMOKE_DATA): gen_smoke_dataset.py
	python3 gen_smoke_dataset.py $(SMOKE_DATA)

# Small/fast GPU run: tiny 4-set / universe-8 dataset. Exits 0 on success.
smoke: main $(SMOKE_DATA)
	$(LAUNCHER) ./main --input $(SMOKE_DATA)

clean:
	rm -rf $(BUILD_DIR) ./main $(SMOKE_DATA)
