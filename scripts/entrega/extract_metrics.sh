#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <prelayout.log> <postlayout.log>"
  exit 1
fi

PRE_LOG="$1"
POST_LOG="$2"

extract() {
  local f="$1"
  local key="$2"
  local line

  if command -v rg >/dev/null 2>&1; then
    line="$(rg -i "$key" "$f" | tail -n1 || true)"
  else
    line="$(grep -i "$key" "$f" | tail -n1 || true)"
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
