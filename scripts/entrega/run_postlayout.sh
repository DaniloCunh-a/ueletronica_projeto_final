#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SIM_DIR="$ROOT_DIR/shared_xserver/projetos/simulations"
TB_FILE="biopotential_chain_postlayout_clean.spice"
LOG_FILE="biopotential_chain_postlayout_clean.log"

cd "$SIM_DIR"
ngspice -b -o "$LOG_FILE" "$TB_FILE"
echo "OK: $SIM_DIR/$LOG_FILE"
