# Checklist de Entrega - Projeto Bio-aquisicao CMOS

## 1. Escopo e especificacoes
- [ ] Descricao da cadeia completa: `BioDiff-CMOS -> Filtro LPF -> ADC`
- [ ] Tabela de especificacoes no relatorio (`VDD`, `Av`, swing de entrada, tecnologia)
- [ ] Definicao explicita de `Vcm` e entrada diferencial (evitar ambiguidade de tensao negativa absoluta)

## 2. BioDiff-CMOS (esquematico)
- [ ] Esquematico final salvo (Xschem/Magic compativel)
- [ ] Dimensionamento `W/L` documentado
- [ ] Correntes de polarizacao documentadas
- [ ] Justificativa de escolha da topologia (par diferencial + carga ativa + tail)

## 3. Simulacao pre-layout (golden)
- [ ] Arquivo de testbench SPICE versionado
- [ ] Simulacao `.op` com pontos de operacao
- [ ] Simulacao `.ac` com ganho e banda
- [ ] Simulacao `.tran` com entrada em mV
- [ ] Prints obrigatorios: `vin+`, `vin-`, `vout`, curva de ganho
- [ ] Medidas no relatorio: `Av@1k`, `f-3dB`, consumo

## 4. Filtro passa-baixa
- [ ] Topologia definida (1a/2a ordem)
- [ ] `f_c` especificada e justificada
- [ ] Simulacao de magnitude/fase
- [ ] Print da resposta em frequencia
- [ ] Integracao com saida do BioDiff validada

## 5. ADC (integracao de cadeia)
- [ ] Modelo ADC escolhido (ideal/comportamental)
- [ ] Interface analogica conectada ao filtro
- [ ] Evidencia de conversao para dominio digital
- [ ] Print/sinal demonstrando funcionamento fim-a-fim

## 6. Layout do BioDiff
- [ ] Celula de layout final salva (`.mag`)
- [ ] Exportacao GDS gerada (`.gds`)
- [ ] Simetria do par diferencial aplicada
- [ ] Roteamento critico balanceado nas entradas diferenciais
- [ ] Print do layout completo

## 7. DRC
- [ ] DRC executado na tecnologia correta (`ihp-sg13g2`/equivalente)
- [ ] Relatorio DRC anexado
- [ ] `0` erros criticos (ou justificativa de excecoes, se permitido)
- [ ] Print da execucao/resultado DRC

## 8. Extracao de parasitas + pos-layout
- [ ] Netlist extraido (`*_extracted.spice`) gerado
- [ ] Confirmacao de parasitas `C` e `R`
- [ ] Testbench pos-layout configurado com `.include` correto
- [ ] Simulacao pos-layout `.ac` e `.tran`
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
- [ ] Todos os comandos reproduziveis
- [ ] Caminhos de include sem placeholder
- [ ] Figuras legiveis e com legenda
- [ ] Valores numericos coerentes entre texto e log
- [ ] Pacote final abre em outra maquina sem ajuste manual
