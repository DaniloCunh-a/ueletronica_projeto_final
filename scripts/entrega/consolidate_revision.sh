#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SIM_DIR="$ROOT_DIR/shared_xserver/projetos/simulations"
FIG_DIR="$SIM_DIR/generated_figures"
CHAR_DIR="$SIM_DIR/characterization"

mkdir -p "$ROOT_DIR/entrega/characterization" "$ROOT_DIR/docs/cbeb2026/figures"

cp "$FIG_DIR/pre_ac_gain.png" "$ROOT_DIR/entrega/sim_pre/pre_ac_gain.png"
cp "$FIG_DIR/pre_tran_vin_vout.png" "$ROOT_DIR/entrega/sim_pre/pre_tran_vin_vout.png"
cp "$FIG_DIR/post_ac_gain.png" "$ROOT_DIR/entrega/pex_post/post_ac_gain.png"
cp "$FIG_DIR/post_tran_vout.png" "$ROOT_DIR/entrega/pex_post/post_tran_vout.png"
cp "$FIG_DIR/schematic_authoritative.png" "$ROOT_DIR/entrega/schematic/schematic.png"
cp "$FIG_DIR/schematic_authoritative.png" "$ROOT_DIR/entrega/schematic/schematic_overview.png"
cp "$FIG_DIR/pvt_screening.png" "$ROOT_DIR/entrega/characterization/pvt_screening.png"

cp "$SIM_DIR/pre_ac_response.tsv" "$ROOT_DIR/entrega/sim_pre/pre_ac_response.tsv"
cp "$SIM_DIR/pre_tran_response.tsv" "$ROOT_DIR/entrega/sim_pre/pre_tran_response.tsv"
cp "$SIM_DIR/post_ac_response.tsv" "$ROOT_DIR/entrega/pex_post/post_ac_response.tsv"
cp "$SIM_DIR/post_tran_response.tsv" "$ROOT_DIR/entrega/pex_post/post_tran_response.tsv"
cp "$SIM_DIR/biopotential_chain_prelayout.log" "$ROOT_DIR/entrega/sim_pre/pre_metrics_evidence.txt"
cp "$SIM_DIR/biopotential_chain_postlayout_clean.log" "$ROOT_DIR/entrega/pex_post/post_metrics_evidence.txt"

cp "$SIM_DIR/pvt_results.md" "$ROOT_DIR/entrega/characterization/pvt_results.md"
cp "$SIM_DIR/pvt_results.tsv" "$ROOT_DIR/entrega/characterization/pvt_results.tsv"
cp "$CHAR_DIR/characterization_summary.md" "$ROOT_DIR/entrega/characterization/characterization_summary.md"
cp "$CHAR_DIR/biodiff_characterization_common.inc" "$ROOT_DIR/entrega/characterization/biodiff_characterization_common.inc"
cp "$CHAR_DIR/biodiff_characterization_pre.spice" "$ROOT_DIR/entrega/characterization/biodiff_characterization_pre.spice"
cp "$CHAR_DIR/biodiff_characterization_post.spice" "$ROOT_DIR/entrega/characterization/biodiff_characterization_post.spice"
cp "$CHAR_DIR/biodiff_characterization_pre_evidence.txt" "$ROOT_DIR/entrega/characterization/biodiff_characterization_pre_evidence.txt"
cp "$CHAR_DIR/biodiff_characterization_post_evidence.txt" "$ROOT_DIR/entrega/characterization/biodiff_characterization_post_evidence.txt"

cp "$ROOT_DIR/entrega/schematic/schematic.png" "$ROOT_DIR/docs/cbeb2026/figures/schematic.png"
cp "$ROOT_DIR/entrega/layout/layout_full.png" "$ROOT_DIR/docs/cbeb2026/figures/layout_full.png"
cp "$ROOT_DIR/entrega/pex_post/post_ac_gain.png" "$ROOT_DIR/docs/cbeb2026/figures/post_ac_gain.png"
cp "$ROOT_DIR/entrega/characterization/pvt_screening.png" "$ROOT_DIR/docs/cbeb2026/figures/pvt_screening.png"

"$ROOT_DIR/scripts/entrega/report_layout_area.py"
"$ROOT_DIR/docs/cbeb2026/build.sh"
cp "$ROOT_DIR/docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf" "$ROOT_DIR/entrega/report/paper_final.pdf"
"$ROOT_DIR/scripts/entrega/audit_entrega.sh"

echo "OK: revisão consolidada em entrega/ e docs/cbeb2026/."
