#!/usr/bin/env python3
# Generate a tiny valid si-hip dataset (.bin) for `make smoke`.
#
# The upstream generator (src/generate_dataset.cpp) depends on
# boost/dynamic_bitset.hpp, which is not part of this benchmark and may be
# absent. `main` only needs a dataset file in the format below, so we emit a
# minimal one directly. This exercises the real GPU path (hipBLAS Sgemm).
#
# Binary layout (little-endian), matching include/io.hpp readDataset():
#   uint32 cardinality (k = number of sets)
#   uint32 universe
#   uint64 totalElements
#   k   * uint32 set sizes
#   sum * uint32 elements (grouped set-by-set, values in [1, universe])
import struct
import sys

def main():
    out = sys.argv[1] if len(sys.argv) > 1 else "smoke_dataset.bin"

    universe = 8
    # Sets sorted by ascending size (as the upstream _asc_ file would be).
    sets = [
        [1, 2],
        [2, 3, 4],
        [1, 4, 5],
        [5, 6, 7, 8],
    ]
    k = len(sets)
    total = sum(len(s) for s in sets)

    with open(out, "wb") as f:
        f.write(struct.pack("<I", k))
        f.write(struct.pack("<I", universe))
        f.write(struct.pack("<Q", total))
        for s in sets:
            f.write(struct.pack("<I", len(s)))
        for s in sets:
            for e in s:
                assert 1 <= e <= universe, "element out of universe range"
                f.write(struct.pack("<I", e))

    print("wrote {} (k={}, universe={}, totalElements={})".format(out, k, universe, total))

if __name__ == "__main__":
    main()
