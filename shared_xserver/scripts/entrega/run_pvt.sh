#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SIM_DIR="$BASE_DIR/projetos/simulations"
OUT_TSV="${1:-$SIM_DIR/pvt_results.tsv}"
OUT_MD="${2:-$SIM_DIR/pvt_results.md}"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

if ! command -v ngspice >/dev/null 2>&1; then
  echo "ERRO: ngspice não encontrado. Execute este script no container unic-cass-tools." >&2
  exit 127
fi

extract_value() {
  local log_file="$1"
  local key="$2"
  grep -i "$key" "$log_file" | tail -n1 | awk '{print $2}'
}

run_case() {
  local stage="$1"
  local source_file="$2"
  local case_name="$3"
  local mos_corner="$4"
  local res_corner="$5"
  local cap_corner="$6"
  local vdd="$7"
  local temperature="$8"
  local testbench="$TMP_DIR/${stage}_${case_name}.spice"
  local log_file="$TMP_DIR/${stage}_${case_name}.log"

  sed \
    -e "s/ mos_tt$/ $mos_corner/" \
    -e "s/ res_typ$/ $res_corner/" \
    -e "s/ cap_typ$/ $cap_corner/" \
    -e "s/\.option TEMP=27/.option TEMP=$temperature/" \
    -e "s/VDD_SRC VDD 0 1.8/VDD_SRC VDD 0 $vdd/" \
    -e "s/\*1.8/\*$vdd/" \
    "$source_file" > "$testbench"

  (
    cd "$TMP_DIR"
    ngspice -b -o "$log_file" "$testbench" >/dev/null
  )

  printf '%s\t%s\t%s/%s/%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$stage" \
    "$case_name" \
    "$mos_corner" "$res_corner" "$cap_corner" \
    "$vdd" \
    "$temperature" \
    "$(extract_value "$log_file" 'Av_CORE_1kHz_VV:')" \
    "$(extract_value "$log_file" 'f3dB_LPF_Hz:')" \
    "$(extract_value "$log_file" 'Potencia_media_W:')" \
    >> "$OUT_TSV"
}

printf 'Stage\tCase\tModels\tVDD_V\tTemp_C\tAv_CORE_1kHz_VV\tf3dB_LPF_Hz\tPavg_W\n' > "$OUT_TSV"

for stage in pre post; do
  if [ "$stage" = "pre" ]; then
    source_file="$SIM_DIR/biopotential_chain_prelayout.spice"
  else
    source_file="$SIM_DIR/biopotential_chain_postlayout_clean.spice"
  fi

  run_case "$stage" "$source_file" TT_nom       mos_tt res_typ cap_typ 1.80  27
  run_case "$stage" "$source_file" SS_low_hot   mos_ss res_wcs cap_wcs 1.62  85
  run_case "$stage" "$source_file" FF_high_cold mos_ff res_bcs cap_bcs 1.98 -40
  run_case "$stage" "$source_file" SF_low_hot   mos_sf res_wcs cap_wcs 1.62  85
  run_case "$stage" "$source_file" FS_high_cold mos_fs res_bcs cap_bcs 1.98 -40
done

{
  echo '# Triagem PVT do BioDiff-CMOS'
  echo
  echo 'Triagem de cinco pontos. Não substitui sign-off de corners nem Monte Carlo de descasamento.'
  echo
  echo '| Etapa | Caso | Modelos MOS/R/C | VDD (V) | Temperatura (°C) | Ganho do núcleo em 1 kHz (V/V) | Corte do LPF (Hz) | Potência pela fonte VDD (W) |'
  echo '|---|---|---|---:|---:|---:|---:|---:|'
  tail -n +2 "$OUT_TSV" | while IFS=$'\t' read -r stage case_name models vdd temperature gain cutoff power; do
    printf '| %s | %s | `%s` | %s | %s | %s | %s | %s |\n' \
      "$stage" "$case_name" "$models" "$vdd" "$temperature" "$gain" "$cutoff" "$power"
  done
} > "$OUT_MD"

echo "OK: $OUT_TSV"
echo "OK: $OUT_MD"
