#!/usr/bin/env bash
# Usage: add_smoke.sh <dir> <smoke_args>
# Appends smoke target if not present. smoke_args is everything after ./main
set -u
dir="$1"
shift
args="$*"
mk="$dir/Makefile"
if [ ! -f "$mk" ]; then echo "no makefile $mk"; exit 1; fi
if grep -qE '^smoke:' "$mk"; then echo "already has smoke: $dir"; exit 0; fi
cat >> "$mk" <<EOF

smoke: \$(program)
	\$(LAUNCHER) ./\$(program) $args
EOF
echo "added smoke to $dir: $args"
