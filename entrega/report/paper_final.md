# BioDiff-CMOS: Projeto e Validacao de um Bloco Diferencial em IHP SG13G2

## 1. Introducao
Este trabalho apresenta o desenvolvimento autoral de um bloco analogico diferencial (BioDiff-CMOS), com foco em baixo consumo e robustez de implementacao fisica.

Problema alvo:
- Condicionamento inicial de sinais biomédicos de baixa frequência, com comparacao entre comportamento pre-layout e pos-layout.

Especificacoes-alvo:
- Tensao de alimentacao: 1.8 V
- Faixa de frequencia de interesse (LPF): baixa frequencia, com f3dB em torno de 186 Hz
- Ganho diferencial nominal do core em 1 kHz: ~0.907 V/V
- Consumo medio no cenario de teste: ~36 uW

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
- Esquematico do bloco diferencial com par NMOS e cargas `rhigh` documentado no pacote.
- Dimensionamento e topologia descritos no fluxo de simulacao e verificacao.

### 3.2 Simulacao pre-layout
- Figura: `entrega/sim_pre/pre_ac_gain.png`
- Figura: `entrega/sim_pre/pre_tran_vin_vout.png`
- Metricas extraidas:
  - `Av_CORE_1kHz = 0.906963 V/V`
  - `f3dB_LPF = 186.08 Hz`
  - `Potencia_media = 3.60116E-05 W`

### 3.3 Layout
- Figura: `entrega/layout/layout_full.png`
- Figura: `entrega/layout/layout_zoom_inputs.png`

### 3.4 Simulacao pos-layout
- Figura: `entrega/pex_post/post_ac_gain.png`
- Figura: `entrega/pex_post/post_tran_vout.png`
- Comparacao pre vs pos em `entrega/pex_post/pre_vs_post_table.md`:
  - `Av_CORE_1kHz`: 0.906963 (pre) vs 0.906963 (pos)
  - `f3dB_LPF`: 186.08 Hz (pre) vs 186.08 Hz (pos)
  - `Potencia_media`: 3.60116E-05 W (pre) vs 3.60116E-05 W (pos)

### 3.5 DRC e LVS
- Figura: `entrega/verification/drc_result.png`
- Figura: `entrega/verification/lvs_result.png`
- Conclusoes dos logs:
  - DRC: `Total DRC errors found: 0` (`entrega/verification/drc_report.txt`)
  - LVS: `Final result: Circuits match uniquely.` (`entrega/verification/lvs_report.txt`)

## 4. Analise Critica
Discutir:
- Impacto de parasitas no ganho, banda e consumo: nao houve degradacao mensuravel nos indicadores extraidos.
- Trade-offs de area, simetria e roteamento: houve iteracao de geometria e contatos para atender integralmente ao deck de DRC da tecnologia.
- Dificuldade principal: fechamento fisico (DRC), superado com correcoes de overhang, spacing e contato.

## 5. Conclusao
- O fluxo completo foi executado com sucesso (pre-layout, layout, PEX, pos-layout, DRC e LVS).
- A entrega atende aos requisitos do desafio com evidencias tecnicas e visuais consolidadas.
- Como evolucao futura, recomenda-se ampliar analises de corner e variacao de processo para robustez estatistica adicional.

## Referencias
- IHP SG13G2 PDK documentation.
- Ngspice user manual.
- Magic VLSI layout tool documentation.
