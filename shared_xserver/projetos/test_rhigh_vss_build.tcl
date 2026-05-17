cd /home/designer/shared/projetos
load test_rhigh_vss
select top cell

box 10um 10um 12um 40um
paint xres

box 10.4um 38.8um 11.6um 40um
paint pc
box 10.4um 10um 11.6um 11.2um
paint pc
box 10.2um 39.0um 11.8um 44um
paint m1
box 10.2um 6um 11.8um 11um
paint m1

# substrate tie labelled VSS
box 5um 20um 7um 30um
paint psubstratepdiff
box 5.2um 22um 6.8um 23.6um
paint psubstratepcontact
box 5.2um 26.4um 6.8um 28.0um
paint psubstratepcontact
box 4.8um 22um 7.2um 28.0um
paint m1
box 5.0um 27.4um 7.0um 28.0um
label VSS s m1
port make 3

box 10.4um 43.2um 11.6um 44um
label P n m1
port make 1
box 10.4um 6um 11.6um 6.8um
label N n m1
port make 2

save test_rhigh_vss
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_rhigh_vss_extracted.spice
quit -noprompt
