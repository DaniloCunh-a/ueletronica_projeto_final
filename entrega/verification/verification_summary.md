# Verification Summary - BioDiff-CMOS

## Escopo
Verificação física do bloco `biodiff_top` em tecnologia `ihp-sg13g2`.

## LVS
- Arquivo de evidência: `lvs_report.txt` (fonte: `shared_xserver/projetos/simulations/lvs_biodiff_top_clean.log`).
- Resultado final: `Final result: Circuits match uniquely.`
- Correspondência de pinos no topo confirmada: `VSS, VIN_N, VIN_P, TAIL, VOUT_N, VOUT_P, VDD`.

## DRC
- Arquivo de evidência principal: `drc_report.txt` (fonte: `shared_xserver/projetos/simulations/drc_magic_stdout.log`).
- Evidências adicionais de triagem: `drc_report_detailed.txt`, `drc_summary_by_rule.tsv`, `drc_listall_raw.txt`.
- Resultado final registrado no log: `Total DRC errors found: 0`.
- Status: **clean** na execução final.

## Conclusão de verificação
- `LVS`: aprovado.
- `DRC`: aprovado (clean).

## Próxima ação recomendada
1. Capturar `drc_result.png` da execução clean para anexar no paper.
2. Capturar `lvs_result.png` para fechar pacote visual de verificação.
