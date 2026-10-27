#!/usr/bin/env bash
# Download the course data into ./data (run from your project folder). Usage: bash download-data.sh [course]
# Reads https://learn.chatomics.com/data/<course>/manifest.json, downloads each file, verifies its checksum, unpacks it.
set -euo pipefail
COURSE="${1:-dataviz}"; BASE="https://learn.chatomics.com/data/${COURSE}"
mkdir -p data; cd data
command -v python3 >/dev/null || { echo "python3 is required to read the manifest"; exit 1; }
if command -v sha256sum >/dev/null; then SHA="sha256sum"; else SHA="shasum -a 256"; fi
curl -fsSL "${BASE}/manifest.json" -o .manifest.json
python3 -c 'import json,sys; [print(i["key"].split("/")[-1], i["target"], i["unpack"], i["sha256"], i["size"]) for i in json.load(open(".manifest.json"))]' .manifest.json |
while read -r file target unpack sha size; do
  if [ -e "$target" ] && [ "$unpack" != "none" ]; then echo "✓ $target already present, skipping"; continue; fi
  if [ -f "$file" ] && [ "$($SHA "$file" | cut -d' ' -f1)" = "$sha" ]; then echo "✓ $file already downloaded"; else
    echo "↓ $file ($((size/1000000)) MB)"; curl -fL --retry 3 -C - "${BASE}/${file}" -o "$file"
    [ "$($SHA "$file" | cut -d' ' -f1)" = "$sha" ] || { echo "checksum mismatch for $file — delete it and run again"; exit 1; }
  fi
  case "$unpack" in
    tar.gz) tar -xzf "$file" && rm -f "$file" && echo "  unpacked $file" ;;
    gunzip) gunzip -kf "$file" && rm -f "$file" && echo "  unpacked $file → $target" ;;
    none) ;;
  esac
done
rm -f .manifest.json; echo "Done. Data is in $(pwd)"; ls -la
