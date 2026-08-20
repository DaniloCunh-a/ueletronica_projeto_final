v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {BioDiff-CMOS - representacao documental do circuito simulado} -1000 -500 0 0 0.7 0.7 {font=monospace color=#1D3A7A}
T {Fonte executavel autoritativa: entrega/sim_pre/biopotential_chain_prelayout.spice} -1000 -460 0 0 0.38 0.38 {color=#444}
T {IHP SG13G2 | VDD=1.8 V | VCM=0.9 V | fonte de cauda ideal=20 uA} -1000 -435 0 0 0.38 0.38 {color=#444}
B 4 -920 -350 -260 180 {fill=false dash=4}
T {NUCLEO IMPLEMENTADO NO LAYOUT} -900 -390 0 0 0.48 0.48 {font=monospace color=#1D5E9E}
L 4 -840 -285 -340 -285 {}
T {VDD} -610 -320 0 0 0.4 0.4 {font=monospace}
B 4 -800 -260 -660 -190 {fill=false}
B 4 -520 -260 -380 -190 {fill=false}
T {rhigh} -765 -250 0 0 0.34 0.34 {}
T {W/L=2/10 um} -795 -225 0 0 0.3 0.3 {}
T {rhigh} -485 -250 0 0 0.34 0.34 {}
T {W/L=2/10 um} -515 -225 0 0 0.3 0.3 {}
L 4 -730 -285 -730 -260 {}
L 4 -450 -285 -450 -260 {}
L 4 -730 -190 -730 -130 {}
L 4 -450 -190 -450 -130 {}
B 4 -790 -130 -670 0 {fill=false}
B 4 -510 -130 -390 0 {fill=false}
T {M2 NMOS} -765 -115 0 0 0.34 0.34 {color=#1a7a1a}
T {W/L=3.2/0.8 um} -785 -80 0 0 0.29 0.29 {}
T {M1 NMOS} -485 -115 0 0 0.34 0.34 {color=#1a7a1a}
T {W/L=3.2/0.8 um} -505 -80 0 0 0.29 0.29 {}
L 4 -900 -65 -790 -65 {}
L 4 -390 -65 -280 -65 {}
T {VIN_N} -900 -95 0 0 0.34 0.34 {font=monospace}
T {VIN_P} -350 -95 0 0 0.34 0.34 {font=monospace}
T {VOUT_N} -710 -175 0 0 0.32 0.32 {font=monospace color=#0044cc}
T {VOUT_P} -430 -175 0 0 0.32 0.32 {font=monospace color=#0044cc}
L 4 -730 0 -730 40 {}
L 4 -450 0 -450 40 {}
L 4 -730 40 -590 40 {}
L 4 -450 40 -590 40 {}
L 4 -590 40 -590 75 {}
C {devices/isource.sym} -590 105 0 0 {name=ITAIL value=20u spice_ignore=true}
L 4 -590 135 -590 155 {}
C {devices/gnd.sym} -590 155 0 0 {name=GND_TAIL spice_ignore=true}
T {fonte ideal} -545 85 0 0 0.3 0.3 {color=#555}
L 4 -450 -160 -180 -160 {}
T {VOUT_P} -245 -190 0 0 0.34 0.34 {font=monospace color=#0044cc}
B 4 -150 -300 170 80 {fill=false dash=4}
T {FILTRO RC DE 1a ORDEM} -135 -340 0 0 0.45 0.45 {font=monospace color=#996000}
C {devices/res.sym} -70 -160 1 0 {name=RLPF value=1.33Meg spice_ignore=true}
L 4 -180 -160 -100 -160 {}
L 4 -40 -160 60 -160 {}
C {devices/capa.sym} 60 -80 0 0 {name=CLPF value=1n spice_ignore=true}
L 4 60 -160 60 -110 {}
C {devices/gnd.sym} 60 -50 0 0 {name=GND_LPF spice_ignore=true}
T {R=1.33 Mohm} -120 -255 0 0 0.33 0.33 {}
T {C=1 nF} -120 -230 0 0 0.33 0.33 {}
T {fc ideal=119.67 Hz} -120 -205 0 0 0.33 0.33 {}
T {fc simulado=120.884 Hz} -120 -180 0 0 0.33 0.33 {}
L 4 60 -160 260 -160 {}
T {VLPF} 175 -190 0 0 0.34 0.34 {font=monospace color=#0044cc}
B 4 290 -300 780 80 {fill=false dash=4}
T {INTERFACE CMOS SIMPLIFICADA} 310 -340 0 0 0.45 0.45 {font=monospace color=#6A1B9A}
T {Inversor: PMOS 4/0.35 um, NMOS 2/0.35 um} 320 -250 0 0 0.32 0.32 {}
T {Buffer: PMOS 8/0.35 um, NMOS 4/0.35 um} 320 -215 0 0 0.32 0.32 {}
T {Sem amostragem, quantizacao ou taxa definida} 320 -160 0 0 0.32 0.32 {color=#8b0000}
T {Nao constitui um ADC completo} 320 -125 0 0 0.32 0.32 {color=#8b0000}
L 4 260 -160 290 -160 {}
T {Carga externa assimetrica: somente VOUT_P alimenta o RC; VOUT_N permanece sem carga equivalente.} -1000 250 0 0 0.36 0.36 {color=#8b0000}
T {Este arquivo e documental. As simulacoes e metricas devem ser reproduzidas a partir das netlists SPICE versionadas.} -1000 290 0 0 0.36 0.36 {color=#444}
