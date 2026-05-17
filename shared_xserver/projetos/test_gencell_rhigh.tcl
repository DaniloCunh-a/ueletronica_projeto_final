cd /home/designer/shared/projetos
load test_gencell_rhigh
select top cell
box 0um 0um 0um 0um
magic::gencell sg13g2::rhigh R1 w 2u l 10u m 1
save test_gencell_rhigh
quit -noprompt
