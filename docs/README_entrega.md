# Checklist de Entrega - Projeto Bio-aquisicao CMOS

## Status atual (parcial)
- Simulacao pos-layout executando sem erro fatal.
- Medicoes atuais no log: `Av_BioDiff_1kHz = 22.73 V/V`, `Av_BioDiff_10kHz = 22.73 V/V`.
- Resultado: ganho dentro da meta de `20-50 V/V`.
- Medicoes adicionais: `f3dB_LPF = 185.35 Hz` e `PAVG = 3.12e-4 W`.

## 1. Escopo e especificacoes
- [x] Descricao da cadeia completa: `BioDiff-CMOS -> Filtro LPF -> ADC`
- [ ] Tabela de especificacoes no relatorio (`VDD`, `Av`, swing de entrada, tecnologia)
- [x] Definicao explicita de `Vcm` e entrada diferencial (evitar ambiguidade de tensao negativa absoluta)

## 2. BioDiff-CMOS (esquematico)
- [x] Esquematico final salvo (Xschem/Magic compativel)
- [x] Dimensionamento `W/L` documentado
- [x] Correntes de polarizacao documentadas
- [x] Justificativa de escolha da topologia (par diferencial + carga ativa + tail)

## 3. Simulacao pre-layout (golden)
- [ ] Arquivo de testbench SPICE versionado
- [ ] Simulacao `.op` com pontos de operacao
- [ ] Simulacao `.ac` com ganho e banda
- [ ] Simulacao `.tran` com entrada em mV
- [ ] Prints obrigatorios: `vin+`, `vin-`, `vout`, curva de ganho
- [ ] Medidas no relatorio: `Av@1k`, `f-3dB`, consumo
Observacao: fluxo `.op/.ac/.tran` foi validado no pos-layout; ainda falta fechar o "golden" pre-layout como etapa separada.

## 4. Filtro passa-baixa
- [x] Topologia definida (1a/2a ordem)
- [x] `f_c` especificada e justificada
- [x] Simulacao de magnitude/fase
- [ ] Print da resposta em frequencia
- [x] Integracao com saida do BioDiff validada

## 5. ADC (integracao de cadeia)
- [x] Modelo ADC escolhido (ideal/comportamental)
- [x] Interface analogica conectada ao filtro
- [x] Evidencia de conversao para dominio digital
- [ ] Print/sinal demonstrando funcionamento fim-a-fim

## 6. Layout do BioDiff
- [x] Celula de layout final salva (`.mag`)
- [x] Exportacao GDS gerada (`.gds`)
- [x] Simetria do par diferencial aplicada
- [x] Roteamento critico balanceado nas entradas diferenciais
- [ ] Print do layout completo

## 7. DRC
- [ ] DRC executado na tecnologia correta (`ihp-sg13g2`/equivalente)
- [ ] Relatorio DRC anexado
- [ ] `0` erros criticos (ou justificativa de excecoes, se permitido)
- [ ] Print da execucao/resultado DRC

## 8. Extracao de parasitas + pos-layout
- [x] Netlist extraido (`*_extracted.spice`) gerado
- [x] Confirmacao de parasitas `C` e `R`
- [x] Testbench pos-layout configurado com `.include` correto
- [x] Simulacao pos-layout `.ac` e `.tran`
- [ ] Prints pos-layout obrigatorios
- [ ] Tabela comparativa pre vs pos-layout (`Av`, `f_c`, consumo, offset)

## 9. LVS
- [ ] LVS rodado entre esquematico e layout
- [ ] Relatorio LVS anexado
- [ ] Status `LVS clean` (ou lista de correcoes realizadas)

## 10. Organizacao dos arquivos para entrega
- [ ] `schematic/` (esquematicos e simbolos)
- [ ] `sim_pre/` (testbenches e logs pre-layout)
- [ ] `layout/` (`.mag`, `.gds`, screenshots)
- [ ] `pex_post/` (netlist extraido, testbench e logs pos-layout)
- [ ] `verification/` (DRC/LVS reports)
- [ ] `report/` (PDF final + figuras)

## 11. Relatorio tecnico (paper)
- [ ] Introducao (motivacao bio-sinal na pele)
- [ ] Metodologia (ferramentas e fluxo)
- [ ] Resultados (pre, layout, pos, DRC, LVS)
- [ ] Analise critica de parasitas e roteamento
- [ ] Conclusao com aderencia as metas (`Av 20-50 V/V`, faixa de operacao)

## 12. Validacao final antes de enviar
- [x] Todos os comandos reproduziveis
- [x] Caminhos de include sem placeholder
- [ ] Figuras legiveis e com legenda
- [x] Valores numericos coerentes entre texto e log
- [ ] Pacote final abre em outra maquina sem ajuste manual
