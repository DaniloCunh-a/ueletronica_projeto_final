# Artigo CBEB 2026

Esta pasta contém a versão camera-ready reproduzível do artigo BioDiff-CMOS.

## Gerar o PDF

Na raiz do repositório:

```bash
./docs/cbeb2026/build.sh
```

Saída principal:

- `docs/cbeb2026/ARTIGO_BIODIFF_CMOS_v06_camera_ready.pdf`

O script executa duas passagens do `pdflatex` e falha se o documento ficar fora do intervalo de 4 a 8 páginas exigido para artigo completo pelo CBEB 2026.

## Template e figuras

- A classe `IEEEtran` foi obtida do pacote oficial hospedado no CTAN e mantida em `vendor/IEEEtran` para reprodução local.
- As figuras são geradas pelos scripts em `shared_xserver/scripts/entrega` e copiadas para `figures` durante a consolidação da entrega.
- O DOCX v05 permanece em `docs/` apenas como histórico da rodada de revisão. O PDF desta pasta é a versão formatada para submissão.

Antes do envio, confirme no site do CBEB: categoria, idioma, metadados dos autores, prazo vigente e uso do PDF único.
