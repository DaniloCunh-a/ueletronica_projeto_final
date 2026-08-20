#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CHAR_DIR="$BASE_DIR/projetos/simulations/characterization"
SUMMARY_FILE="${1:-$CHAR_DIR/characterization_summary.md}"

if ! command -v ngspice >/dev/null 2>&1; then
  echo "ERRO: ngspice não encontrado. Execute este script no container unic-cass-tools." >&2
  exit 127
fi

run_stage() {
  local stage="$1"
  local testbench="$CHAR_DIR/biodiff_characterization_${stage}.spice"
  local log_file="$CHAR_DIR/biodiff_characterization_${stage}.log"
  local evidence_file="$CHAR_DIR/biodiff_characterization_${stage}_evidence.txt"

  (
    cd "$CHAR_DIR"
    ngspice -b -o "$log_file" "$testbench" >/dev/null
  )
  cp "$log_file" "$evidence_file"
}

measure_value() {
  local log_file="$1"
  local key="$2"
  sed -nE "s/^${key}[[:space:]]*=[[:space:]]*([^[:space:]]+).*/\1/Ip" "$log_file" | tail -n1
}

echo_value() {
  local log_file="$1"
  local key="$2"
  sed -nE "s/^${key}:[[:space:]]*([^[:space:]]+).*/\1/Ip" "$log_file" | tail -n1
}

difference() {
  local maximum="$1"
  local minimum="$2"
  awk -v maximum="$maximum" -v minimum="$minimum" 'BEGIN { printf "%.9g", maximum - minimum }'
}

run_stage pre
run_stage post

pre_log="$CHAR_DIR/biodiff_characterization_pre.log"
post_log="$CHAR_DIR/biodiff_characterization_post.log"
pre_vod_max="$(measure_value "$pre_log" vod_max)"
pre_vod_min="$(measure_value "$pre_log" vod_min)"
post_vod_max="$(measure_value "$post_log" vod_max)"
post_vod_min="$(measure_value "$post_log" vod_min)"

{
  echo '# Caracterização nominal do BioDiff-CMOS'
  echo
  echo 'Condições: IHP SG13G2, `mos_tt/res_typ/cap_typ`, 1,8 V, 27 °C, VCM de 0,9 V, corrente de cauda ideal de 20 µA e carga assimétrica de 1,33 MΩ/1 nF em `VOUT_P`.'
  echo
  echo '| Métrica | Pré-layout | Pós-layout | Observação |'
  echo '|---|---:|---:|---|'
  printf '| Ganho diferencial em 10 Hz (V/V) | %s | %s | Núcleo com carga do testbench |\n' "$(measure_value "$pre_log" avd_10hz)" "$(measure_value "$post_log" avd_10hz)"
  printf '| Ganho diferencial em 100 Hz (V/V) | %s | %s | Núcleo com carga do testbench |\n' "$(measure_value "$pre_log" avd_100hz)" "$(measure_value "$post_log" avd_100hz)"
  printf '| Ganho diferencial em 1 kHz (V/V) | %s | %s | Núcleo com carga do testbench |\n' "$(measure_value "$pre_log" avd_1khz)" "$(measure_value "$post_log" avd_1khz)"
  printf '| Ruído referido à entrada, 0,05–150 Hz (V rms) | %s | %s | Integração nominal |\n' "$(echo_value "$pre_log" IRN_0P05_150_HZ_VRMS)" "$(echo_value "$post_log" IRN_0P05_150_HZ_VRMS)"
  printf '| Ruído referido à entrada, 0,5–150 Hz (V rms) | %s | %s | Integração nominal |\n' "$(echo_value "$pre_log" IRN_0P5_150_HZ_VRMS)" "$(echo_value "$post_log" IRN_0P5_150_HZ_VRMS)"
  printf '| Saída diferencial máxima no sweep DC (V) | %s | %s | Sweep de entrada ±1,8 V |\n' "$pre_vod_max" "$post_vod_max"
  printf '| Saída diferencial mínima no sweep DC (V) | %s | %s | Sweep de entrada ±1,8 V |\n' "$pre_vod_min" "$post_vod_min"
  printf '| Excursão diferencial no sweep DC (Vpp) | %s | %s | Diferença entre os extremos simulados |\n' "$(difference "$pre_vod_max" "$pre_vod_min")" "$(difference "$post_vod_max" "$post_vod_min")"
  printf '| Offset nominal numérico (V) | %s | %s | Sem mismatch; não representa offset de fabricação |\n' "$(measure_value "$pre_log" vos_nominal)" "$(measure_value "$post_log" vos_nominal)"
  printf '| CMRR nominal em 100 Hz (dB) | %s | %s | Otimista: fonte de cauda ideal e ausência de mismatch |\n' "$(measure_value "$pre_log" cmrr_diag_100hz_db)" "$(measure_value "$post_log" cmrr_diag_100hz_db)"
  printf '| PSRR+ nominal em 100 Hz (dB) | %s | %s | Saída diferencial e polarização ideal |\n' "$(measure_value "$pre_log" psrr_diag_100hz_db)" "$(measure_value "$post_log" psrr_diag_100hz_db)"
  echo
  echo 'CMRR, PSRR+ e offset são resultados nominais de simulação. A fonte de cauda ideal e a ausência de mismatch tornam CMRR e offset otimistas. O sweep de modo comum força tensão negativa no nó de cauda em VCM baixo; por isso, este circuito ainda não possui ICMR fisicamente válido. Monte Carlo permanece pendente.'
} > "$SUMMARY_FILE"

echo "OK: $SUMMARY_FILE"
