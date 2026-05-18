# pex_post

Resultados da simulacao pos-layout com netlist extraida.

## Arquivos
- `biodiff_extracted.spice`: netlist PEX do bloco diferencial.
- `biopotential_chain_postlayout_clean.spice`: testbench pos-layout.
- `biopotential_chain_postlayout_clean.log`: log bruto do ngspice.
- `post_metrics.md`: metricas extraidas no pos-layout.
- `post_ac_gain.png`: curva AC pos-layout.
- `post_tran_vout.png`: resposta temporal pos-layout.
- `pre_vs_post_table.md`: comparacao consolidada pre x pos.

## Reproducao
```bash
./scripts/entrega/run_postlayout.sh
./scripts/entrega/extract_metrics.sh \
  ./entrega/sim_pre/biopotential_chain_prelayout.log \
  ./entrega/pex_post/biopotential_chain_postlayout_clean.log \
  > ./entrega/pex_post/pre_vs_post_table.md
```
