# Dimensionamento do circuito simulado

Fonte: `entrega/sim_pre/biopotential_chain_prelayout.spice`.

## Núcleo diferencial `biodiff_top_pre`

| Dispositivo | Modelo | W | L | Observação |
|---|---|---:|---:|---|
| X0 (par diferencial) | `sg13_lv_nmos` | 3,2 µm | 0,8 µm | ramo `VIN_P` |
| X1 (par diferencial) | `sg13_lv_nmos` | 3,2 µm | 0,8 µm | ramo `VIN_N` |
| XLOAD_N | `rhigh` | 2 µm | 10 µm | carga resistiva |
| XLOAD_P | `rhigh` | 2 µm | 10 µm | carga resistiva |

## Polarização e estágios seguintes

| Elemento | Valor |
|---|---:|
| `VDD_SRC` | 1.8 V |
| `ITAIL_SRC` | 20 µA, fonte ideal |
| `RLPF_SP` | 1,33 MΩ, somente em `VOUT_P` |
| `CLPF_SP` | 1 nF |
| `XADC_P_SP` | PMOS W=4 µm, L=0,35 µm |
| `XADC_N_SP` | NMOS W=2 µm, L=0,35 µm |
| `XBUF_P_SP` | PMOS W=8 µm, L=0,35 µm |
| `XBUF_N_SP` | NMOS W=4 µm, L=0,35 µm |

## Nota

Esta tabela representa os parâmetros das simulações pré e pós-layout. O estágio chamado `XADC` nas netlists é apenas um inversor CMOS simplificado; não há amostragem, quantização ou taxa de conversão definida. A fonte de cauda ideal e a carga assimétrica são limitações declaradas.
