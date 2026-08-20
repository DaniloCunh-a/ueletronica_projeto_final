#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
IN_MD="${1:-$ROOT_DIR/entrega/report/paper_final.md}"
OUT_PDF="${2:-$ROOT_DIR/entrega/report/paper_final.pdf}"

if [ ! -f "$IN_MD" ]; then
  echo "Erro: arquivo de entrada nao encontrado: $IN_MD"
  exit 2
fi

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Erro: pandoc nao encontrado. Instale ou rode dentro de ambiente com pandoc."
  exit 2
fi

pandoc "$IN_MD" -o "$OUT_PDF"
echo "PDF gerado em: $OUT_PDF"
