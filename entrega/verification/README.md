# Verificação física

## Resultados

- DRC: `Total DRC errors found: 0` no deck executado.
- LVS: `Final result: Circuits match uniquely.`
- Pinos comparados: `VSS`, `VIN_N`, `VIN_P`, `TAIL`, `VOUT_N`, `VOUT_P` e `VDD`.
- Instâncias comparadas: dois `sg13_lv_nmos` e dois `rhigh`.

No LVS, as classes `sg13_lv_nmos` e `rhigh` foram tratadas como caixas-pretas equivalentes. O resultado comprova consistência topológica e de conectividade, não desempenho elétrico.

## Evidências

- `drc_report.txt`, `drc_report_detailed.txt`, `drc_summary_by_rule.tsv` e `drc_listall_raw.txt`.
- `lvs_report.txt`.
- `final_delivery_checklist.md`.

DRC dentro do contêiner:

```bash
cd /home/designer/shared
./scripts/entrega/run_drc_detailed.sh
```

Auditoria final no host:

```bash
./scripts/entrega/audit_entrega.sh
```
