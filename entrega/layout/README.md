# Layout do núcleo BioDiff-CMOS

## Arquivos

- `biodiff_top.mag`: célula autoritativa do Magic.
- `biodiff.gds`: exportação GDS.
- `biodiff_top_build.tcl`: construção reproduzível.
- `layout_full.png` e `layout_zoom_inputs.png`: evidências visuais.
- `layout_area.md`: cálculo do bounding box físico.

O bounding box da geometria pintada mede 26,40 µm × 35,40 µm, ou 934,56 µm². Marcadores `checkpaint`, rótulos e propriedades foram excluídos. O valor não inclui pads nem área de die.

O layout contém o núcleo diferencial. O filtro de 1,33 MΩ/1 nF e a interface CMOS pertencem ao testbench e não estão incluídos nessa área.
