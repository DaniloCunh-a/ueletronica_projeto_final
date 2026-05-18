# BioDiff-CMOS - Projeto Final de Microeletronica

Este repositorio consolida o projeto final do desafio de design de circuitos integrados:
`docs/Microeletrônica-U7C5O3T2 - Desafio de Design de Circuitos Integrados (1).pdf`.

O circuito desenvolvido foi a cadeia **BioDiff-CMOS** (bloco diferencial analogico com verificacao completa de fluxo):
esquematico -> simulacao pre-layout -> layout -> PEX -> simulacao pos-layout -> DRC/LVS -> technical paper.

## Resultado Final

- `LVS`: aprovado com `Final result: Circuits match uniquely.`
- `DRC`: aprovado com `Total DRC errors found: 0`
- Paper final: `entrega/report/paper_final.pdf`
- Auditoria automatica: `entrega/verification/final_delivery_checklist.md` com `Itens pendentes: 0`

Metricas consolidadas (pre x pos):

| Metrica | Pre-layout | Pos-layout |
|---|---:|---:|
| Av_CORE @1kHz (V/V) | 0.906963 | 0.906963 |
| f3dB_LPF (Hz) | 186.08 | 186.08 |
| Potencia media (W) | 3.60116E-05 | 3.60116E-05 |

## Estrutura da Entrega

A pasta principal da entrega e `entrega/`:

- `entrega/schematic/`: esquematico final, tabela W/L e overview em PNG.
- `entrega/sim_pre/`: testbench pre-layout, logs, figuras e metricas.
- `entrega/layout/`: layout final (`.mag`, `.gds`) e capturas.
- `entrega/pex_post/`: netlist extraida, simulacao pos-layout e comparacao pre x pos.
- `entrega/verification/`: relatorios DRC/LVS e checklist final.
- `entrega/report/`: paper final em Markdown/PDF e analise critica.

Resumo detalhado da finalizacao:
- `docs/README_entrega.md`

## Como Reproduzir

### 1) Subir ambiente

```bash
make start
```

### 2) Executar fluxo no container

```bash
/home/designer/shared/scripts/entrega/run_prelayout.sh
/home/designer/shared/scripts/entrega/run_postlayout.sh
/home/designer/shared/scripts/entrega/extract_metrics.sh \
  /home/designer/shared/entrega/sim_pre/biopotential_chain_prelayout.log \
  /home/designer/shared/entrega/pex_post/biopotential_chain_postlayout_clean.log \
  > /home/designer/shared/entrega/pex_post/pre_vs_post_table.md
/home/designer/shared/scripts/entrega/run_drc_detailed.sh
/home/designer/shared/scripts/entrega/audit_entrega.sh
```

### 3) Gerar paper PDF

```bash
/home/designer/shared/scripts/entrega/build_report_pdf.sh \
  /home/designer/shared/entrega/report/paper_final.md \
  /home/designer/shared/entrega/report/paper_final.pdf
```

## Arquivos-Chave

- Enunciado do desafio:
  - `docs/Microeletrônica-U7C5O3T2 - Desafio de Design de Circuitos Integrados (1).pdf`
- Consolidacao da entrega:
  - `docs/README_entrega.md`
- Checklist final:
  - `entrega/verification/final_delivery_checklist.md`
- Verificacao fisica:
  - `entrega/verification/drc_report.txt`
  - `entrega/verification/lvs_report.txt`
- Paper:
  - `entrega/report/paper_final.md`
  - `entrega/report/paper_final.pdf`

## Ferramentas Utilizadas

- `xschem` (esquematico)
- `ngspice` (simulacao pre/pos)
- `magic` (layout e DRC)
- `netgen` (LVS)
- `pandoc` (geracao do paper PDF)

## Licenca

Este repositorio utiliza a licenca MIT. Veja [LICENSE](LICENSE).
