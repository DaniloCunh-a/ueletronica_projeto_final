cd /home/designer/shared/projetos
load test_rhigh_tied
select top cell
feedback clear

# rhigh body
box 10um 10um 12um 40um
paint xres

# main terminals
box 10.4um 38.8um 11.6um 40um
paint pc
box 10.4um 10um 11.6um 11.2um
paint pc
box 10.2um 39.0um 11.8um 44um
paint m1
box 10.2um 6um 11.8um 11um
paint m1

# body tie attempt
box 10.4um 24.0um 11.6um 25.2um
paint ndc
box 8um 24.2um 10.6um 25.0um
paint m1

# labels
box 10.4um 43.2um 11.6um 44um
label P n m1
port make 1
box 10.4um 6um 11.6um 6.8um
label N n m1
port make 2
box 8.2um 24.2um 9.8um 25.0um
label B n m1
port make 3

save test_rhigh_tied
extract do local
extract all
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_rhigh_tied_extracted.spice
quit -noprompt
