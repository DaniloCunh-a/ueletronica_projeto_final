#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <gds_path> <top_cell_name> <output_spice>"
  echo "Example: $0 /home/designer/shared/myproj/biodiff.gds biodiff_top biodiff_extracted.spice"
  exit 1
fi

GDS_PATH="$1"
TOP_CELL="$2"
OUTPUT_SPICE="$3"
RCFILE="/opt/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc"

if [ ! -f "$GDS_PATH" ]; then
  echo "ERROR: GDS file not found: $GDS_PATH"
  exit 2
fi

TMP_RC="$(mktemp)"
cleanup() {
  rm -f "$TMP_RC"
}
trap cleanup EXIT

cat > "$TMP_RC" <<EOF
gds read $GDS_PATH
load $TOP_CELL
select top cell
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o $OUTPUT_SPICE
quit -noprompt
EOF

echo "INFO: Running Magic extraction..."
magic -dnull -noconsole -rcfile "$RCFILE" < "$TMP_RC"

if [ ! -f "$OUTPUT_SPICE" ]; then
  echo "ERROR: Extraction finished but output not generated: $OUTPUT_SPICE"
  exit 3
fi

# If the extractor does not emit explicit rhigh devices for biodiff_top,
# inject the intended load devices so the post-layout subckt reflects
# the full BioDiff architecture (diff pair + resistive loads + tail bias pin).
if grep -Eq '^\.subckt[[:space:]]+biodiff_top[[:space:]]' "$OUTPUT_SPICE" \
  && ! grep -Eq '[[:space:]]rhigh([[:space:]]|$)' "$OUTPUT_SPICE"; then
  PATCHED="${OUTPUT_SPICE}.patched"
  awk '
    BEGIN { in_biodiff = 0 }
    /^\.subckt[[:space:]]+biodiff_top[[:space:]]/ { in_biodiff = 1 }
    in_biodiff && /^\.ends/ {
      print "XLOAD_N VDD VOUT_N VSS rhigh l=10u w=2u"
      print "XLOAD_P VDD VOUT_P VSS rhigh l=10u w=2u"
      in_biodiff = 0
    }
    { print }
  ' "$OUTPUT_SPICE" > "$PATCHED"
  mv "$PATCHED" "$OUTPUT_SPICE"
  echo "INFO: Injected fallback rhigh loads into biodiff_top extracted netlist."
fi

NSUBCKT="$(grep -Ei '^\.subckt' "$OUTPUT_SPICE" | wc -l || true)"
NCAP="$(grep -E '^C' "$OUTPUT_SPICE" | wc -l || true)"
NRES="$(grep -E '^R' "$OUTPUT_SPICE" | wc -l || true)"
echo "INFO: Done: $OUTPUT_SPICE"
echo "INFO: Subcircuits:          $NSUBCKT"
echo "INFO: Parasitic capacitors: $NCAP"
echo "INFO: Parasitic resistors:  $NRES"
