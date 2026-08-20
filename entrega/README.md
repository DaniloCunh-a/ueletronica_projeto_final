# Pacote técnico BioDiff-CMOS

Esta pasta reúne as fontes e evidências usadas no artigo CBEB 2026.

| Pasta | Conteúdo |
|---|---|
| `schematic/` | Esquemático coerente com as netlists, figura e tabela de dimensões |
| `sim_pre/` | Testbench nominal pré-layout, respostas tabuladas, gráficos e evidência textual |
| `layout/` | Célula Magic, GDS, imagens e área do bounding box |
| `pex_post/` | Netlist pós-layout, testbench, respostas e comparação pré/pós |
| `characterization/` | Ganho, CMRR, PSRR+, ruído, offset e triagem PVT |
| `verification/` | Relatórios DRC/LVS e checklist de entrega |
| `report/` | Relatório acadêmico anterior, mantido como histórico |

A versão para submissão é `docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf`. Os arquivos em `report/` não substituem esse PDF.

Escopo da maturidade: projeto pré-silício. DRC e LVS verificam geometria e conectividade; não comprovam desempenho em silício.
