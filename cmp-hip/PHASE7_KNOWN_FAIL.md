# cmp-hip — FIXED (dataset located)

`make smoke` passes: rc=0, GPU vs CPU reference error rates str=0.0 stk=0.0
(ctr=7.75e-05 = float argmax tie-breaking, not a correctness failure).

The missing seismic input is the original UNICAMP hpg-cepetro dataset;
fetched from https://raw.githubusercontent.com/menotti/oil_gas_fpga/master/datasets/simple-synthetic.su
(94,281,600 bytes; 9200 traces, ns=2502, dt=2000us — matches the Makefile's
documented parameters exactly). Kept untracked at cmp-cuda/data/; re-fetch on
a fresh checkout. No source or Makefile changes were needed.
Verified on chipStar 2026.07.20.
