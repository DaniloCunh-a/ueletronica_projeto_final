#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAG_FILE="${1:-$ROOT_DIR/entrega/layout/biodiff_top.mag}"
OUT_DIR="${2:-$ROOT_DIR/entrega/verification}"
RCFILE="${MAGIC_RCFILE:-/opt/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc}"
TCL_SCRIPT="$ROOT_DIR/scripts/entrega/run_drc_detailed.tcl"

if ! command -v magic >/dev/null 2>&1; then
  echo "Erro: comando 'magic' nao encontrado. Execute dentro do container da disciplina."
  exit 2
fi

if [ ! -f "$MAG_FILE" ]; then
  echo "Erro: layout nao encontrado em $MAG_FILE"
  exit 2
fi

if [ ! -f "$TCL_SCRIPT" ]; then
  echo "Erro: script Tcl nao encontrado em $TCL_SCRIPT"
  exit 2
fi

mkdir -p "$OUT_DIR"

ABS_MAG_FILE="$(cd "$(dirname "$MAG_FILE")" && pwd)/$(basename "$MAG_FILE")"
ABS_OUT_DIR="$(cd "$OUT_DIR" && pwd)"

export DRC_CELL_PATH="$ABS_MAG_FILE"
export DRC_OUT_DETAIL="$ABS_OUT_DIR/drc_report_detailed.txt"
export DRC_OUT_SUMMARY="$ABS_OUT_DIR/drc_summary_by_rule.tsv"
export DRC_OUT_RAW="$ABS_OUT_DIR/drc_listall_raw.txt"

magic -dnull -noconsole -rcfile "$RCFILE" "$TCL_SCRIPT" \
  | tee "$ABS_OUT_DIR/drc_magic_stdout.log"

if command -v rg >/dev/null 2>&1; then
  if rg -q "^Total DRC errors found:" "$ABS_OUT_DIR/drc_magic_stdout.log"; then
    rg "^Total DRC errors found:" "$ABS_OUT_DIR/drc_magic_stdout.log" | tail -n1
  else
    echo "Aviso: total de erros DRC nao encontrado no stdout do Magic."
  fi
else
  if grep -q "^Total DRC errors found:" "$ABS_OUT_DIR/drc_magic_stdout.log"; then
    grep "^Total DRC errors found:" "$ABS_OUT_DIR/drc_magic_stdout.log" | tail -n1
  else
    echo "Aviso: total de erros DRC nao encontrado no stdout do Magic."
  fi
fi

echo "Relatorios gerados em: $ABS_OUT_DIR"
