# assert-hip — FIXED (chipStar 2026.07.20)

`make smoke` passes rc=0 on chipStar 2026.07.20 (full-suite sweep +
clean-build verification). The earlier device-assert hang
(SPV_EXT_relaxed_printf_string_address_space unsupported) no longer
reproduces on the current toolchain.
