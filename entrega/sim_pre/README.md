# sim_pre

Resultados da simulacao pre-layout (golden model).

## Arquivos
- `biopotential_chain_prelayout.spice`: testbench pre-layout.
- `biopotential_chain_prelayout.log`: log bruto do ngspice.
- `pre_op.txt`: resumo do ponto de operacao.
- `pre_metrics.md`: metricas extraidas (ganho, banda e potencia).
- `pre_ac_gain.png`: curva AC.
- `pre_tran_vin_vout.png`: sinais no transiente.

## Reproducao
```bash
./scripts/entrega/run_prelayout.sh
./scripts/entrega/extract_metrics.sh \
  ./entrega/sim_pre/biopotential_chain_prelayout.log \
  ./entrega/pex_post/biopotential_chain_postlayout_clean.log \
  > ./entrega/pex_post/pre_vs_post_table.md
```
