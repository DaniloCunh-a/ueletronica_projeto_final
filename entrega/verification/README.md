# verification

## Conteúdo atual
- `drc_report.txt`: log de DRC mais recente.
- `lvs_report.txt`: log de LVS final (`match uniquely`).
- `verification_summary.md`: resumo executivo do status de verificação.
- `gap_analysis.md`: lacunas abertas por critério do enunciado.

## Status
- LVS: aprovado.
- DRC: aprovado (execução final reporta 0 erros totais).

## Evidência mínima para fechamento
- `drc_result.png` (execução final limpa ou com justificativas permitidas).
- `lvs_result.png` (captura da execução limpa).

## Comandos úteis
### 1) Rodar DRC detalhado (no container)
```bash
/home/designer/shared/scripts/entrega/run_drc_detailed.sh
```

Arquivos gerados:
- `drc_magic_stdout.log`
- `drc_listall_raw.txt`
- `drc_summary_by_rule.tsv`
- `drc_report_detailed.txt`

### 2) Gerar checklist final automático
```bash
/home/designer/shared/scripts/entrega/audit_entrega.sh
```

Saída:
- `final_delivery_checklist.md`
