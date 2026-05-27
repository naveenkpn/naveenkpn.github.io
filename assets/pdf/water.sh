#!/bin/bash

# Watermark PDF with institute name
# Usage: ./watermark_pdf.sh input.pdf "Institute Name" output.pdf

INPUT_PDF="$1"
WATERMARK_TEXT="$2"
OUTPUT_PDF="${3:-watermarked_output.pdf}"

# Check if input file exists
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Input PDF not found!"
    exit 1
fi

# Create temporary watermark PDF
TEMP_WATERMARK="temp_watermark.pdf"

# Create watermark using convert (ImageMagick)
# Get PDF dimensions
PDF_WIDTH=$(pdfinfo "$INPUT_PDF" | grep "Page size" | awk '{print $3}')
PDF_HEIGHT=$(pdfinfo "$INPUT_PDF" | grep "Page size" | awk '{print $5}')

# Create watermark image
convert -size ${PDF_WIDTH}x${PDF_HEIGHT} xc:none \
    -font Arial-Bold -pointsize 72 \
    -fill "rgba(128,128,128,0.3)" \
    -gravity center \
    -annotate +0+0 "$WATERMARK_TEXT" \
    temp_watermark.png

# Convert watermark image to PDF
convert temp_watermark.png "$TEMP_WATERMARK"

# Overlay watermark on all pages
pdftk "$INPUT_PDF" stamp "$TEMP_WATERMARK" output "$OUTPUT_PDF"

# Clean up
rm temp_watermark.png "$TEMP_WATERMARK"

echo "Watermarked PDF created: $OUTPUT_PDF"
