cd /home/designer/shared/projetos
load test_gencell_rhigh_save2
select top cell
box 0um 0um 0um 0um
magic::gencell sg13g2::rhigh R1 w 2 l 10 m 1 guard 0 doports 1
set c [instance list celldef R1]
puts "CELL=$c"
load $c
save $c
load test_gencell_rhigh_save2
save test_gencell_rhigh_save2
quit -noprompt
