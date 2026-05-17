cd /home/designer/shared/projetos
load test_gencell_rhigh_save
select top cell
box 0um 0um 0um 0um
magic::gencell sg13g2::rhigh R1 -spice w 2u l 10u m 1
set c [instance list celldef R1]
puts "CELL=$c"
load $c
save $c
load test_gencell_rhigh_save
save test_gencell_rhigh_save
quit -noprompt
