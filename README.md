# BioDiff-CMOS

Projeto pré-silício de um bloco diferencial CMOS para uma cadeia simulada de aquisição de ECG, no processo IHP SG13G2 BiCMOS de 130 nm.

O repositório contém netlists, layout, extração, simulações pré e pós-layout, caracterização nominal, triagem PVT, DRC, LVS e o artigo revisado para o CBEB 2026. O circuito não foi fabricado e não adquiriu ECG real.

## Resultados consolidados

Condição nominal: `mos_tt/res_typ/cap_typ`, 1,8 V, 27 °C, VCM de 0,9 V e fonte de cauda ideal de 20 µA.

| Métrica | Pré-layout | Pós-layout | Escopo |
|---|---:|---:|---|
| Ganho diferencial em 100 Hz | 0,908323 V/V | 0,908323 V/V | Núcleo carregado pelo testbench |
| Corte de −3 dB do filtro | 120,884 Hz | 120,884 Hz | Referência em 1 Hz |
| CMRR nominal em 100 Hz | 128,292 dB | 128,291 dB | Otimista, sem descasamento |
| PSRR+ nominal em 100 Hz | 48,683 dB | 48,683 dB | Saída diferencial |
| Ruído referido à entrada, 0,5–150 Hz | 29,9317 µVrms | 29,9317 µVrms | Integração nominal |
| Potência pela fonte VDD | 36,0116 µW | 36,0116 µW | Polarização física excluída |

O layout do núcleo ocupa um bounding box de 26,40 µm × 35,40 µm, equivalente a 934,56 µm². O DRC reportou zero violações no deck executado e o LVS encontrou correspondência única de conectividade. As classes `sg13_lv_nmos` e `rhigh` foram comparadas como caixas-pretas.

A netlist pós-layout usada nesta revisão contém 18 capacitâncias extraídas, nenhuma resistência parasita de interconexão e duas cargas `rhigh` reconstruídas. Ela é um modelo pós-layout capacitivo/híbrido, não uma PEX RC completa.

## Artigo revisado

- Fonte IEEE: `docs/cbeb2026/main.tex`
- PDF para conferência: `docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf`
- Resposta aos revisores: `docs/resposta_revisores_v06.md`
- Comparação bibliográfica auditada: `docs/tabela_comparativa_biodiff_cmos.md`
- Plano e estado da revisão: `docs/plano_ajustes_biodiff_cmos.md`

O PDF usa `IEEEtran`, tem quatro páginas e fontes incorporadas. O CBEB exige PDF único no template IEEE e artigo completo entre 4 e 8 páginas. Antes do envio, associe a entrega a um commit ou tag imutável.

## Estrutura

- `entrega/schematic/`: circuito autoritativo, figura e dimensionamento.
- `entrega/sim_pre/`: testbench e evidências pré-layout.
- `entrega/layout/`: célula Magic, GDS, imagens e cálculo de área.
- `entrega/pex_post/`: netlist extraída, testbench e comparação pós-layout.
- `entrega/characterization/`: CMRR, PSRR+, ruído, offset e triagem PVT.
- `entrega/verification/`: DRC, LVS e checklist final.
- `docs/cbeb2026/`: manuscrito IEEE e PDF camera-ready.
- `scripts/entrega/`: execução, consolidação e auditoria.

## Reprodução

O ambiente foi fixado na imagem `isaiassh/unic-cass-tools:1.1.0`, com Ngspice 44.2, Magic 8.3.613, Netgen 1.5.293, Xschem no commit `313acc8e2974` e IHP-Open-PDK v0.3.0 no commit `5cccb161f7492697cfa52eb14dc03beb00bdca9e`.

Inicie o ambiente na raiz do repositório:

```bash
NO_PULL=1 make start
```

No shell do contêiner:

```bash
cd /home/designer/shared
./scripts/entrega/run_prelayout.sh
./scripts/entrega/run_postlayout.sh
./scripts/entrega/run_characterization.sh
./scripts/entrega/run_pvt.sh
./scripts/entrega/generate_figures.py
./scripts/entrega/run_drc_detailed.sh
```

Depois de sair do contêiner, consolide os artefatos, gere o PDF e rode a auditoria:

```bash
./scripts/entrega/consolidate_revision.sh
```

Resultado esperado: `Itens pendentes: **0**` em `entrega/verification/final_delivery_checklist.md`.

## Limitações mantidas

- não há silício fabricado, medição de bancada ou ECG real;
- a fonte de cauda é ideal e a carga das saídas é assimétrica;
- o CMRR e o offset não incluem descasamento;
- a triagem PVT de cinco pontos não substitui sign-off completo;
- ICMR e faixa linear de excursão exigem polarização física;
- o filtro de primeira ordem não constitui sozinho uma cadeia anti-aliasing validada.

## Licença

Este repositório usa a licença MIT. Consulte `LICENSE`.
