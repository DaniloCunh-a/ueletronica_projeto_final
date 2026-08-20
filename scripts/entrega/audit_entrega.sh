#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT_FILE="${1:-$ROOT_DIR/entrega/verification/final_delivery_checklist.md}"
PDF_FILE="$ROOT_DIR/docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf"
PASS_COUNT=0
FAIL_COUNT=0
ROWS=()

pass() {
  PASS_COUNT=$((PASS_COUNT + 1))
  ROWS+=("OK|$1|$2")
}

fail() {
  FAIL_COUNT=$((FAIL_COUNT + 1))
  ROWS+=("FAIL|$1|$2")
}

check_file() {
  local relative="$1"
  if [[ -s "$ROOT_DIR/$relative" ]]; then
    pass "$relative" "presente e não vazio"
  else
    fail "$relative" "ausente ou vazio"
  fi
}

check_pattern() {
  local label="$1"
  local pattern="$2"
  local relative="$3"
  if [[ -f "$ROOT_DIR/$relative" ]] && rg -q "$pattern" "$ROOT_DIR/$relative"; then
    pass "$label" "confirmado em $relative"
  else
    fail "$label" "não confirmado em $relative"
  fi
}

REQUIRED_FILES=(
  "entrega/schematic/biopotential_chain.sch"
  "entrega/schematic/biopotential_chain_legacy_pre_reconciliation.sch"
  "entrega/schematic/schematic.png"
  "entrega/sim_pre/biopotential_chain_prelayout.spice"
  "entrega/sim_pre/pre_metrics_evidence.txt"
  "entrega/sim_pre/pre_metrics.md"
  "entrega/layout/biodiff_top.mag"
  "entrega/layout/biodiff.gds"
  "entrega/layout/layout_area.md"
  "entrega/pex_post/biodiff_extracted.spice"
  "entrega/pex_post/PEX_LIMITATIONS.md"
  "entrega/pex_post/biopotential_chain_postlayout_clean.spice"
  "entrega/pex_post/post_metrics_evidence.txt"
  "entrega/pex_post/post_metrics.md"
  "entrega/pex_post/pre_vs_post_table.md"
  "entrega/characterization/characterization_summary.md"
  "entrega/characterization/pvt_results.tsv"
  "entrega/characterization/pvt_screening.png"
  "entrega/verification/drc_report.txt"
  "entrega/verification/lvs_report.txt"
  "docs/tabela_comparativa_biodiff_cmos.md"
  "docs/resposta_revisores_v06.md"
  "docs/cbeb2026/main.tex"
  "docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf"
)

for relative in "${REQUIRED_FILES[@]}"; do
  check_file "$relative"
done

check_pattern "Corte pré-layout corrigido" '120,884' "entrega/sim_pre/pre_metrics.md"
check_pattern "Corte pós-layout corrigido" '120,884' "entrega/pex_post/post_metrics.md"
check_pattern "DRC sem violações no deck executado" 'Total DRC errors found: 0' "entrega/verification/drc_report.txt"
check_pattern "LVS com correspondência única" 'Final result: Circuits match uniquely' "entrega/verification/lvs_report.txt"
check_pattern "Limite da PEX descrito" '18 capacitâncias.*nenhum resistor parasita' "docs/cbeb2026/main.tex"
check_pattern "Ausência de fabricação explícita" 'não foi fabricado' "docs/cbeb2026/main.tex"
check_pattern "Ausência de ECG real explícita" 'não houve aquisição de ECG real' "docs/cbeb2026/main.tex"
check_pattern "Monte Carlo declarado como limitação" 'Monte Carlo' "docs/cbeb2026/main.tex"

if rg -q 'M3/M4|20\.\.50 V/V|fc.*159 Hz|W=10u/L=0\.36u' "$ROOT_DIR/entrega/schematic/biopotential_chain.sch"; then
  fail "Esquemático reconciliado" "a representação ativa ainda contém parâmetros obsoletos"
else
  pass "Esquemático reconciliado" "nenhum parâmetro legado encontrado no arquivo ativo"
fi

if command -v pdfinfo >/dev/null 2>&1 && [[ -f "$PDF_FILE" ]]; then
  pages="$(pdfinfo "$PDF_FILE" | sed -n 's/^Pages:[[:space:]]*//p')"
  if [[ "$pages" =~ ^[0-9]+$ ]] && ((pages >= 4 && pages <= 8)); then
    pass "PDF CBEB" "$pages páginas, dentro do intervalo de 4 a 8"
  else
    fail "PDF CBEB" "quantidade de páginas inválida: ${pages:-desconhecida}"
  fi
else
  fail "PDF CBEB" "pdfinfo indisponível ou PDF ausente"
fi

if command -v pdffonts >/dev/null 2>&1 && [[ -f "$PDF_FILE" ]]; then
  if pdffonts "$PDF_FILE" | tail -n +3 | rg -q '[[:space:]]no[[:space:]]'; then
    fail "Fontes do PDF" "há fonte não incorporada"
  else
    pass "Fontes do PDF" "todas as fontes listadas estão incorporadas"
  fi
else
  fail "Fontes do PDF" "pdffonts indisponível ou PDF ausente"
fi

if [[ -f "$ROOT_DIR/docs/cbeb2026/main.log" ]] && rg -q 'undefined references|Citation .* undefined|Reference .* undefined' "$ROOT_DIR/docs/cbeb2026/main.log"; then
  fail "Referências LaTeX" "há referência indefinida em main.log"
else
  pass "Referências LaTeX" "nenhuma referência indefinida"
fi

mkdir -p "$(dirname "$OUT_FILE")"
{
  echo '# Checklist final da revisão CBEB'
  echo
  echo 'Gerado por `scripts/entrega/audit_entrega.sh`.'
  echo
  echo '## Resumo'
  echo
  echo "- Itens aprovados: **$PASS_COUNT**"
  echo "- Itens pendentes: **$FAIL_COUNT**"
  echo
  echo '| Status | Critério ou arquivo | Evidência |'
  echo '|---|---|---|'
  for row in "${ROWS[@]}"; do
    IFS='|' read -r status label evidence <<< "$row"
    printf '| %s | `%s` | %s |\n' "$status" "$label" "$evidence"
  done
  echo
  echo '## Limitações científicas mantidas'
  echo
  echo '- Sem silício fabricado, bancada ou ECG real.'
  echo '- PEX capacitiva/híbrida, sem resistências parasitas de interconexão nesta versão.'
  echo '- Fonte de cauda ideal, carga assimétrica e ausência de Monte Carlo.'
  echo '- Triagem PVT de cinco pontos, não sign-off completo.'
  echo '- ICMR e faixa linear de excursão ainda não caracterizados com polarização física.'
  echo
  echo '## Ação editorial externa'
  echo
  echo '- Criar commit ou tag imutável correspondente ao PDF antes da submissão.'
} > "$OUT_FILE"

echo "Checklist salvo em: $OUT_FILE"
if ((FAIL_COUNT > 0)); then
  exit 1
fi
