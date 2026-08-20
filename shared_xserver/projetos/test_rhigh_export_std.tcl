cd /home/designer/shared/projetos
load test_rhigh
select top cell
extract do local
extract all
extract style ngspice
ext2spice cthresh 0
ext2spice extresist on
ext2spice -o /home/designer/shared/projetos/test_rhigh_extracted_std.spice
quit -noprompt
