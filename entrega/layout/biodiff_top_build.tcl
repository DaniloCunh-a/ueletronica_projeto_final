# Build a full BioDiff core layout in Magic (IHP SG13G2):
# - Differential NMOS input pair
# - Two explicit rhigh load resistors to VDD
# - Dedicated tail-bias pin (TAIL) for external current source bias
# - Separate substrate/bulk tie network on VSS
#
# Usage (inside container):
#   magic -dnull -noconsole \
#     -rcfile /opt/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc \
#     /home/designer/shared/projetos/biodiff_top_build.tcl

shell mkdir -p /home/designer/shared/projetos
cd /home/designer/shared/projetos
addpath /home/designer/shared/projetos

# Rebuild from scratch so old geometry does not pollute extraction.
shell rm -f /home/designer/shared/projetos/biodiff_top.mag
shell rm -f /home/designer/shared/projetos/biodiff_top.ext
shell rm -f /home/designer/shared/projetos/biodiff.gds
shell rm -f /home/designer/shared/projetos/biodiff_top_prepex.spice

load biodiff_top
select top cell
feedback clear

# ---------------------------------------------
# Geometry plan (um)
# NMOS pair:
#   M1 active : x  6..12, y 10..22 (left)
#   M2 active : x 18..24, y 10..22 (right)
# rhigh loads:
#   RL_N body : x 10..12, y 30..40 (left)
#   RL_P body : x 18..20, y 30..40 (right)
# ---------------------------------------------

# Differential pair devices
box 6um 10um 12um 22um
paint ndiff
paint nfet
box 18um 10um 24um 22um
paint ndiff
paint nfet

# Gates
box 8.8um 8um 9.6um 24um
paint poly
box 20.8um 8um 21.6um 24um
paint poly

# Source/drain contacts
box 10.6um 20.0um 11.4um 20.8um
paint ndc
box 6.6um 11.2um 7.4um 12.0um
paint ndc
box 18.6um 20.0um 19.4um 20.8um
paint ndc
box 22.6um 11.2um 23.4um 12.0um
paint ndc

# Gate contacts + stubs
box 8.8um 22.6um 9.6um 23.4um
paint pc
box 20.8um 22.6um 21.6um 23.4um
paint pc
box 8.8um 22.8um 9.6um 28.0um
paint m1
box 20.8um 22.8um 21.6um 28.0um
paint m1

# Tail node (shared source) kept isolated from substrate ties.
box 6.4um 11.0um 23.6um 12.2um
paint m1

# Drain routes up to load resistor bottom terminals.
# Route through the side landing stripes of the pc/rhigh terminal to ensure
# robust electrical connectivity after layer derivation.
box 10.2um 20.0um 10.6um 30.0um
paint m1
box 19.4um 20.0um 19.8um 30.0um
paint m1

# Bottom landing bars below xpolyres region to join both pc side stripes.
box 10.2um 29.6um 11.8um 30.0um
paint m1
box 18.2um 29.6um 19.8um 30.0um
paint m1

# Explicit high-ohmic poly loads (rhigh)
box 10um 30um 12um 40um
paint xres
box 18um 30um 20um 40um
paint xres

# rhigh terminal contacts (poly contacts) + metal landing
# Bottom (to drains)
box 10.4um 30.0um 11.6um 31.2um
paint pc
box 18.4um 30.0um 19.6um 31.2um
paint pc
box 10.2um 30.2um 11.8um 31.0um
paint m1
box 18.2um 30.2um 19.8um 31.0um
paint m1

# Top (to VDD bus)
box 10.4um 38.8um 11.6um 40.0um
paint pc
box 18.4um 38.8um 19.6um 40.0um
paint pc
box 10.2um 39.0um 11.8um 43.0um
paint m1
box 18.2um 39.0um 19.8um 43.0um
paint m1

# VDD horizontal bus feeding both loads
box 8.0um 42.6um 22.0um 43.4um
paint m1

# Substrate ties (bulk/body) on VSS
box 2.0um 8.0um 4.0um 24.0um
paint psubstratepdiff
box 2.4um 11.0um 3.6um 13.0um
paint psubstratepcontact
box 2.4um 18.0um 3.6um 20.0um
paint psubstratepcontact
box 1.8um 11.0um 4.2um 20.0um
paint m1

box 26.0um 8.0um 28.0um 24.0um
paint psubstratepdiff
box 26.4um 11.0um 27.6um 13.0um
paint psubstratepcontact
box 26.4um 18.0um 27.6um 20.0um
paint psubstratepcontact
box 25.8um 11.0um 28.2um 20.0um
paint m1

# -------------------------
# Labels and ports (M1)
# -------------------------
# Keep deterministic order for extracted subckt pins.

# 1) VIN_N
box 8.9um 27.4um 9.5um 28.0um
label VIN_N n m1
port make 1

# 2) VIN_P
box 20.9um 27.4um 21.5um 28.0um
label VIN_P n m1
port make 2

# 3) VOUT_N (left drain)
box 10.4um 30.4um 11.6um 31.0um
label VOUT_N n m1
port make 3

# 4) VOUT_P (right drain)
box 18.4um 30.4um 19.6um 31.0um
label VOUT_P n m1
port make 4

# 5) VDD
box 14.6um 42.6um 15.4um 43.4um
label VDD n m1
port make 5

# 6) TAIL
box 14.0um 11.3um 15.2um 11.9um
label TAIL n m1
port make 6

# 7) VSS (substrate/bulk)
box 2.2um 18.2um 3.8um 19.8um
label VSS s m1
port make 7

save biodiff_top
gds write /home/designer/shared/projetos/biodiff.gds

# Local extraction snapshot (pre-PEX reference)
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/biodiff_top_prepex.spice

quit -noprompt
