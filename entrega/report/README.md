# report

## Coloque aqui
- paper final em PDF
- figuras finais usadas no paper
- tabelas de resultados
- versão editável em Markdown (`paper_final.md`)

## Estrutura recomendada do paper
1. Introdução
2. Metodologia
3. Resultados (pré, layout, pós, DRC/LVS)
4. Análise crítica de parasitas/roteamento
5. Conclusão com aderência às metas

## Fluxo recomendado
1. Editar `paper_final.md`.
2. Gerar PDF:
```bash
./scripts/entrega/build_report_pdf.sh \
  ./entrega/report/paper_final.md \
  ./entrega/report/paper_final.pdf
```
