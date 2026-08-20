# Representação esquemática

## Fonte autoritativa

As netlists SPICE executadas são a fonte elétrica autoritativa:

- pré-layout: `entrega/sim_pre/biopotential_chain_prelayout.spice`;
- pós-layout: `entrega/pex_post/biopotential_chain_postlayout_clean.spice`;
- núcleo extraído: `entrega/pex_post/biodiff_extracted.spice`.

`biopotential_chain.sch` é uma representação documental no formato Xschem. Seus símbolos estão marcados para não gerar uma segunda netlist concorrente. A figura `schematic.png` é gerada diretamente a partir dos parâmetros das netlists pelo script `shared_xserver/scripts/entrega/generate_figures.py`.

## Circuito representado

- dois NMOS `sg13_lv_nmos`, 3,2/0,8 µm;
- duas cargas `rhigh`, 2/10 µm;
- fonte de cauda ideal de 20 µA;
- VDD de 1,8 V e VCM de 0,9 V;
- filtro de 1,33 MΩ/1 nF somente em `VOUT_P`;
- inversor e buffer CMOS simplificados, sem conversão analógico-digital completa.

O arquivo `biopotential_chain_legacy_pre_reconciliation.sch` preserva a representação antiga com topologia e dimensões obsoletas. Ele não deve ser usado para simulação ou para ilustrar o artigo revisado.
