if {![info exists ::env(DRC_CELL_PATH)]} {
    puts stderr "ERRO: variavel DRC_CELL_PATH nao definida"
    quit -noprompt
}

if {![info exists ::env(DRC_OUT_DETAIL)] || ![info exists ::env(DRC_OUT_SUMMARY)] || ![info exists ::env(DRC_OUT_RAW)]} {
    puts stderr "ERRO: caminhos de saida nao definidos"
    quit -noprompt
}

set cell_path $::env(DRC_CELL_PATH)
set out_detail $::env(DRC_OUT_DETAIL)
set out_summary $::env(DRC_OUT_SUMMARY)
set out_raw $::env(DRC_OUT_RAW)

set cell_dir [file dirname $cell_path]
set cell_name [file rootname [file tail $cell_path]]

addpath $cell_dir
load $cell_name
select top cell

# Force a fresh DRC pass in batch mode.
drc on
drc check
drc catchup

set drc_total [drc list count total]
puts "Total DRC errors found: $drc_total"

set drcraw [drc listall why]

set fraw [open $out_raw w]
puts $fraw $drcraw
close $fraw

set fsum [open $out_summary w]
puts $fsum "count\trule"

set fdet [open $out_detail w]
puts $fdet "# DRC detailed report"
puts $fdet "# cell: $cell_name"
puts $fdet "# total: $drc_total"
puts $fdet ""

set accum 0
set classes 0
foreach {rule boxes} $drcraw {
    set n [llength $boxes]
    incr classes
    incr accum $n
    puts $fsum "$n\t$rule"

    puts $fdet "RULE: $rule"
    if {$n == 0} {
        puts $fdet "  - sem ocorrencias"
    } else {
        set idx 0
        foreach box $boxes {
            incr idx
            puts $fdet [format "  - %d: %s" $idx $box]
        }
    }
    puts $fdet ""
}

puts $fdet "Resumo:"
puts $fdet "- classes: $classes"
puts $fdet "- violacoes mapeadas: $accum"
puts $fdet "- total reportado por drc count: $drc_total"

close $fsum
close $fdet

puts "DRC detailed report: $out_detail"
puts "DRC summary TSV: $out_summary"
puts "DRC raw listall: $out_raw"

quit -noprompt
