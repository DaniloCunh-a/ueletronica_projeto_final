* Common characterization deck for BioDiff-CMOS.
* The wrapper must provide .subckt biodiff_dut with this pin order:
* VIN_N VIN_P VOUT_N VOUT_P VDD TAIL VSS

.option TEMP=27
.option warn=1
.option method=gear

* Reproduces the asymmetric load used by the delivered pre/post testbenches.
.subckt biodiff_loaded VIN_N VIN_P VOUT_N VOUT_P VDD TAIL VSS
XCORE VIN_N VIN_P VOUT_N VOUT_P VDD TAIL VSS biodiff_dut
RLPF VOUT_P VLPF 1.33Meg
CLPF VLPF VSS 1n
XADC_P DOUT VLPF VDD VDD sg13_lv_pmos w=4u l=0.35u
XADC_N DOUT VLPF VSS VSS sg13_lv_nmos w=2u l=0.35u
XBUF_P DOUT_BUF DOUT VDD VDD sg13_lv_pmos w=8u l=0.35u
XBUF_N DOUT_BUF DOUT VSS VSS sg13_lv_nmos w=4u l=0.35u
.ends

* Differential gain and noise copy.
VDD_D VDD_D 0 DC 1.8 AC 0
VCM_D VCM_D 0 DC 0.9 AC 0
VDIFF_D VDIFF_D 0 DC 0 AC 1
BIP_D VINP_D 0 V=V(VCM_D)+0.5*V(VDIFF_D)
BIN_D VINN_D 0 V=V(VCM_D)-0.5*V(VDIFF_D)
ITAIL_D TAIL_D 0 DC 20u
XD VINN_D VINP_D VON_D VOP_D VDD_D TAIL_D 0 biodiff_loaded

* Common-mode gain diagnostic copy.
VDD_C VDD_C 0 DC 1.8 AC 0
VCM_C VCM_C 0 DC 0.9 AC 1
VDIFF_C VDIFF_C 0 DC 0 AC 0
BIP_C VINP_C 0 V=V(VCM_C)+0.5*V(VDIFF_C)
BIN_C VINN_C 0 V=V(VCM_C)-0.5*V(VDIFF_C)
ITAIL_C TAIL_C 0 DC 20u
XC VINN_C VINP_C VON_C VOP_C VDD_C TAIL_C 0 biodiff_loaded

* Differential-output supply sensitivity diagnostic copy.
VDD_P VDD_P 0 DC 1.8 AC 1
VCM_P VCM_P 0 DC 0.9 AC 0
VDIFF_P VDIFF_P 0 DC 0 AC 0
BIP_P VINP_P 0 V=V(VCM_P)+0.5*V(VDIFF_P)
BIN_P VINN_P 0 V=V(VCM_P)-0.5*V(VDIFF_P)
ITAIL_P TAIL_P 0 DC 20u
XP VINN_P VINP_P VON_P VOP_P VDD_P TAIL_P 0 biodiff_loaded

* DC transfer and common-mode sweep copy.
VDD_T VDD_T 0 DC 1.8
VCM_T VCM_T 0 DC 0.9
VDIFF_T VDIFF_T 0 DC 0
BIP_T VINP_T 0 V=V(VCM_T)+0.5*V(VDIFF_T)
BIN_T VINN_T 0 V=V(VCM_T)-0.5*V(VDIFF_T)
ITAIL_T TAIL_T 0 DC 20u
XT VINN_T VINP_T VON_T VOP_T VDD_T TAIL_T 0 biodiff_loaded

.control
set noaskquit
set wr_singlescale

ac dec 200 0.05 1Meg
let avd = abs(v(VOP_D)-v(VON_D))
let acm = abs(v(VOP_C)-v(VON_C))
let aps = abs(v(VOP_P)-v(VON_P))
let cmrr_db = 20*log10(avd/(acm+1e-30))
let psrr_db = 20*log10(avd/(aps+1e-30))
meas ac AVD_10HZ find avd at=10
meas ac AVD_100HZ find avd at=100
meas ac AVD_1KHZ find avd at=1k
meas ac ACM_10HZ find acm at=10
meas ac ACM_100HZ find acm at=100
meas ac ACM_1KHZ find acm at=1k
meas ac CMRR_DIAG_10HZ_DB find cmrr_db at=10
meas ac CMRR_DIAG_100HZ_DB find cmrr_db at=100
meas ac CMRR_DIAG_1KHZ_DB find cmrr_db at=1k
meas ac APS_10HZ find aps at=10
meas ac APS_100HZ find aps at=100
meas ac APS_1KHZ find aps at=1k
meas ac PSRR_DIAG_10HZ_DB find psrr_db at=10
meas ac PSRR_DIAG_100HZ_DB find psrr_db at=100
meas ac PSRR_DIAG_1KHZ_DB find psrr_db at=1k

* Input-referred integrated noise for two explicitly declared bands.
noise v(VOP_D,VON_D) VDIFF_D dec 200 0.05 150
echo IRN_0P05_150_HZ_VRMS: $&inoise_total
noise v(VOP_D,VON_D) VDIFF_D dec 200 0.5 150
echo IRN_0P5_150_HZ_VRMS: $&inoise_total

* Large-signal differential transfer. This is an electrical sweep, not ECG.
dc VDIFF_T -1.8 1.8 1m
let vod = v(VOP_T)-v(VON_T)
meas dc VOD_MAX max vod
meas dc VOD_MIN min vod
meas dc VOUTP_MAX max v(VOP_T)
meas dc VOUTP_MIN min v(VOP_T)
meas dc VOS_NOMINAL when vod=0 cross=1

* Diagnostic common-mode sweep with 1 mV differential stimulus.
* The ideal tail source allows nonphysical tail voltages at low VCM, so this
* sweep cannot establish a fabrication-relevant ICMR.
alter VDIFF_T = 1m
dc VCM_T 0 1.799 1m
let gain_vcm = abs((v(VOP_T)-v(VON_T))/1m)
meas dc GAIN_VCM_0 find gain_vcm at=0
meas dc GAIN_VCM_09 find gain_vcm at=0.9
meas dc GAIN_VCM_179 find gain_vcm at=1.79
meas dc TAIL_VCM_0 find v(TAIL_T) at=0
meas dc TAIL_VCM_09 find v(TAIL_T) at=0.9
meas dc TAIL_VCM_179 find v(TAIL_T) at=1.79

quit
.endc
