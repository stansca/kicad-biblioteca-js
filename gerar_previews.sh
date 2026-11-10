#!/bin/bash
# Regera as imagens SVG de previews/ a partir da biblioteca (precisa do KiCad 10 instalado).
set -e
cd "$(dirname "$0")"
K=/Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli
command -v kicad-cli >/dev/null && K=kicad-cli
rm -rf previews && mkdir -p previews/simbolos previews/footprints
for f in symbols/*.kicad_sym; do n=$(basename "$f" .kicad_sym); mkdir -p "previews/simbolos/$n"; $K sym export svg -o "previews/simbolos/$n" "$f" >/dev/null; done
for d in footprints/*.pretty; do n=$(basename "$d" .pretty); mkdir -p "previews/footprints/$n"; $K fp export svg --layers F.Cu,F.SilkS,F.Fab,F.CrtYd,Edge.Cuts -o "previews/footprints/$n" "$d" >/dev/null; done
echo "prévias geradas em previews/"
