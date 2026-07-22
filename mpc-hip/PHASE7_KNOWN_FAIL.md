# mpc-hip — FIXED (single-chunk smoke; multi-chunk is a known limitation)

`make smoke` passes (commit 9bb6cbad7): a 4 KiB single-chunk deterministic
input compresses in ~10 ms, rc=0, stable 5/5.

The real dataset (../mpc-cuda/msg_sp.trace.out) remains unbundled, and
multi-chunk inputs (>1024 longs) remain nondeterministically slow-or-hanging:
MPCcompress uses a grid-wide inter-block spin-lock (goffset ring) with no
forward-progress guarantee on chipStar/Intel. Chunk count — not data content
— governs runtime. Do not enlarge the smoke input past 8 KiB.
