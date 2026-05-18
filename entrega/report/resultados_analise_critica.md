# Resultados e Analise Critica

## Resultado eletrico consolidado
| Metrica | Pre-layout | Pos-layout |
|---|---:|---:|
| Av_CORE @1kHz (V/V) | 0.906963 | 0.906963 |
| f3dB_LPF (Hz) | 186.08 | 186.08 |
| Potencia media (W) | 3.60116E-05 | 3.60116E-05 |

Fonte: `entrega/pex_post/pre_vs_post_table.md`.

## Leitura tecnica
- O fluxo final nao mostrou degradacao mensuravel apos PEX.
- O `f3dB` em torno de 186 Hz atende ao objetivo de baixa frequencia.
- O consumo medio permaneceu em ~36 uW no cenario de teste adotado.

## Fechamento fisico
- `LVS`: aprovado com `Final result: Circuits match uniquely`.
- `DRC`: aprovado com `Total DRC errors found: 0`.

## Pontos de engenharia observados
- O principal esforco foi no fechamento de regras fisicas (DRC), com iteracoes no roteamento local.
- A consistencia de LVS confirma que as alteracoes de layout nao quebraram intencao do esquematico.
- Como continuidade de validacao, faltam apenas varreduras de robustez (PVT/mismatch), que sao melhoria e nao criterio obrigatorio deste desafio.
