#!/bin/bash

# See https://apple.stackexchange.com/questions/128384/ocr-on-pdfs-in-os-x-with-free-open-source-tools

usage() {
    echo "Usage: $(basename $0) INPUT_PDF [LANG=eng]"
    exit 1
}

if [ -z "$1" ]; then
    usage
fi

INPUT_PDF="$(cd $(dirname "$1"); pwd)/$(basename "$1")"
NAME="$(basename "${INPUT_PDF%.*}")"
OUTPUT_PDF="$(dirname "${INPUT_PDF}")/"${NAME}_OCR.pdf""
OUTPUT_DIR="$(dirname "${OUTPUT_PDF}")/${NAME}_output"
LANG="${2:-eng}"

echo "INPUT_PDF = $INPUT_PDF"
echo "NAME = $NAME"
echo "OUTPUT_DIR = $OUTPUT_DIR"
echo "OUTPUT_PDF = $OUTPUT_PDF"
echo "LANG = $LANG"

mkdir -p "${OUTPUT_DIR}"

pushd "$OUTPUT_DIR" >/dev/null

gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=jpeg -r300 -dTextAlphaBits=4 \
    -o "${NAME}_page%04d.jpg" -f "$INPUT_PDF"

# process each page
NUM_PAGES=0
for f in $(ls *.jpg); do
  tesseract -l "$LANG" --psm 3 $f ${f%.*} txt
  tesseract -l "$LANG" --psm 3 $f ${f%.*} pdf
  ((NUM_PAGES+=1))
done
echo "$INPUT_PDF: OCR'ed ${NUM_PAGES} page(s)"

# combine all pages back to a single file
gs -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -dNOPAUSE -q \
    -sDEVICE=pdfwrite -sOutputFile="${OUTPUT_PDF}" *.pdf

rm -f *_page*.jpg *_page*.pdf

popd >/dev/null


echo "$INPUT_PDF: OCRed to file $OUTPUT_PDF"
