# Caracterização elétrica

## Conteúdo

- `biodiff_characterization_common.inc`: testbench comum de ganho, CMRR, PSRR+, ruído, offset e varredura DC.
- `biodiff_characterization_pre.spice` e `biodiff_characterization_post.spice`: wrappers pré e pós-layout.
- `characterization_summary.md`: resultados nominais consolidados.
- `biodiff_characterization_*_evidence.txt`: saídas textuais do Ngspice.
- `pvt_results.tsv` e `pvt_results.md`: triagem de cinco pontos.
- `pvt_screening.png`: comparação gráfica pré e pós-layout.

## Interpretação

CMRR, PSRR+ e offset são resultados nominais. A fonte de cauda ideal e a ausência de descasamento tornam CMRR e offset otimistas. O sweep de modo comum não produz um ICMR fisicamente válido. A excursão de 0,286523 Vpp corresponde aos extremos da varredura DC e não define uma faixa linear.

A triagem PVT combina TT nominal, SS e SF em 1,62 V/85 °C e FF e FS em 1,98 V/−40 °C. Ela não substitui todos os cantos qualificados nem Monte Carlo.

Execução dentro do contêiner:

```bash
cd /home/designer/shared
./scripts/entrega/run_characterization.sh
./scripts/entrega/run_pvt.sh
```
