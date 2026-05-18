#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SIM_DIR="$BASE_DIR/projetos/simulations"
TB_FILE="biopotential_chain_postlayout_clean.spice"
LOG_FILE="biopotential_chain_postlayout_clean.log"

if ! command -v ngspice >/dev/null 2>&1; then
  echo "ERRO: ngspice não encontrado neste ambiente."
  echo "Execute dentro do container unic-cass-tools (make start)."
  exit 127
fi

cd "$SIM_DIR"
ngspice -b -o "$LOG_FILE" "$TB_FILE"
echo "OK: $SIM_DIR/$LOG_FILE"
