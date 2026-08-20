#!/usr/bin/env python3
"""Run the canonical figure generator stored in shared_xserver."""

from pathlib import Path
import runpy


ROOT_DIR = Path(__file__).resolve().parents[2]
runpy.run_path(
    ROOT_DIR / "shared_xserver" / "scripts" / "entrega" / "generate_figures.py",
    run_name="__main__",
)
