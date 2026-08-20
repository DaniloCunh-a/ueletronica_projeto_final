# Resultados e análise crítica

## Resultado nominal

| Métrica | Pré-layout | Pós-layout |
|---|---:|---:|
| Ganho do núcleo em 100 Hz | 0,908323 V/V | 0,908323 V/V |
| Corte de −3 dB do filtro | 120,884 Hz | 120,884 Hz |
| CMRR nominal em 100 Hz | 128,292 dB | 128,291 dB |
| PSRR+ nominal em 100 Hz | 48,683 dB | 48,683 dB |
| Ruído referido à entrada, 0,5–150 Hz | 29,9317 µVrms | 29,9317 µVrms |
| Potência pela fonte VDD | 36,0116 µW | 36,0116 µW |

Condição: IHP SG13G2, modelos típicos, 1,8 V, 27 °C, VCM de 0,9 V, fonte de cauda ideal de 20 µA e carga RC somente em `VOUT_P`.

## Leitura técnica

- O ganho inferior à unidade não atende sozinho ao condicionamento de ECG e requer amplificação adicional.
- O ruído integrado é superior ao dos trabalhos representativos comparados.
- O CMRR nominal é otimista porque não inclui descasamento e usa fonte de cauda ideal.
- O corte foi corrigido para 120,884 Hz, medido em relação ao ganho de baixa frequência.
- O filtro é de primeira ordem e não forma sozinho uma cadeia anti-aliasing validada.
- Os resultados pré e pós-layout coincidem na precisão reportada, mas a extração contém 18 capacitâncias, nenhuma resistência parasita de interconexão e duas cargas reconstruídas. Isso não demonstra robustez de fabricação.

## Verificação e variações

- DRC: zero violações no conjunto de regras executado.
- LVS: correspondência única de conectividade, com dispositivos tratados como caixas-pretas equivalentes.
- Triagem PVT: ganho de 0,823 a 1,005 V/V, corte de 119,422 a 124,297 Hz e potência de 32,409 a 39,631 µW.
- Monte Carlo, ICMR com polarização física e faixa linear de excursão permanecem pendentes.

O circuito não foi fabricado, não foi medido em bancada e não adquiriu ECG real.
