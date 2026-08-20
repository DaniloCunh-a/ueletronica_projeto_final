# Checklist final da revisão CBEB

Gerado por `scripts/entrega/audit_entrega.sh`.

## Resumo

- Itens aprovados: **36**
- Itens pendentes: **0**

| Status | Critério ou arquivo | Evidência |
|---|---|---|
| OK | `entrega/schematic/biopotential_chain.sch` | presente e não vazio |
| OK | `entrega/schematic/biopotential_chain_legacy_pre_reconciliation.sch` | presente e não vazio |
| OK | `entrega/schematic/schematic.png` | presente e não vazio |
| OK | `entrega/sim_pre/biopotential_chain_prelayout.spice` | presente e não vazio |
| OK | `entrega/sim_pre/pre_metrics_evidence.txt` | presente e não vazio |
| OK | `entrega/sim_pre/pre_metrics.md` | presente e não vazio |
| OK | `entrega/layout/biodiff_top.mag` | presente e não vazio |
| OK | `entrega/layout/biodiff.gds` | presente e não vazio |
| OK | `entrega/layout/layout_area.md` | presente e não vazio |
| OK | `entrega/pex_post/biodiff_extracted.spice` | presente e não vazio |
| OK | `entrega/pex_post/PEX_LIMITATIONS.md` | presente e não vazio |
| OK | `entrega/pex_post/biopotential_chain_postlayout_clean.spice` | presente e não vazio |
| OK | `entrega/pex_post/post_metrics_evidence.txt` | presente e não vazio |
| OK | `entrega/pex_post/post_metrics.md` | presente e não vazio |
| OK | `entrega/pex_post/pre_vs_post_table.md` | presente e não vazio |
| OK | `entrega/characterization/characterization_summary.md` | presente e não vazio |
| OK | `entrega/characterization/pvt_results.tsv` | presente e não vazio |
| OK | `entrega/characterization/pvt_screening.png` | presente e não vazio |
| OK | `entrega/verification/drc_report.txt` | presente e não vazio |
| OK | `entrega/verification/lvs_report.txt` | presente e não vazio |
| OK | `docs/tabela_comparativa_biodiff_cmos.md` | presente e não vazio |
| OK | `docs/resposta_revisores_v06.md` | presente e não vazio |
| OK | `docs/cbeb2026/main.tex` | presente e não vazio |
| OK | `docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf` | presente e não vazio |
| OK | `Corte pré-layout corrigido` | confirmado em entrega/sim_pre/pre_metrics.md |
| OK | `Corte pós-layout corrigido` | confirmado em entrega/pex_post/post_metrics.md |
| OK | `DRC sem violações no deck executado` | confirmado em entrega/verification/drc_report.txt |
| OK | `LVS com correspondência única` | confirmado em entrega/verification/lvs_report.txt |
| OK | `Limite da PEX descrito` | confirmado em docs/cbeb2026/main.tex |
| OK | `Ausência de fabricação explícita` | confirmado em docs/cbeb2026/main.tex |
| OK | `Ausência de ECG real explícita` | confirmado em docs/cbeb2026/main.tex |
| OK | `Monte Carlo declarado como limitação` | confirmado em docs/cbeb2026/main.tex |
| OK | `Esquemático reconciliado` | nenhum parâmetro legado encontrado no arquivo ativo |
| OK | `PDF CBEB` | 4 páginas, dentro do intervalo de 4 a 8 |
| OK | `Fontes do PDF` | todas as fontes listadas estão incorporadas |
| OK | `Referências LaTeX` | nenhuma referência indefinida |

## Limitações científicas mantidas

- Sem silício fabricado, bancada ou ECG real.
- PEX capacitiva/híbrida, sem resistências parasitas de interconexão nesta versão.
- Fonte de cauda ideal, carga assimétrica e ausência de Monte Carlo.
- Triagem PVT de cinco pontos, não sign-off completo.
- ICMR e faixa linear de excursão ainda não caracterizados com polarização física.

## Ação editorial externa

- Criar commit ou tag imutável correspondente ao PDF antes da submissão.
