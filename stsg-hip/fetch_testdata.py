#!/usr/bin/env python3
"""Fetch the cuSTSG TestData rasters and crop them for the stsg smoke.

The upstream dataset (github.com/HPSCIL/cuSTSG, TestData/) is 18 years of
1200x1200x23-band MODIS NDVI Int16 + Reliability Byte GeoTIFFs (~2.4 GB).
The full scenes exceed Arc B570 memory (the per-pixel window buffers alone
are ~1.6 GB at 300x300), so each raster is cropped to the 150x150 subwindow
at (400,400) — the size the benchmark's example.txt expects.

Requires the GDAL python bindings matching the system libgdal:
    pip install --user gdal==$(gdal-config --version)
Full-size intermediates are deleted after cropping (~27 MB kept total).
"""
import os
import sys
import urllib.request

try:
    from osgeo import gdal
except ImportError:
    sys.exit("ERROR: python GDAL bindings missing. Install with:\n"
             "  pip install --user gdal==$(gdal-config --version)")

URL = "https://raw.githubusercontent.com/HPSCIL/cuSTSG/master/TestData"
DST = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                   "..", "stsg-cuda", "TestData")
YEARS = [int(y) for y in sys.argv[1:]] or list(range(2001, 2019))

gdal.UseExceptions()
for kind in ("NDVI", "Reliability"):
    os.makedirs(os.path.join(DST, kind), exist_ok=True)
    for year in YEARS:
        name = f"{kind}_test_{year}"
        out = os.path.join(DST, kind, name)
        if os.path.exists(out):
            print(f"have {name}")
            continue
        full = out + ".full"
        print(f"fetch {name} ...", flush=True)
        urllib.request.urlretrieve(f"{URL}/{kind}/{name}", full)
        gdal.Translate(out, full, srcWin=[400, 400, 150, 150])
        os.remove(full)
        print(f"cropped {name}")
print("done")
