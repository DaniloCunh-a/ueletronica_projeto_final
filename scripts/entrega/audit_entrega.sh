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

check_pattern() {
  local label="$1"
  local pattern="$2"
  local file="$3"

  if [ -f "$file" ] && \
    { [ "$HAS_RG" -eq 1 ] && rg -q "$pattern" "$file" || [ "$HAS_RG" -eq 0 ] && grep -Eq "$pattern" "$file"; }; then
    PASS_COUNT=$((PASS_COUNT + 1))
    printf "ok|%s|encontrado\n" "$label"
  else
    FAIL_COUNT=$((FAIL_COUNT + 1))
    printf "fail|%s|nao encontrado\n" "$label"
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

REQUIRED_FILES=(
  "entrega/README.md"
  "entrega/schematic/README.md"
  "entrega/schematic/biopotential_chain.sch"
  "entrega/schematic/sizing_table.md"
  "entrega/sim_pre/biopotential_chain_prelayout.spice"
  "entrega/sim_pre/biopotential_chain_prelayout.log"
  "entrega/sim_pre/pre_op.txt"
  "entrega/sim_pre/pre_metrics.md"
  "entrega/layout/biodiff_top.mag"
  "entrega/layout/biodiff.gds"
  "entrega/layout/biodiff_top_build.tcl"
  "entrega/pex_post/biodiff_extracted.spice"
  "entrega/pex_post/biopotential_chain_postlayout_clean.spice"
  "entrega/pex_post/biopotential_chain_postlayout_clean.log"
  "entrega/pex_post/post_metrics.md"
  "entrega/pex_post/pre_vs_post_table.md"
  "entrega/verification/lvs_report.txt"
  "entrega/verification/drc_report.txt"
  "entrega/verification/verification_summary.md"
  "entrega/report/resultados_analise_critica.md"
  "entrega/report/paper_final.md"
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

RECOMMENDED_FILES=(
  "entrega/schematic/schematic_overview.png"
)

mkdir -p "$(dirname "$OUT_FILE")"

TMP_MAIN="$(mktemp)"
TMP_FIG="$(mktemp)"
TMP_PAPER="$(mktemp)"
TMP_REC="$(mktemp)"
trap 'rm -f "$TMP_MAIN" "$TMP_FIG" "$TMP_PAPER" "$TMP_REC"' EXIT

for p in "${REQUIRED_FILES[@]}"; do
  check_file "$p" >> "$TMP_MAIN"
done

for p in "${MANDATORY_FIGURES[@]}"; do
  check_file "$p" >> "$TMP_FIG"
done

for p in "${RECOMMENDED_FILES[@]}"; do
  if [ -f "$ROOT_DIR/$p" ]; then
    printf "ok|%s|presente\n" "$p" >> "$TMP_REC"
  else
    printf "warn|%s|recomendado, mas ausente\n" "$p" >> "$TMP_REC"
  fi
done

LVS_OK="nao"
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

DRC_OK="nao"
if [ "$DRC_TOTAL" = "0" ]; then
  DRC_OK="sim"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  FAIL_COUNT=$((FAIL_COUNT + 1))
fi

PAPER_MD="$ROOT_DIR/entrega/report/paper_final.md"
check_pattern "Secao Introducao" '^## 1\. Introducao' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Secao Metodologia" '^## 2\. Metodologia' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Secao Resultados" '^## 3\. Resultados' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Secao Analise critica" '^## 4\. Analise critica' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Secao Conclusao" '^## 5\. Conclusao' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura pre AC" 'entrega/sim_pre/pre_ac_gain\.png' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura pre tran" 'entrega/sim_pre/pre_tran_vin_vout\.png' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura layout" 'entrega/layout/layout_full\.png' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura pos AC" 'entrega/pex_post/post_ac_gain\.png' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura DRC" 'entrega/verification/drc_result\.png' "$PAPER_MD" >> "$TMP_PAPER"
check_pattern "Figura LVS" 'entrega/verification/lvs_result\.png' "$PAPER_MD" >> "$TMP_PAPER"

mapfile -t REPORT_PDFS < <(find "$ROOT_DIR/entrega/report" -maxdepth 1 -type f -name '*.pdf' -printf '%f\n' | sort)
if [ "${#REPORT_PDFS[@]}" -gt 0 ]; then
  REPORT_OK="sim"
  PASS_COUNT=$((PASS_COUNT + 1))
else
  REPORT_OK="nao"
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
  echo "## 1) Artefatos Base"
  echo "| Status | Arquivo | Observacao |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    printf "| %s | \`%s\` | %s |\n" "$(status_icon "$s")" "$p" "$obs"
  done < "$TMP_MAIN"
  echo
  echo "## 2) Figuras Obrigatorias"
  echo "| Status | Figura | Observacao |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    printf "| %s | \`%s\` | %s |\n" "$(status_icon "$s")" "$p" "$obs"
  done < "$TMP_FIG"
  echo
  echo "## 3) Verificacoes Fisicas"
  echo "| Criterio | Status | Evidencia |"
  echo "|---|---|---|"
  printf "| LVS match uniquely | %s | \`entrega/verification/lvs_report.txt\` |\n" "$( [ "$LVS_OK" = "sim" ] && echo 'OK' || echo 'FAIL' )"
  printf "| DRC clean (0 erros) | %s | Total atual: \`%s\` em \`entrega/verification/drc_report.txt\` |\n" "$( [ "$DRC_OK" = "sim" ] && echo 'OK' || echo 'FAIL' )" "$DRC_TOTAL"
  echo
  echo "## 4) Cobertura do Paper"
  echo "| Status | Criterio | Observacao |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    printf "| %s | %s | %s |\n" "$(status_icon "$s")" "$p" "$obs"
  done < "$TMP_PAPER"
  echo
  echo "## 5) Paper Final (PDF)"
  if [ "$REPORT_OK" = "sim" ]; then
    echo "- OK: PDF encontrado(s):"
    for pdf in "${REPORT_PDFS[@]}"; do
      echo "  - \`entrega/report/$pdf\`"
    done
  else
    echo "- FAIL: Nenhum PDF encontrado em \`entrega/report/\`."
  fi
  echo
  echo "## 6) Itens Recomendados"
  echo "| Status | Arquivo | Observacao |"
  echo "|---|---|---|"
  while IFS='|' read -r s p obs; do
    if [ "$s" = "ok" ]; then
      printf "| OK | \`%s\` | %s |\n" "$p" "$obs"
    else
      printf "| WARN | \`%s\` | %s |\n" "$p" "$obs"
    fi
  done < "$TMP_REC"
  echo
  echo "## 7) Pendencias Prioritarias"
  [ "$DRC_OK" = "sim" ] || echo "- Fechar DRC para total **0** erros."
  [ "$REPORT_OK" = "sim" ] || echo "- Gerar o paper final em PDF (Technical Paper)."
  if { [ "$HAS_RG" -eq 1 ] && rg -q '^fail\|' "$TMP_FIG" || [ "$HAS_RG" -eq 0 ] && grep -q '^fail|' "$TMP_FIG"; }; then
    echo "- Gerar e anexar todas as 8 figuras obrigatorias da entrega."
  fi
  if { [ "$HAS_RG" -eq 1 ] && rg -q '^fail\|' "$TMP_PAPER" || [ "$HAS_RG" -eq 0 ] && grep -q '^fail|' "$TMP_PAPER"; }; then
    echo "- Garantir cobertura completa das secoes e figuras no paper final."
  fi
} > "$OUT_FILE"

echo "Checklist salvo em: $OUT_FILE"

if [ "$FAIL_COUNT" -gt 0 ]; then
  exit 1
fi
