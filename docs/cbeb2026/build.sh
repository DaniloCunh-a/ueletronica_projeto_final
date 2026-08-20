#!/usr/bin/env bash
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE"

export TEXINPUTS="$HERE/vendor/IEEEtran//:${TEXINPUTS:-}"

pdflatex -interaction=nonstopmode -halt-on-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error main.tex
cp main.pdf ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf

pages="$(pdfinfo main.pdf | sed -n 's/^Pages:[[:space:]]*//p')"
if [[ -z "$pages" || "$pages" -lt 4 || "$pages" -gt 8 ]]; then
  echo "ERRO: o PDF deve ter de 4 a 8 páginas; obtido: ${pages:-desconhecido}." >&2
  exit 1
fi

echo "OK: $HERE/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf ($pages páginas)"
