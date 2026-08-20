#!/usr/bin/env python3
"""Report the painted-geometry bounding box of the final Magic cell."""

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[2]
MAG_FILE = ROOT / "entrega" / "layout" / "biodiff_top.mag"
OUT_FILE = ROOT / "entrega" / "layout" / "layout_area.md"
SCALE_UM = 0.01
EXCLUDED_LAYERS = {"checkpaint", "labels", "properties"}


def main() -> None:
    layer = ""
    rectangles: list[tuple[int, int, int, int]] = []

    for raw_line in MAG_FILE.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        match = re.fullmatch(r"<< (.+) >>", line)
        if match:
            layer = match.group(1)
            continue
        if not line.startswith("rect ") or layer in EXCLUDED_LAYERS:
            continue
        _, xlo, ylo, xhi, yhi = line.split()
        rectangles.append(tuple(map(int, (xlo, ylo, xhi, yhi))))

    if not rectangles:
        raise SystemExit(f"Nenhuma geometria encontrada em {MAG_FILE}")

    xlo = min(rect[0] for rect in rectangles) * SCALE_UM
    ylo = min(rect[1] for rect in rectangles) * SCALE_UM
    xhi = max(rect[2] for rect in rectangles) * SCALE_UM
    yhi = max(rect[3] for rect in rectangles) * SCALE_UM
    width = xhi - xlo
    height = yhi - ylo
    area_um2 = width * height

    OUT_FILE.write_text(
        "\n".join(
            [
                "# Área do layout BioDiff-CMOS",
                "",
                f"- Célula: `{MAG_FILE.relative_to(ROOT)}`",
                f"- Bounding box da geometria pintada: {width:.2f} µm × {height:.2f} µm",
                f"- Área retangular do bounding box: {area_um2:.2f} µm² ({area_um2 / 1e6:.8f} mm²)",
                f"- Coordenadas: ({xlo:.2f}, {ylo:.2f}) µm a ({xhi:.2f}, {yhi:.2f}) µm",
                "- Método: união dos limites de todos os retângulos físicos do arquivo Magic; `checkpaint`, rótulos e propriedades foram excluídos.",
                "- Escopo: área do bloco desenhado, não área de die, pads ou circuito completo de aquisição.",
                "",
            ]
        ),
        encoding="utf-8",
    )
    print(f"OK: {OUT_FILE}")


if __name__ == "__main__":
    main()
