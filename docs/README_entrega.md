# Entrega revisada para o CBEB 2026

## Arquivos principais

- `docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf`: artigo no template IEEE.
- `docs/cbeb2026/main.tex`: fonte do artigo.
- `docs/resposta_revisores_v06.md`: resposta ponto a ponto.
- `docs/tabela_comparativa_biodiff_cmos.md`: auditoria das referências e métricas.
- `docs/plano_ajustes_biodiff_cmos.md`: plano e estado da execução.

O DOCX v05 foi preservado como histórico. O PDF v06 é a versão limpa para conferência.

## Correções centrais

- maturidade descrita como pré-silício, sem fabricação e sem ECG real;
- corte do filtro corrigido de aproximadamente 186 Hz para 120,884 Hz;
- tabela única de especificações com pré e pós-layout;
- caracterização de ganho, CMRR, PSRR+, ruído e offset, com limitações;
- ICMR registrado como não caracterizado com polarização física;
- triagem PVT de cinco pontos e Monte Carlo declarado como pendente;
- área do núcleo de 934,56 µm², sem pads;
- PEX descrita como capacitiva/híbrida;
- comparação bibliográfica corrigida em fontes primárias;
- estratégia de MPW e medição futura condicionada ao fechamento das especificações.

## Validação do pacote

```bash
./docs/cbeb2026/build.sh
./scripts/entrega/audit_entrega.sh
```

O PDF deve ter entre 4 e 8 páginas, todas as fontes incorporadas e nenhuma referência LaTeX indefinida.

## Ação antes da submissão

Criar um commit ou tag imutável correspondente ao PDF final e revisar os metadados de autores, afiliações, idioma e categoria na plataforma do CBEB.
