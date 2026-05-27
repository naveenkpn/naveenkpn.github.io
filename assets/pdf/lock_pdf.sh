#!/bin/bash
#
# Secure a PDF (allow printing, block copy/edit/extract), no user password.
# Overwrites the file.
#
# Usage:
#   ./lock_pdf.sh myfile.pdf
#
# pdftk will *prompt* for the owner password safely.

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 file.pdf"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Error: File not found: $FILE"
    exit 1
fi

# Temporary output
TMP="${FILE%.pdf}_locked.tmp.pdf"

echo "You will now be prompted for the OWNER PASSWORD."
echo "This password is required to modify/unlock the PDF."
echo "Viewers will NOT require it to open."
echo ""

# We want a blank user password (open without password),
# so we use PROMPT for owner, and PROMPT for user, then supply an empty user pw.
# pdftk expects TWO prompts when PROMPT PROMPT is used.

# First prompt: owner password
# Second prompt: user password (we send empty)

echo "Enter OWNER password (required to unlock the PDF):"
read -s OWNERPASS
echo "Retype OWNER password:"
read -s OWNERPASS2

if [ "$OWNERPASS" != "$OWNERPASS2" ]; then
    echo "Error: Passwords do not match."
    exit 1
fi

# Call pdftk
# We give owner_pw PROMPT and user_pw PROMPT, then feed passwords via stdin.
# Second line is empty (blank user password).
printf "%s\n\n" "$OWNERPASS" | pdftk "$FILE" output "$TMP" \
    owner_pw PROMPT \
    user_pw PROMPT \
    allow printing

if [ $? -ne 0 ]; then
    echo "Error: pdftk failed."
    rm -f "$TMP"
    exit 1
fi

mv "$TMP" "$FILE"

echo ""
echo "PDF locked successfully."
echo "File updated: $FILE"
echo "Owner password set. No user password required for opening."
echo "Printing allowed. Copy/edit/extract blocked."

