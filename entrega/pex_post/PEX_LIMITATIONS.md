# Escopo e limitações da extração

## Estado usado no artigo

`biodiff_extracted.spice` contém dois NMOS, 18 capacitâncias, nenhuma resistência parasita de interconexão e duas cargas `rhigh` reconstruídas pelo script de compatibilidade. O artigo classifica corretamente esse resultado como extração capacitiva e modelo pós-layout híbrido.

## Evidência da limitação

- `shared_xserver/projetos/biodiff_top.ext` registra os corpos `xres` como nós, sem `device rsubckt rhigh`.
- Os contatos `pc` do layout manual ficam fora das extremidades pintadas de `xres`.
- Os rótulos `VOUT_P` e `VOUT_N` não estão conectados por metal aos terminais reais dos resistores extraídos.
- O script ativa `ext2spice extresist on`, mas não executa a sequência `ext2sim` + `extresist` necessária para calcular resistências distribuídas. Por isso, o número de resistores parasitas é zero.
- O fallback acrescenta `XLOAD_N` e `XLOAD_P` a partir da intenção de projeto; esses dois dispositivos não são evidência de extração física.

## Correção recomendada para a próxima rodada

1. Substituir os retângulos `xres` manuais por células geradas com `magic::gencell sg13g2::rhigh`, usando `l=10u`, `w=2u`, `guard=0` e portas habilitadas.
2. Conectar as portas do gerador aos drenos e ao barramento VDD por metal e contatos reconhecidos pelo PDK.
3. Executar a sequência completa de extração resistiva usada pelos testes do PDK.
4. Reexecutar DRC, LVS, extração, simulações pós-layout, caracterização e triagem PVT.
5. Publicar novos valores somente depois de toda a cadeia fechar.

Não foi feita essa alteração nesta revisão porque mudar a geometria sem repetir todas as verificações criaria uma evidência não validada. A limitação foi mantida de forma explícita no manuscrito e na resposta aos revisores.
