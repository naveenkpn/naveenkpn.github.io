#!/bin/bash
#
# Usage:
#   ./blur-pages.sh input.pdf output.pdf 34 35 36 ...
#
# Requires: pdftk, ghostscript (gs), ImageMagick (convert)

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 input.pdf output.pdf page1 [page2 ...]"
    exit 1
fi

INPUT="$1"
OUTPUT="$2"
shift 2

PAGES=("$@")

WORKDIR=$(mktemp -d)
echo "Using temp directory: $WORKDIR"

# Sort page numbers and remove duplicates
SORTED_PAGES=($(printf "%s\n" "${PAGES[@]}" | sort -n | uniq))

echo "Pages to blur: ${SORTED_PAGES[*]}"

# --- Extract pages to blur ---
pdftk "$INPUT" cat $(printf "%s " "${SORTED_PAGES[@]}") output "$WORKDIR/extracted.pdf"

# --- Rasterize ---
echo "Rasterizing..."
gs -sDEVICE=png16m -r300 -o "$WORKDIR/page_%d.png" "$WORKDIR/extracted.pdf"

# --- Blur each rasterized image ---
echo "Blurring..."
for img in "$WORKDIR"/page_*.png; do
    convert "$img" -blur 0x25 "$img"
done

# --- Convert back to a multi-page PDF ---
convert "$WORKDIR"/page_*.png "$WORKDIR/blurred.pdf"

# How many blurred pages?
BLURRED_COUNT=$(pdftk "$WORKDIR/blurred.pdf" dump_data | awk '/NumberOfPages/ {print $2}')

# --- Reassemble the output PDF ---
echo "Reassembling final PDF..."

TOTAL_PAGES=$(pdftk "$INPUT" dump_data | awk '/NumberOfPages/ {print $2}')
SEQUENCE=""
CURRENT=1
BLUR_INDEX=1

for P in "${SORTED_PAGES[@]}"; do
    BEFORE=$((P-1))

    # Add unblurred pages from CURRENT to BEFORE
    if [ $CURRENT -le $BEFORE ]; then
        SEQUENCE+="A${CURRENT}-${BEFORE} "
    fi

    # Add the corresponding blurred page
    SEQUENCE+="B${BLUR_INDEX} "
    BLUR_INDEX=$((BLUR_INDEX+1))

    CURRENT=$((P+1))
done

# Add remaining pages after last blurred page
if [ $CURRENT -le $TOTAL_PAGES ]; then
    SEQUENCE+="A${CURRENT}-end"
fi

pdftk A="$INPUT" B="$WORKDIR/blurred.pdf" cat $SEQUENCE output "$OUTPUT"

echo "Done!"
echo "Blurred PDF written to: $OUTPUT"

