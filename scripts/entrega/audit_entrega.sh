#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_FILE="${1:-$ROOT_DIR/entrega/verification/final_delivery_checklist.md}"

PASS_COUNT=0
FAIL_COUNT=0
HAS_RG=0
if command -v rg >/dev/null 2>&1; then
  HAS_RG=1
fi

status_icon() {
  if [ "$1" = "ok" ]; then
    printf "OK"
  else
    printf "FAIL"
  fi
}

check_file() {
  local path="$1"
  if [ -f "$ROOT_DIR/$path" ]; then
    PASS_COUNT=$((PASS_COUNT + 1))
    printf "ok|%s|presente\n" "$path"
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf "fail|%s|ausente\n" "$path"
  fi
}

extract_first_match() {
  local pattern="$1"
  local file="$2"
  if [ -f "$file" ]; then
    if [ "$HAS_RG" -eq 1 ]; then
      rg -o --no-filename "$pattern" "$file" | head -n1 || true
    else
      grep -E -o "$pattern" "$file" | head -n1 || true
    fi
  else
    true
  fi
}

# Required artifacts inferred from challenge PDF + repository delivery guides.
REQUIRED_FILES=(
  "entrega/README.md"
  "entrega/schematic/README.md"
  "entrega/sim_pre/biopotential_chain_prelayout.spice"
  "entrega/sim_pre/biopotential_chain_prelayout.log"
  "entrega/layout/biodiff_top.mag"
  "entrega/layout/biodiff.gds"
  "entrega/layout/biodiff_top_build.tcl"
  "entrega/pex_post/biodiff_extracted.spice"
  "entrega/pex_post/biopotential_chain_postlayout_clean.spice"
  "entrega/pex_post/biopotential_chain_postlayout_clean.log"
  "entrega/pex_post/pre_vs_post_table.md"
  "entrega/verification/lvs_report.txt"
  "entrega/verification/drc_report.txt"
  "entrega/verification/verification_summary.md"
  "entrega/report/resultados_analise_critica.md"
)

MANDATORY_FIGURES=(
  "entrega/layout/layout_full.png"
  "entrega/layout/layout_zoom_inputs.png"
  "entrega/sim_pre/pre_ac_gain.png"
  "entrega/sim_pre/pre_tran_vin_vout.png"
  "entrega/pex_post/post_ac_gain.png"
  "entrega/pex_post/post_tran_vout.png"
  "entrega/verification/drc_result.png"
  "entrega/verification/lvs_result.png"
)

mkdir -p "$(dirname "$OUT_FILE")"

TMP_MAIN="$(mktemp)"
TMP_FIG="$(mktemp)"
trap 'rm -f "$TMP_MAIN" "$TMP_FIG"' EXIT

for p in "${REQUIRED_FILES[@]}"; do
  check_file "$p" >> "$TMP_MAIN"
done

for p in "${MANDATORY_FIGURES[@]}"; do
  check_file "$p" >> "$TMP_FIG"
done

LVS_OK="não"
if [ -f "$ROOT_DIR/entrega/verification/lvs_report.txt" ] && \
  { [ "$HAS_RG" -eq 1 ] && rg -q "Final result: Circuits match uniquely" "$ROOT_DIR/entrega/verification/lvs_report.txt" || \
    [ "$HAS_RG" -eq 0 ] && grep -q "Final result: Circuits match uniquely" "$ROOT_DIR/entrega/verification/lvs_report.txt"; }; then
  LVS_OK="sim"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

DRC_TOTAL="N/A"
if [ -f "$ROOT_DIR/entrega/verification/drc_report.txt" ]; then
  DRC_TOTAL_RAW="$(extract_first_match 'Total DRC errors found:\s*[0-9]+' "$ROOT_DIR/entrega/verification/drc_report.txt")"
  DRC_TOTAL="${DRC_TOTAL_RAW##*: }"
fi

DRC_OK="não"
if [ "$DRC_TOTAL" = "0" ]; then
  DRC_OK="sim"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

mapfile -t REPORT_PDFS < <(find "$ROOT_DIR/entrega/report" -maxdepth 1 -type f -name '*.pdf' -printf '%f\n' | sort)
if [ "${#REPORT_PDFS[@]}" -gt 0 ]; then
  REPORT_OK="sim"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  REPORT_OK="não"
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

{
  echo "# Checklist Final de Entrega"
  echo
  echo "Gerado automaticamente por \`scripts/entrega/audit_entrega.sh\`."
  echo
  echo "## Resumo"
  echo "- Itens aprovados: **$PASS_COUNT**"
  echo "- Itens pendentes: **$FAIL_COUNT**"
  echo
  echo "## 1) Artefatos Base (PDF + READMEs)"
  echo "| Status | Arquivo | Observação |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    printf "| %s | \`%s\` | %s |\n" "$(status_icon "$s")" "$p" "$obs"
  done < "$TMP_MAIN"
  echo
  echo "## 2) Figuras Obrigatórias"
  echo "| Status | Figura | Observação |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    printf "| %s | \`%s\` | %s |\n" "$(status_icon "$s")" "$p" "$obs"
  done < "$TMP_FIG"
  echo
  echo "## 3) Verificações Físicas"
  echo "| Critério | Status | Evidência |"
  echo "|---|---|---|"
  printf "| LVS match uniquely | %s | \`entrega/verification/lvs_report.txt\` |\n" "$( [ "$LVS_OK" = "sim" ] && echo 'OK' || echo 'FAIL' )"
  printf "| DRC clean (0 erros) | %s | Total atual: \`%s\` em \`entrega/verification/drc_report.txt\` |\n" "$( [ "$DRC_OK" = "sim" ] && echo 'OK' || echo 'FAIL' )" "$DRC_TOTAL"
  echo
  echo "## 4) Paper Final"
  if [ "$REPORT_OK" = "sim" ]; then
    echo "- OK: PDF encontrado(s):"
    for pdf in "${REPORT_PDFS[@]}"; do
      echo "  - \`entrega/report/$pdf\`"
    done
  else
    echo "- FAIL: Nenhum PDF encontrado em \`entrega/report/\`."
  fi
  echo
  echo "## 5) Pendências Prioritárias"
  [ "$DRC_OK" = "sim" ] || echo "- Fechar DRC para total **0** erros."
  [ "$REPORT_OK" = "sim" ] || echo "- Gerar o paper final em PDF (Technical Paper)."
  if { [ "$HAS_RG" -eq 1 ] && rg -q '^fail\|' "$TMP_FIG" || [ "$HAS_RG" -eq 0 ] && grep -q '^fail|' "$TMP_FIG"; }; then
    echo "- Gerar e anexar todas as 8 figuras obrigatórias da entrega."
  fi
} > "$OUT_FILE"

echo "Checklist salvo em: $OUT_FILE"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi
