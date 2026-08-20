# Simulação pós-layout

`biopotential_chain_postlayout_clean.spice` usa o mesmo testbench nominal da etapa pré-layout e substitui apenas o subcircuito diferencial por `biodiff_extracted.spice`.

## Escopo da extração

A netlist desta revisão contém:

- dois NMOS extraídos;
- 18 capacitâncias extraídas;
- nenhuma resistência parasita de interconexão;
- duas cargas `rhigh` reconstruídas para compatibilidade do circuito.

O resultado deve ser chamado de simulação pós-layout capacitiva/híbrida. Ele não representa uma PEX RC completa. A igualdade numérica entre pré e pós-layout na precisão reportada não demonstra robustez de fabricação.

## Arquivos

- `biodiff_extracted.spice`: subcircuito pós-layout.
- `PEX_LIMITATIONS.md`: auditoria da extração e correção recomendada.
- `biopotential_chain_postlayout_clean.spice`: testbench.
- `post_metrics_evidence.txt`: saída textual do Ngspice.
- `post_metrics.md` e `pre_vs_post_table.md`: métricas.
- `post_ac_response.tsv` e `post_tran_response.tsv`: dados tabulados.
- `post_ac_gain.png` e `post_tran_vout.png`: figuras.

Execução dentro do contêiner:

```bash
cd /home/designer/shared
./scripts/entrega/run_postlayout.sh
```
