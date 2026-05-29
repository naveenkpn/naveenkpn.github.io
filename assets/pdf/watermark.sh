#!/bin/bash

INPUT_PDF="$1"
WATERMARK_TEXT="$2"
OUTPUT_PDF="${3:-watermarked_output.pdf}"

# Validate arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 input.pdf 'Watermark Text' [output.pdf]"
    exit 1
fi

# Check input file
if [ ! -f "$INPUT_PDF" ]; then
    echo "Error: Input PDF not found!"
    exit 1
fi

# Temporary files
TEMP_DIR=$(mktemp -d)
TEMP_WATERMARK_PNG="$TEMP_DIR/watermark.png"
TEMP_WATERMARK_PDF="$TEMP_DIR/watermark.pdf"

# Get first page dimensions (points)
PAGE_INFO=$(pdfinfo "$INPUT_PDF" | grep "Page size")
PDF_WIDTH=$(echo "$PAGE_INFO" | awk '{print int($3)}')
PDF_HEIGHT=$(echo "$PAGE_INFO" | awk '{print int($5)}')

echo "PDF size: ${PDF_WIDTH}x${PDF_HEIGHT}"

# Create transparent watermark image
magick -size ${PDF_WIDTH}x${PDF_HEIGHT} xc:none \
    -gravity center \
    -fill "rgba(128,128,128,0.25)" \
    -font DejaVu-Sans-Bold \
    -pointsize 100 \
    -annotate 315x0+0 "$WATERMARK_TEXT" \
    "$TEMP_WATERMARK_PNG"

# Convert watermark image to PDF
magick "$TEMP_WATERMARK_PNG" "$TEMP_WATERMARK_PDF"

# Apply watermark
pdftk "$INPUT_PDF" background "$TEMP_WATERMARK_PDF" output "$OUTPUT_PDF"

# Cleanup
rm -rf "$TEMP_DIR"

echo "Watermarked PDF created: $OUTPUT_PDF"
