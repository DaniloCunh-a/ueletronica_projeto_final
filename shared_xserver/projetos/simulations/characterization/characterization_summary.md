# Caracterização nominal do BioDiff-CMOS

Condições: IHP SG13G2, `mos_tt/res_typ/cap_typ`, 1,8 V, 27 °C, VCM de 0,9 V, corrente de cauda ideal de 20 µA e carga assimétrica de 1,33 MΩ/1 nF em `VOUT_P`.

| Métrica | Pré-layout | Pós-layout | Observação |
|---|---:|---:|---|
| Ganho diferencial em 10 Hz (V/V) | 9.092601e-01 | 9.092601e-01 | Núcleo com carga do testbench |
| Ganho diferencial em 100 Hz (V/V) | 9.083230e-01 | 9.083230e-01 | Núcleo com carga do testbench |
| Ganho diferencial em 1 kHz (V/V) | 9.069625e-01 | 9.069625e-01 | Núcleo com carga do testbench |
| Ruído referido à entrada, 0,05–150 Hz (V rms) | 3.54578E-05 | 3.54578E-05 | Integração nominal |
| Ruído referido à entrada, 0,5–150 Hz (V rms) | 2.99317E-05 | 2.99317E-05 | Integração nominal |
| Saída diferencial máxima no sweep DC (V) | 1.432374e-01 | 1.432374e-01 | Sweep de entrada ±1,8 V |
| Saída diferencial mínima no sweep DC (V) | -1.432856e-01 | -1.432856e-01 | Sweep de entrada ±1,8 V |
| Excursão diferencial no sweep DC (Vpp) | 0.286523 | 0.286523 | Diferença entre os extremos simulados |
| Offset nominal numérico (V) | -2.531753e-05 | -2.531753e-05 | Sem mismatch; não representa offset de fabricação |
| CMRR nominal em 100 Hz (dB) | 1.282916e+02 | 1.282913e+02 | Otimista: fonte de cauda ideal e ausência de mismatch |
| PSRR+ nominal em 100 Hz (dB) | 4.868266e+01 | 4.868266e+01 | Saída diferencial e polarização ideal |

CMRR, PSRR+ e offset são resultados nominais de simulação. A fonte de cauda ideal e a ausência de mismatch tornam CMRR e offset otimistas. O sweep de modo comum força tensão negativa no nó de cauda em VCM baixo; por isso, este circuito ainda não possui ICMR fisicamente válido. Monte Carlo permanece pendente.
