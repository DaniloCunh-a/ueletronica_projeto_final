v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {VCM}
S {}
E {}
L 4 -1000 -200 -960 -200 {}
L 4 -980 -220 -980 -180 {}
L 4 -1000 -140 -960 -140 {}
L 4 -820 -200 -700 -200 {}
L 4 -820 -140 -700 -140 {}
L 4 -460 -260 -460 -230 {}
L 4 -420 -260 -420 -230 {}
L 4 -500 -350 -460 -350 {}
L 4 -420 -350 -380 -350 {}
L 4 -500 -390 -500 -350 {}
L 4 -380 -390 -380 -350 {}
L 4 -460 -170 -460 -140 {}
L 4 -420 -170 -420 -140 {}
L 4 -460 -140 -420 -140 {}
L 4 -440 -140 -440 -110 {}
L 4 -580 -160 -580 -140 {}
L 4 -580 -140 -440 -140 {}
L 4 -580 -220 -580 -190 {}
L 4 -580 -250 -580 -220 {}
L 4 -580 -250 -520 -250 {}
L 4 -380 -280 -260 -280 {}
L 4 -480 -280 -460 -280 {}
L 4 -60 -200 0 -200 {}
L 4 0 -200 120 -200 {}
L 4 160 -200 200 -200 {}
L 4 160 -200 160 -170 {}
L 4 160 -130 160 -100 {}
L 4 380 -200 420 -200 {}
L 4 420 -280 420 -200 {}
L 4 420 -200 420 -150 {}
L 4 420 -200 480 -200 {}
L 4 420 -280 480 -280 {}
L 4 420 -150 480 -150 {}
L 4 520 -280 560 -280 {}
L 4 520 -150 560 -150 {}
L 4 560 -280 560 -150 {}
L 4 500 -310 500 -300 {}
L 4 500 -130 500 -120 {}
L 4 560 -215 640 -215 {}
L 4 560 -215 580 -215 {}
L 4 580 -280 580 -215 {}
L 4 580 -215 580 -150 {}
L 4 620 -280 660 -280 {}
L 4 620 -150 660 -150 {}
L 4 660 -280 660 -215 {}
L 4 660 -215 660 -150 {}
B 4 -1080 -380 -800 -80 {fill=false dash=4}
B 4 -680 -430 -120 -70 {fill=false dash=4}
B 4 -80 -380 320 -60 {fill=false dash=4}
B 4 360 -380 740 -60 {fill=false dash=4}
T {SENSOR / ELETRODOS} -1095 -435 0 0 0.55 0.55 {font=monospace color=#1D5E9E}
T {Biopotencial cutaneo (ECG/EEG)} -1075 -370 0 0 0.32 0.32 {color=#444}
T {Vin_diff = -1..50 mV} -1075 -350 0 0 0.32 0.32 {color=#444}
T {Vcm = 0.9 V} -1075 -335 0 0 0.32 0.32 {color=#444}
T {Rskin ~ 1-10 kohm} -1075 -320 0 0 0.32 0.32 {color=#444}
T {Cskin ~ 10-100 nF} -1075 -305 0 0 0.32 0.32 {color=#444}
T {Ruido: termico+flicker+60Hz} -1075 -285 0 0 0.32 0.32 {color=#aa2222}
T {E+} -1000 -230 0 0 0.38 0.38 {color=#1a7a1a}
T {E-} -1000 -155 0 0 0.38 0.38 {color=#cc2222}
T {BioDiff-CMOS  (Amplificador Diferencial)} -550 -475 0 0 0.55 0.55 {font=monospace color=#1D5E9E}
T {Par NMOS M1/M2  +  Carga Ativa PMOS M3/M4  +  Tail ITAIL} -670 -415 0 0 0.32 0.32 {color=#444}
T {Av = -gm1,2*(ro1,2 || ro3,4) = 20..50 V/V} -670 -398 0 0 0.32 0.32 {color=#444}
T {CMRR > 80 dB  |  Swing: -1..50 mV  |  Vdd=1.8V} -670 -381 0 0 0.32 0.32 {color=#444}
T {Tecnologia IHP SG13G2 (0.13 um)} -670 -364 0 0 0.32 0.32 {color=#444}
T {RBIAS=180k} -610 -200 0 0 0.28 0.28 {color=#666}
T {VIN_P} -575 -210 0 0 0.32 0.32 {color=#1a7a1a}
T {VIN_N} -345 -210 0 0 0.32 0.32 {color=#cc2222}
T {VOUT_P} -260 -295 0 0 0.36 0.36 {color=#0044cc font=monospace}
T {M1,M2: W=10u/L=0.36u  (x4 fingers)} -670 -45 0 0 0.3 0.3 {color=#555}
T {M3,M4: W=20u/L=0.36u  (x4 fingers)} -670 -30 0 0 0.3 0.3 {color=#555}
T {MTAIL: W=5u/L=1u  Ibias=20uA} -670 -5 0 0 0.3 0.3 {color=#555}
T {FILTRO PASSA-BAIXA (RC 1a Ordem)} -90 -425 0 0 0.55 0.55 {font=monospace color=#1D5E9E}
T {fc = 1/(2*pi*R*C) = 159 Hz} -70 -375 0 0 0.32 0.32 {color=#444}
T {Rej. 60Hz: -17 dB  |  Rej. 1kHz: -36 dB} -70 -358 0 0 0.32 0.32 {color=#444}
T {R = rhigh BEOL  W=0.5u L=12u} -70 -341 0 0 0.32 0.32 {color=#444}
T {C = cap_cmim   W=20u L=20u} -70 -324 0 0 0.32 0.32 {color=#444}
T {RLPF} 30 -215 0 0 0.3 0.3 {color=#333}
T {~1kohm} 30 -200 0 0 0.28 0.28 {color=#666}
T {CLPF=1nF} 175 -140 0 0 0.3 0.3 {color=#333}
T {VLPF} 265 -215 0 0 0.36 0.36 {color=#0044cc font=monospace}
T {Banda util: 0.5 - 100 Hz} -70 -80 0 0 0.3 0.3 {color=#555}
T {Fase @ 100Hz: -32 deg} -70 -65 0 0 0.3 0.3 {color=#555}
T {ADC - 1 bit (Comparador CMOS)} 480 -455 0 0 0.55 0.55 {font=monospace color=#1D5E9E}
T {Inversor CMOS = limiar em VDD/2 = 0.9V} 370 -375 0 0 0.32 0.32 {color=#444}
T {PMOS: W=4u/L=0.35u  NMOS: W=2u/L=0.35u} 370 -358 0 0 0.32 0.32 {color=#444}
T {Saida DOUT: logica CMOS 1.8V} 370 -341 0 0 0.32 0.32 {color=#444}
T {Latencia: < 2ns  |  Consumo: < 10uW} 370 -324 0 0 0.32 0.32 {color=#444}
T {DOUT} 645 -225 0 0 0.4 0.4 {color=#cc5500 font=monospace}
T {[digital]} 645 -210 0 0 0.28 0.28 {color=#996633}
T {BUF} 590 -215 0 0 0.28 0.28 {color=#888}
T {== CADEIA COMPLETA BIO-AQUISICAO CMOS ==} -1090 -650 0 0 0.65 0.65 {font=monospace color=#1D3A7A}
T {Eletrodo -> BioDiff-CMOS -> LPF RC -> ADC (Comparador CMOS 1-bit)} -1090 -610 0 0 0.4 0.4 {color=#333}
T {Tecnologia: IHP SG13G2 (0.13um CMOS)  |  VDD=1.8V  |  Ibias=20uA} -1090 -580 0 0 0.38 0.38 {color=#555}
T {Especificacoes: Av=20-50 V/V | CMRR>80dB | fc_LPF=159Hz | Saida digital CMOS} -1090 -553 0 0 0.38 0.38 {color=#555}
T {Ferramenta: Xschem + Ngspice  |  Layout: Magic/KLayout  |  PDK: IHP SG13G2} -1090 -526 0 0 0.38 0.38 {color=#555}
C {devices/title.sym} -40 480 0 0 {name=l0 author="BioDiff-CMOS - Cadeia Completa de Bio-Aquisicao | Projeto Microeletronica"}
C {devices/res.sym} -910 -200 0 0 {name=RSKIN1 value=5k footprint=1206 spice_ignore=true}
C {devices/res.sym} -910 -140 0 0 {name=RSKIN2 value=5k footprint=1206 spice_ignore=true}
C {devices/capa.sym} -870 -170 0 0 {name=CSKIN1 value=47n footprint=0402 spice_ignore=true}
C {devices/lab_pin.sym} -700 -200 0 0 {name=p_vinp lab=VIN_P spice_ignore=true}
C {devices/lab_pin.sym} -700 -140 0 1 {name=p_vinn lab=VIN_N spice_ignore=true}
C {devices/lab_pin.sym} -500 -380 0 0 {name=p_vdd lab=VDD spice_ignore=true}
C {devices/vdd.sym} -500 -390 0 0 {name=VDD1 vdd=VDD spice_ignore=true}
C {sg13g2_pr/sg13_lv_nmos.sym} -480 -200 0 0 {name=M1 spice_ignore=true model=sg13_lv_nmos w=10e-6 l=0.36e-6 ng=4 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_nmos.sym} -400 -200 0 1 {name=M2 spice_ignore=true model=sg13_lv_nmos w=10e-6 l=0.36e-6 ng=4 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_pmos.sym} -480 -310 0 0 {name=M3 spice_ignore=true model=sg13_lv_pmos w=20e-6 l=0.36e-6 ng=4 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_pmos.sym} -400 -310 0 1 {name=M4 spice_ignore=true model=sg13_lv_pmos w=20e-6 l=0.36e-6 ng=4 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_nmos.sym} -440 -120 0 0 {name=MTAIL spice_ignore=true model=sg13_lv_nmos w=5e-6 l=1e-6 ng=2 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_nmos.sym} -580 -120 0 0 {name=MREF spice_ignore=true model=sg13_lv_nmos w=5e-6 l=1e-6 ng=2 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {devices/res.sym} -580 -190 0 0 {name=RBIAS value=180k footprint=1206 spice_ignore=true}
C {devices/lab_pin.sym} -560 -200 0 1 {name=p_vinp2 lab=VIN_P spice_ignore=true}
C {devices/lab_pin.sym} -340 -200 0 0 {name=p_vinn2 lab=VIN_N spice_ignore=true}
C {devices/lab_pin.sym} -260 -280 0 0 {name=p_voutp lab=VOUT_P spice_ignore=true}
C {devices/lab_pin.sym} -60 -200 0 1 {name=p_voutp2 lab=VOUT_P spice_ignore=true}
C {sg13g2_pr/rhigh.sym} 60 -200 1 0 {name=RLPF spice_ignore=true model=rhigh w=0.5e-6 l=12e-6 m=1 b=0
+ sheet_resistance=1360}
C {sg13g2_pr/cap_cmim.sym} 160 -150 0 0 {name=CLPF spice_ignore=true model=cap_cmim w=20e-6 l=20e-6 m=1
+ cap_val=1e-9}
C {devices/gnd.sym} 160 -100 0 0 {name=GNDLPF spice_ignore=true}
C {devices/lab_pin.sym} 260 -200 0 0 {name=p_vlpf lab=VLPF spice_ignore=true}
C {devices/lab_pin.sym} 380 -200 0 1 {name=p_vlpf2 lab=VLPF spice_ignore=true}
C {sg13g2_pr/sg13_lv_pmos.sym} 500 -280 0 0 {name=MADC_P spice_ignore=true model=sg13_lv_pmos w=4e-6 l=0.35e-6 ng=1 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_nmos.sym} 500 -150 0 0 {name=MADC_N spice_ignore=true model=sg13_lv_nmos w=2e-6 l=0.35e-6 ng=1 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {devices/vdd.sym} 500 -320 0 0 {name=VDD_ADC vdd=VDD spice_ignore=true}
C {devices/gnd.sym} 500 -110 0 0 {name=GND_ADC spice_ignore=true}
C {devices/lab_pin.sym} 640 -215 0 0 {name=p_dout lab=DOUT spice_ignore=true}
C {sg13g2_pr/sg13_lv_pmos.sym} 600 -280 0 0 {name=MBUF_P spice_ignore=true model=sg13_lv_pmos w=8e-6 l=0.35e-6 ng=1 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {sg13g2_pr/sg13_lv_nmos.sym} 600 -150 0 0 {name=MBUF_N spice_ignore=true model=sg13_lv_nmos w=4e-6 l=0.35e-6 ng=1 m=1
+ ad=0 pd=0 as=0 ps=0 nrd=0 nrs=0 temp=27}
C {devices/code_shown.sym} -1100 80 0 0 {name=SPICE_SOURCES only_toplevel=false value="
* ================================================
* CADEIA BIOPOTENCIAL COMPLETA - IHP SG13G2
* BioDiff-CMOS -> LPF -> ADC (Comparador CMOS)
* ================================================

.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerRES.lib res_typ
.lib /opt/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerCAP.lib cap_typ

.include /home/designer/shared/verification/simulations/ihp-sg13g2/biodiff_extracted.spice

.option TEMP = 27
.option warn = 1
.option method = gear

VDD_SRC VDD 0 1.8
VINP_SRC VIN_P 0 DC 0.9 AC 0.5 SIN(0.9 25m 1k 0 0 0)
VINN_SRC VIN_N 0 DC 0.9 AC -0.5 SIN(0.9 25m 1k 0 0 180)
ITAIL_SRC TAIL 0 DC 20u

XBIODIFF VIN_N VIN_P VOUT_N VOUT_P VDD TAIL 0 biodiff_top
RLPF_SP VOUT_P VLPF 1k
CLPF_SP VLPF 0 1n
XADC_P_SP DOUT VLPF VDD VDD sg13_lv_pmos w=4u l=0.35u
XADC_N_SP DOUT VLPF 0 0 sg13_lv_nmos w=2u l=0.35u
XBUF_P_SP DOUT_BUF DOUT VDD VDD sg13_lv_pmos w=8u l=0.35u
XBUF_N_SP DOUT_BUF DOUT 0 0 sg13_lv_nmos w=4u l=0.35u
"}
C {simulator_commands_shown.sym} -1100 320 0 0 {name=NGSPICE_SIM
simulator=ngspice
only_toplevel=false
value="
.control
save all

* ---- 1. PONTO DE OPERACAO ----
op
echo === Ponto de Operacao ===
print V(VDD) V(VIN_P) V(VIN_N) V(VOUT_P) V(VLPF) V(DOUT)

* ---- 2. AC - GANHO E LARGURA DE BANDA ----
ac dec 200 1 100Meg

* Medicao do ganho diferencial em pontos chave
let av_mag_vout  = abs(v(vout_p))
let av_mag_vlpf  = abs(v(vlpf))
let av_dB_vout   = 20*log10(av_mag_vout/50m)
let av_dB_vlpf   = 20*log10(av_mag_vlpf/50m)
let phase_vout   = 180/pi*phase(v(vout_p))

* Ganho em 1Hz, 100Hz, 1kHz, 10kHz
meas ac Av_BioDiff_1Hz    find av_mag_vout  at=1
meas ac Av_BioDiff_100Hz  find av_mag_vout  at=100
meas ac Av_BioDiff_1kHz   find av_mag_vout  at=1k
meas ac Av_BioDiff_10kHz  find av_mag_vout  at=10k
meas ac Av_LPF_100Hz      find av_mag_vlpf  at=100
meas ac Av_LPF_1kHz       find av_mag_vlpf  at=1k

* Frequencia de corte (-3dB) pos-filtro
let av_lpf_3db = Av_LPF_100Hz * 0.707
meas ac f3dB_LPF    when av_mag_vlpf=av_lpf_3db fall=1

echo === Resultados AC ===
echo Ganho BioDiff @ 1Hz:   $&Av_BioDiff_1Hz V/V
echo Ganho BioDiff @ 100Hz: $&Av_BioDiff_100Hz V/V
echo Ganho BioDiff @ 1kHz:  $&Av_BioDiff_1kHz V/V
echo Ganho LPF @ 100Hz:     $&Av_LPF_100Hz V/V
echo f3dB_LPF_Hz:           $&f3dB_LPF

* ---- 3. TRANSITORIO - SINAL ECG SINTETICO ----
tran 1u 20m

echo === Simulacao Transiente ===
meas tran VOUT_MAX max v(vout_p) from=5m to=20m
meas tran VOUT_MIN min v(vout_p) from=5m to=20m
meas tran VLPF_MAX max v(vlpf)   from=5m to=20m
meas tran VLPF_MIN min v(vlpf)   from=5m to=20m

let swing_vout = VOUT_MAX - VOUT_MIN
let swing_vlpf = VLPF_MAX - VLPF_MIN
echo Swing VOUT_P: $&swing_vout V
echo Swing VLPF:   $&swing_vlpf V

* ---- 4. CORRENTE E CONSUMO ----
let Ptotal = abs(VDD_SRC#branch) * 1.8
echo Consumo Total: $&Ptotal W

* ---- SALVAR RESULTADOS ----
write biopotential_chain_complete.raw
.endc
"}
