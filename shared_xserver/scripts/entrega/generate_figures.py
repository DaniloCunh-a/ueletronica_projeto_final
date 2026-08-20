#!/usr/bin/env python3
"""Generate publication figures from the reproducible BioDiff-CMOS data files."""

from __future__ import annotations

import csv
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.patches import Circle, FancyArrowPatch, Rectangle
import numpy as np


BASE_DIR = Path(__file__).resolve().parents[2]
SIM_DIR = BASE_DIR / "projetos" / "simulations"
OUT_DIR = SIM_DIR / "generated_figures"


def configure_plotting() -> None:
    plt.rcParams.update(
        {
            "font.family": "DejaVu Sans",
            "font.size": 9,
            "axes.grid": True,
            "grid.alpha": 0.28,
            "grid.linestyle": ":",
            "figure.facecolor": "white",
            "axes.facecolor": "white",
            "savefig.bbox": "tight",
        }
    )


def load_table(name: str) -> np.ndarray:
    data = np.loadtxt(SIM_DIR / name)
    if data.ndim == 1:
        data = data[np.newaxis, :]
    return data


def save(fig: plt.Figure, name: str) -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUT_DIR / name, dpi=300)
    plt.close(fig)


def plot_pre_ac() -> None:
    data = load_table("pre_ac_response.tsv")
    frequency, core_gain, lpf_gain = data.T
    cutoff = 120.884

    fig, ax = plt.subplots(figsize=(6.8, 3.8))
    ax.semilogx(frequency, 20 * np.log10(core_gain), label="Núcleo diferencial")
    ax.semilogx(frequency, 20 * np.log10(lpf_gain), label="Saída do LPF")
    ax.axvline(cutoff, color="#b22222", linestyle="--", linewidth=1.1, label=f"Corte simulado: {cutoff:.3f} Hz")
    ax.set_xlabel("Frequência (Hz)")
    ax.set_ylabel("Ganho (dB)")
    ax.set_title("Resposta AC pré-layout no corner TT, 1,8 V e 27 °C")
    ax.set_xlim(1, 1e5)
    ax.legend(frameon=False, loc="best")
    save(fig, "pre_ac_gain.png")


def plot_post_ac() -> None:
    pre = load_table("pre_ac_response.tsv")
    post = load_table("post_ac_response.tsv")
    cutoff = 120.884

    fig, ax = plt.subplots(figsize=(6.8, 3.8))
    ax.semilogx(pre[:, 0], 20 * np.log10(pre[:, 2]), label="Pré-layout", linewidth=1.8)
    ax.semilogx(post[:, 0], 20 * np.log10(post[:, 2]), "--", label="Pós-layout híbrido", linewidth=1.3)
    ax.axvline(cutoff, color="#b22222", linestyle=":", linewidth=1.2, label=f"Corte: {cutoff:.3f} Hz")
    ax.set_xlabel("Frequência (Hz)")
    ax.set_ylabel("Ganho do LPF (dB)")
    ax.set_title("Comparação AC pré e pós-layout")
    ax.set_xlim(1, 1e5)
    ax.legend(frameon=False, loc="best")
    save(fig, "post_ac_gain.png")


def plot_pre_transient() -> None:
    data = load_table("pre_tran_response.tsv")
    time_ms = data[:, 0] * 1e3
    vin_diff_mv = (data[:, 1] - data[:, 2]) * 1e3
    vout_diff_mv = (data[:, 3] - data[:, 4]) * 1e3

    mask = (time_ms >= 5) & (time_ms <= 10)
    fig, ax = plt.subplots(figsize=(6.8, 3.8))
    ax.plot(time_ms[mask], vin_diff_mv[mask], label="Entrada diferencial")
    ax.plot(time_ms[mask], vout_diff_mv[mask], label="Saída diferencial")
    ax.set_xlabel("Tempo (ms)")
    ax.set_ylabel("Tensão diferencial (mV)")
    ax.set_title("Teste elétrico transiente pré-layout, 1 kHz")
    ax.legend(frameon=False, loc="best")
    save(fig, "pre_tran_vin_vout.png")


def plot_post_transient() -> None:
    pre = load_table("pre_tran_response.tsv")
    post = load_table("post_tran_response.tsv")
    time_ms = pre[:, 0] * 1e3
    pre_out_mv = (pre[:, 3] - pre[:, 4]) * 1e3
    post_out_mv = (post[:, 3] - post[:, 4]) * 1e3

    mask = (time_ms >= 5) & (time_ms <= 10)
    fig, ax = plt.subplots(figsize=(6.8, 3.8))
    ax.plot(time_ms[mask], pre_out_mv[mask], label="Pré-layout", linewidth=1.8)
    ax.plot(time_ms[mask], post_out_mv[mask], "--", label="Pós-layout híbrido", linewidth=1.2)
    ax.set_xlabel("Tempo (ms)")
    ax.set_ylabel("Saída diferencial (mV)")
    ax.set_title("Comparação transiente pré e pós-layout, 1 kHz")
    ax.legend(frameon=False, loc="best")
    save(fig, "post_tran_vout.png")


def plot_pvt() -> None:
    rows: list[dict[str, str]] = []
    with (SIM_DIR / "pvt_results.tsv").open(encoding="utf-8") as handle:
        rows.extend(csv.DictReader(handle, delimiter="\t"))

    cases = [row["Case"] for row in rows if row["Stage"] == "pre"]
    pre_gain = [float(row["Av_CORE_1kHz_VV"]) for row in rows if row["Stage"] == "pre"]
    post_gain = [float(row["Av_CORE_1kHz_VV"]) for row in rows if row["Stage"] == "post"]
    pre_cutoff = [float(row["f3dB_LPF_Hz"]) for row in rows if row["Stage"] == "pre"]
    post_cutoff = [float(row["f3dB_LPF_Hz"]) for row in rows if row["Stage"] == "post"]
    positions = np.arange(len(cases))

    fig, (ax_gain, ax_cutoff) = plt.subplots(2, 1, figsize=(7.2, 5.2), sharex=True)
    ax_gain.plot(positions, pre_gain, "o-", label="Pré-layout")
    ax_gain.plot(positions, post_gain, "x--", label="Pós-layout híbrido")
    ax_gain.set_ylabel("Ganho em 1 kHz (V/V)")
    ax_gain.set_title("Triagem PVT de cinco pontos")
    ax_gain.legend(frameon=False)

    ax_cutoff.plot(positions, pre_cutoff, "o-", label="Pré-layout")
    ax_cutoff.plot(positions, post_cutoff, "x--", label="Pós-layout híbrido")
    ax_cutoff.set_ylabel("Corte do LPF (Hz)")
    ax_cutoff.set_xticks(positions, cases, rotation=20, ha="right")
    fig.tight_layout()
    save(fig, "pvt_screening.png")


def draw_schematic() -> None:
    fig, ax = plt.subplots(figsize=(11.2, 4.8))
    ax.set_xlim(0, 16)
    ax.set_ylim(0, 8)
    ax.axis("off")

    ax.text(8, 7.65, "BioDiff-CMOS: circuito autoritativo dos testbenches pré e pós-layout", ha="center", fontsize=13, weight="bold")
    ax.text(8, 7.25, "IHP SG13G2, VDD = 1,8 V, VCM = 0,9 V, corrente de cauda ideal = 20 µA", ha="center", fontsize=9)

    core = Rectangle((0.5, 1.2), 7.4, 5.5, fill=False, linewidth=1.4, edgecolor="#1f4e79")
    ax.add_patch(core)
    ax.text(0.75, 6.35, "Núcleo diferencial implementado no layout", color="#1f4e79", weight="bold")

    ax.plot([1.6, 6.8], [5.9, 5.9], color="black", linewidth=1.2)
    ax.text(4.2, 6.05, "VDD", ha="center", weight="bold")

    # Keep the loaded positive output on the right so its route to the RC
    # branch cannot be mistaken for a short between the two drain nodes.
    for x, label, gate, output in [(2.7, "M2", "VIN_N", "VOUT_N"), (5.7, "M1", "VIN_P", "VOUT_P")]:
        ax.add_patch(Rectangle((x - 0.5, 4.75), 1.0, 0.55, fill=False, linewidth=1.2))
        ax.text(x, 5.03, "rhigh\nW/L = 2/10 µm", ha="center", va="center", fontsize=8)
        ax.plot([x, x], [5.3, 5.9], color="black")
        ax.plot([x, x], [4.75, 4.2], color="black")
        ax.add_patch(Rectangle((x - 0.42, 3.0), 0.84, 1.2, fill=False, linewidth=1.2, edgecolor="#2e7d32"))
        ax.text(x, 3.6, f"{label}\nNMOS\nW/L = 3,2/0,8 µm", ha="center", va="center", fontsize=8)
        ax.plot([x - 1.0, x - 0.42], [3.6, 3.6], color="black")
        ax.text(x - 1.08, 3.6, gate, ha="right", va="center", fontsize=8)
        ax.text(x + 0.1, 4.35, output, ha="left", fontsize=8, weight="bold")

    ax.plot([2.7, 2.7, 4.2], [3.0, 2.45, 2.45], color="black")
    ax.plot([5.7, 5.7, 4.2], [3.0, 2.45, 2.45], color="black")
    ax.plot([4.2, 4.2], [2.45, 2.0], color="black")
    ax.add_patch(Circle((4.2, 1.7), 0.3, fill=False, linewidth=1.2))
    ax.add_patch(FancyArrowPatch((4.2, 1.9), (4.2, 1.5), arrowstyle="-|>", mutation_scale=10))
    ax.text(4.65, 1.7, "Fonte ideal\n20 µA", va="center", fontsize=8)
    ax.plot([4.2, 4.2], [1.4, 1.25], color="black")
    ax.text(4.2, 1.05, "VSS", ha="center", fontsize=8)

    ax.add_patch(FancyArrowPatch((5.7, 4.35), (8.55, 4.35), arrowstyle="-|>", mutation_scale=12, linewidth=1.2))
    ax.text(8.15, 4.55, "VOUT_P", fontsize=8, weight="bold")
    ax.add_patch(Rectangle((8.65, 3.25), 2.4, 2.2, fill=False, linewidth=1.4, edgecolor="#8a5a00"))
    ax.text(9.85, 5.1, "Filtro RC de 1ª ordem", ha="center", weight="bold", color="#8a5a00")
    ax.text(9.85, 4.45, "R = 1,33 MΩ\nC = 1 nF\nfc ideal = 119,67 Hz\nfc simulado = 120,884 Hz", ha="center", va="center", fontsize=8.5)

    ax.add_patch(FancyArrowPatch((11.05, 4.35), (12.0, 4.35), arrowstyle="-|>", mutation_scale=12, linewidth=1.2))
    ax.add_patch(Rectangle((12.1, 3.25), 3.3, 2.2, fill=False, linewidth=1.4, edgecolor="#6a1b9a"))
    ax.text(13.75, 5.1, "Interface CMOS simplificada", ha="center", weight="bold", color="#6a1b9a")
    ax.text(13.75, 4.35, "Inversor + buffer\nSem amostragem, quantização\nou taxa de conversão definida", ha="center", va="center", fontsize=8.5)

    ax.text(
        11.9,
        2.65,
        "Carga RC somente em VOUT_P;\nVOUT_N sem carga externa equivalente.",
        ha="center",
        va="center",
        fontsize=8,
        color="#8b0000",
    )
    ax.text(8, 0.35, "A fonte SPICE e os scripts de simulação definem o circuito. A figura não inclui eletrodos, proteção de entrada nem ADC completo.", ha="center", fontsize=8.5)
    save(fig, "schematic_authoritative.png")


def main() -> None:
    configure_plotting()
    plot_pre_ac()
    plot_post_ac()
    plot_pre_transient()
    plot_post_transient()
    plot_pvt()
    draw_schematic()
    print(f"OK: {OUT_DIR}")


if __name__ == "__main__":
    main()
