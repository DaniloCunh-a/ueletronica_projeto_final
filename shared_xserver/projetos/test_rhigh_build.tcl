cd /home/designer/shared/projetos
load test_rhigh
select top cell
feedback clear

# resistor body
box 10um 10um 12um 40um
paint xres

# poly contacts at both ends
box 10.4um 38.8um 11.6um 40um
paint pc
box 10.4um 10um 11.6um 11.2um
paint pc

# metal landing pads
box 10.2um 39.0um 11.8um 44um
paint m1
box 10.2um 6um 11.8um 11um
paint m1

# ports
box 10.4um 43.2um 11.6um 44um
label P n m1
port make 1
box 10.4um 6um 11.6um 6.8um
label N n m1
port make 2

save test_rhigh
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_rhigh_extracted.spice
quit -noprompt
