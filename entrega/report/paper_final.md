# BioDiff-CMOS: Projeto e Validacao de um Bloco Diferencial em IHP SG13G2

## 1. Introducao
Este trabalho apresenta o desenvolvimento autoral de um bloco analogico diferencial (BioDiff-CMOS), com foco em baixo consumo e robustez de implementacao fisica.

Problema alvo:
- [preencher] contexto de aplicacao (ex.: cadeia de aquisicao de biossinais).

Especificacoes-alvo:
- Tensao de alimentacao: [preencher]
- Faixa de frequencia: [preencher]
- Ganho nominal: [preencher]
- Consumo maximo: [preencher]

## 2. Metodologia
Fluxo seguido:
1. Definicao do circuito e especificacoes.
2. Esquematico e dimensionamento (W/L).
3. Simulacao pre-layout (golden model).
4. Layout custom em IHP SG13G2.
5. Extracao de parasitas (PEX).
6. Simulacao pos-layout.
7. Verificacoes DRC e LVS.

Ferramentas utilizadas:
- Magic (layout e DRC)
- Netgen (LVS)
- Ngspice (simulacoes pre/pos)

## 3. Resultados
### 3.1 Esquematico
- Inserir figura: `schematic_overview.png`
- Inserir tabela de dimensionamento (W/L)

### 3.2 Simulacao pre-layout
- Inserir figura: `entrega/sim_pre/pre_ac_gain.png`
- Inserir figura: `entrega/sim_pre/pre_tran_vin_vout.png`
- Inserir metricas extraidas

### 3.3 Layout
- Inserir figura: `entrega/layout/layout_full.png`
- Inserir figura: `entrega/layout/layout_zoom_inputs.png`

### 3.4 Simulacao pos-layout
- Inserir figura: `entrega/pex_post/post_ac_gain.png`
- Inserir figura: `entrega/pex_post/post_tran_vout.png`
- Comparacao pre vs pos (`entrega/pex_post/pre_vs_post_table.md`)

### 3.5 DRC e LVS
- Inserir figura: `entrega/verification/drc_result.png`
- Inserir figura: `entrega/verification/lvs_result.png`
- Anexar conclusoes dos logs:
  - `entrega/verification/drc_report.txt`
  - `entrega/verification/lvs_report.txt`

## 4. Analise Critica
Discutir:
- Impacto de parasitas no ganho, banda e consumo.
- Trade-offs de area, simetria e roteamento.
- Principais dificuldades de fechamento fisico (DRC/LVS).

## 5. Conclusao
- Sintese dos resultados atingidos.
- Aderencia aos requisitos do desafio.
- Proximos passos para evolucao do bloco.

## Referencias
- [inserir bibliografia e datasheets usados]
