# Build a minimal differential NMOS layout in Magic (IHP SG13G2)
# Usage (inside container):
#   magic -dnull -noconsole -rcfile /opt/pdks/ihp-sg13g2/libs.tech/magic/ihp-sg13g2.magicrc \
#     /home/designer/shared/projetos/biodiff_top_build.tcl

# Ensure project directory exists and is in Magic search path
shell mkdir -p /home/designer/shared/projetos
cd /home/designer/shared/projetos
addpath /home/designer/shared/projetos

load biodiff_top
select top cell

# Clear feedback and start from a known box
feedback clear
box 0um 0um 1um 1um

# ---------------------------------------------
# Geometry plan (um)
# Left NMOS  : x  6..12, y 10..22
# Right NMOS : x 18..24, y 10..22
# Shared source bar in middle lower region
# Gates as vertical poly in each device
# ---------------------------------------------

# Device active regions (n-diffusion)
box 6um 10um 12um 22um
paint ndiff
box 18um 10um 24um 22um
paint ndiff

# NMOS marker/implant for device recognition
box 6um 10um 12um 22um
paint nfet
box 18um 10um 24um 22um
paint nfet

# Gates (poly crossing active)
box 8.8um 8um 9.6um 24um
paint poly
box 20.8um 8um 21.6um 24um
paint poly

# Source/drain diffusion contacts
# Left drain
box 10.6um 20.0um 11.4um 20.8um
paint ndc
# Left source
box 6.6um 11.2um 7.4um 12.0um
paint ndc

# Right drain
box 18.6um 20.0um 19.4um 20.8um
paint ndc
# Right source
box 22.6um 11.2um 23.4um 12.0um
paint ndc

# Poly contacts for both gates
box 8.8um 22.6um 9.6um 23.4um
paint pc
box 20.8um 22.6um 21.6um 23.4um
paint pc

# Shared source metal bar
box 6.4um 11.0um 23.6um 12.2um
paint m1

# Drain routing to a single VOUT node
box 10.8um 20.0um 11.2um 27.0um
paint m1
box 18.8um 20.0um 19.2um 27.0um
paint m1
box 11.0um 26.4um 19.0um 27.2um
paint m1

# Gate routing stubs
box 8.8um 22.8um 9.6um 28.0um
paint m1
box 20.8um 22.8um 21.6um 28.0um
paint m1

# Substrate taps to VSS (p-sub contacts using psubstrate contact)
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

# Connect source bar to substrate-tap metal (VSS)
box 3.0um 11.2um 6.4um 12.0um
paint m1
box 23.6um 11.2um 27.0um 12.0um
paint m1

# -------------------------
# Labels and ports (M1)
# -------------------------

# VIN_N (left gate)
box 8.9um 27.4um 9.5um 28.0um
label VIN_N n m1
port make 1

# VIN_P (right gate)
box 20.9um 27.4um 21.5um 28.0um
label VIN_P n m1
port make 2

# VOUT (top drain connection)
box 14.5um 26.5um 15.5um 27.1um
label VOUT n m1
port make 3

# VSS (source + substrate)
box 14.0um 11.3um 15.2um 11.9um
label VSS s m1
port make 4

# Save and export
save biodiff_top
gds write /home/designer/shared/projetos/biodiff.gds

# Optional quick extraction outputs in working dir
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice -o /home/designer/shared/projetos/biodiff_top_prepex.spice

quit -noprompt
