cd /home/designer/shared/projetos
load test_rm1
select top cell
feedback clear

box 10um 10um 12um 40um
paint rm1

# landing metal at ends
box 10um 38um 12um 44um
paint m1
box 10um 6um 12um 12um
paint m1

box 10.2um 43.2um 11.8um 44um
label P n m1
port make 1
box 10.2um 6um 11.8um 6.8um
label N n m1
port make 2

save test_rm1
extract do local
extract all
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_rm1_extracted.spice
quit -noprompt
