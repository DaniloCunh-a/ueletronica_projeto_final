# BioDiff-CMOS: Projeto e Validacao de um Bloco Diferencial em IHP SG13G2

## 1. Introducao
Este trabalho implementa uma cadeia analogica para condicionamento de biopotenciais de baixa frequencia usando o bloco `biodiff_top`.

Objetivo tecnico:
- validar o fluxo completo de design custom analogico (pre-layout, layout, PEX, pos-layout, DRC e LVS);
- manter desempenho eletrico apos insercao de parasitas;
- fechar verificacoes fisicas com `DRC clean` e `LVS match uniquely`.

Especificacoes de referencia do cenario:
- VDD: 1.8 V
- Ibias tail: 20 uA
- f3dB alvo do LPF: ~186 Hz
- ganho diferencial do core em 1 kHz: ~0.907 V/V
- potencia media: ~36 uW

## 2. Metodologia
Fluxo adotado:
1. Definicao do circuito e parametros de operacao.
2. Esquematico analogico e dimensoes W/L.
3. Simulacao pre-layout (golden).
4. Layout custom em IHP SG13G2.
5. Extracao de parasitas (PEX).
6. Simulacao pos-layout.
7. Verificacoes fisicas DRC e LVS.

Ferramentas:
- Magic (layout + DRC)
- Netgen (LVS)
- Ngspice (simulacoes AC/transiente)
- Pandoc (geracao do PDF)

## 3. Resultados
### 3.1 Esquematico e dimensionamento
Arquivos de evidencia:
- `entrega/schematic/biopotential_chain.sch`
- `entrega/schematic/sizing_table.md`

![Esquematico completo](entrega/schematic/schematic_overview.png)

### 3.2 Simulacao pre-layout
![Pre-layout AC](entrega/sim_pre/pre_ac_gain.png)

![Pre-layout transiente](entrega/sim_pre/pre_tran_vin_vout.png)

Metricas (pre-layout):
- `Av_CORE_1kHz = 0.906963 V/V`
- `f3dB_LPF = 186.08 Hz`
- `Potencia_media = 3.60116E-05 W`

### 3.3 Layout final
![Layout completo](entrega/layout/layout_full.png)

![Layout zoom entradas](entrega/layout/layout_zoom_inputs.png)

### 3.4 Simulacao pos-layout
![Post-layout AC](entrega/pex_post/post_ac_gain.png)

![Post-layout transiente](entrega/pex_post/post_tran_vout.png)

Comparacao pre x pos (`entrega/pex_post/pre_vs_post_table.md`):
- `Av_CORE_1kHz`: 0.906963 (pre) vs 0.906963 (pos)
- `f3dB_LPF`: 186.08 Hz (pre) vs 186.08 Hz (pos)
- `Potencia_media`: 3.60116E-05 W (pre) vs 3.60116E-05 W (pos)

### 3.5 DRC e LVS
![DRC resultado](entrega/verification/drc_result.png)

![LVS resultado](entrega/verification/lvs_result.png)

Resultados dos logs:
- DRC (`entrega/verification/drc_report.txt`): `Total DRC errors found: 0`
- LVS (`entrega/verification/lvs_report.txt`): `Final result: Circuits match uniquely.`

## 4. Analise critica
- O maior risco tecnico esteve no fechamento de layout (regras de overhang, spacing e contato), que exigiu iteracoes ate chegar em DRC zero.
- O LVS fechou sem ambiguidade de conectividade, indicando consistencia entre topologia esquematica e layout extraido.
- No cenario atual de excitacao e extracao, as metricas pre e pos ficaram numericamente iguais.
- Essa ausencia de degradacao mensuravel indica que os parasitas extraidos, para este bloco e condicao de teste, nao deslocaram ganho, banda ou potencia de forma relevante.
- Para aumentar robustez de validacao, o proximo passo natural e rodar corners (PVT) e variacao de mismatch.

## 5. Conclusao
O desafio foi fechado com o fluxo completo exigido: circuito definido, simulacoes pre/pos, layout, PEX, DRC e LVS aprovados, e consolidacao em technical paper.

## Referencias
- Documentacao do PDK IHP SG13G2.
- Manual do Ngspice.
- Documentacao do Magic e Netgen.
