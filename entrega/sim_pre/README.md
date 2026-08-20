# Simulação pré-layout

## Condição nominal

- IHP SG13G2, `mos_tt/res_typ/cap_typ`;
- 1,8 V, 27 °C, VCM de 0,9 V;
- fonte de cauda ideal de 20 µA;
- entrada AC diferencial de 1 V;
- transiente de 100 mVpp diferenciais em 1 kHz;
- carga de 1,33 MΩ/1 nF somente em `VOUT_P`, seguida por portas CMOS.

## Arquivos

- `biopotential_chain_prelayout.spice`: testbench.
- `pre_metrics_evidence.txt`: saída textual do Ngspice.
- `pre_metrics.md`: métricas consolidadas.
- `pre_ac_response.tsv` e `pre_tran_response.tsv`: dados para gráficos.
- `pre_ac_gain.png` e `pre_tran_vin_vout.png`: figuras geradas.

O corte de 120,884 Hz é medido em relação ao ganho em 1 Hz. O valor antigo de aproximadamente 186 Hz usava uma referência já atenuada em 100 Hz e não deve ser reutilizado.

Execução dentro do contêiner:

```bash
cd /home/designer/shared
./scripts/entrega/run_prelayout.sh
```
