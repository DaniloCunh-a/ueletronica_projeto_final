cd /home/designer/shared/projetos
load test_gencell_rhigh
select top cell
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_gencell_rhigh_extracted.spice
quit -noprompt
