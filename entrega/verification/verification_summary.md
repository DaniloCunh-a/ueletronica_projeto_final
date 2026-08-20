# Resumo da verificação física

## DRC

- Ferramenta: Magic 8.3.613.
- Tecnologia: IHP SG13G2.
- Evidência: `drc_report.txt`.
- Resultado: `Total DRC errors found: 0` no conjunto de regras executado.

## LVS

- Ferramenta: Netgen 1.5.293.
- Evidência: `lvs_report.txt`.
- Resultado: `Final result: Circuits match uniquely.`
- Pinos: `VSS`, `VIN_N`, `VIN_P`, `TAIL`, `VOUT_N`, `VOUT_P` e `VDD`.
- Dispositivos: dois `sg13_lv_nmos` e dois `rhigh`, tratados como classes caixa-preta equivalentes.

## Interpretação

O DRC confirma ausência de violações reportadas pelo deck executado. O LVS confirma equivalência topológica e de conectividade. Esses resultados não caracterizam ganho, ruído, robustez PVT, fabricabilidade além do deck ou comportamento em silício.
