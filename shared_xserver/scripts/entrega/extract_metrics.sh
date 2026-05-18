#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SIM_DIR="$BASE_DIR/projetos/simulations"

PRE_LOG="$SIM_DIR/biopotential_chain_prelayout.log"
POST_LOG="$SIM_DIR/biopotential_chain_postlayout_clean.log"

if [ ! -f "$PRE_LOG" ]; then
  echo "ERRO: log pre-layout não encontrado: $PRE_LOG"
  exit 1
fi

if [ ! -f "$POST_LOG" ]; then
  echo "ERRO: log pós-layout não encontrado: $POST_LOG"
  exit 1
fi

extract() {
  local file="$1"
  local key="$2"
  local line

  if command -v rg >/dev/null 2>&1; then
    line="$(rg -i "$key" "$file" | tail -n1 || true)"
  else
    line="$(grep -i "$key" "$file" | tail -n1 || true)"
  fi

  if [ -z "$line" ]; then
    echo "N/A"
    return 0
  fi

  printf '%s\n' "$line" | sed -E 's/.*: *//; s/ +$//'
}

pre_av1k="$(extract "$PRE_LOG" 'Av_CORE_1kHz_VV')"
pre_fc="$(extract "$PRE_LOG" 'f3dB_LPF_Hz')"
pre_pavg="$(extract "$PRE_LOG" 'Potencia_media_W')"

post_av1k="$(extract "$POST_LOG" 'Av_CORE_1kHz_VV')"
post_fc="$(extract "$POST_LOG" 'f3dB_LPF_Hz')"
post_pavg="$(extract "$POST_LOG" 'Potencia_media_W')"

cat <<MD
| Métrica | Pre-layout | Pós-layout |
|---|---:|---:|
| Av_CORE @1kHz (V/V) | ${pre_av1k:-N/A} | ${post_av1k:-N/A} |
| f3dB_LPF (Hz) | ${pre_fc:-N/A} | ${post_fc:-N/A} |
| Potência média (W) | ${pre_pavg:-N/A} | ${post_pavg:-N/A} |
MD
