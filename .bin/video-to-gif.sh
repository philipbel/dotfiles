#!/bin/bash


INPUT="$1"
OUTPUT="${INPUT%.*}.gif"

ffmpeg -i "$INPUT" -r 10 -f gif - 2>/dev/null | gifsicle --optimize=3 > "$OUTPUT"
echo "Wrote $OUTPUT"
