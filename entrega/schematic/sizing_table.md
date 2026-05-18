# Sizing Table (Simulacao Entregue)

Fonte: `entrega/sim_pre/biopotential_chain_prelayout.spice`.

## Core diferencial `biodiff_top_pre`

| Dispositivo | Modelo | W | L | Observacao |
|---|---|---:|---:|---|
| X0 (par diff) | `sg13_lv_nmos` | 3.2 um | 0.8 um | ramo VIN_P |
| X1 (par diff) | `sg13_lv_nmos` | 3.2 um | 0.8 um | ramo VIN_N |
| XLOAD_N | `rhigh` | 2 um | 10 um | carga resistiva |
| XLOAD_P | `rhigh` | 2 um | 10 um | carga resistiva |

## Polarizacao e estagios seguintes

| Elemento | Valor |
|---|---:|
| `VDD_SRC` | 1.8 V |
| `ITAIL_SRC` | 20 uA |
| `RLPF_SP` | 1.33 Mohm |
| `CLPF_SP` | 1 nF |
| `XADC_P_SP` | PMOS W=4 um, L=0.35 um |
| `XADC_N_SP` | NMOS W=2 um, L=0.35 um |
| `XBUF_P_SP` | PMOS W=8 um, L=0.35 um |
| `XBUF_N_SP` | NMOS W=4 um, L=0.35 um |

## Nota
Esta tabela representa exatamente os parametros da simulacao pre/post usadas no pacote final.
