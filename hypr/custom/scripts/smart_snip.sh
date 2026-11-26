#!/usr/bin/env bash
# Smart Snip with Screenshot, OCR, and QR Code Reader

SAVE_DIR="$(xdg-user-dir PICTURES)/Screenshots"
mkdir -p "$SAVE_DIR"
TMP_IMG="/tmp/snip_$(date +%s).png"

# 1. Capture selected region
REGION=$(slurp 2>/dev/null)
[ -z "$REGION" ] && exit 0

grim -g "$REGION" "$TMP_IMG" || exit 1

# Copy image to clipboard immediately
cat "$TMP_IMG" | wl-copy -t image/png

# Save copy to file
TIMESTAMP=$(date '+%Y-%m-%d_%H.%M.%S')
FILE_PATH="$SAVE_DIR/Screenshot_${TIMESTAMP}.png"
cp "$TMP_IMG" "$FILE_PATH"

# 2. Check for QR code in image
QR_TEXT=$(zbarimg --raw -q "$TMP_IMG" 2>/dev/null | tr -d '\r')

# 3. Perform OCR
OCR_TEXT=$(tesseract "$TMP_IMG" stdout -l eng 2>/dev/null | sed '/^[[:space:]]*$/d')

# If QR code detected, notify with QR content
if [ -n "$QR_TEXT" ]; then
    echo -n "$QR_TEXT" | wl-copy
    ACTION=$(notify-send -a "QR Scanner" \
        -i "camera-web" \
        -u normal \
        -A "open=Open Link" \
        -A "copy_img=Copy Image" \
        "QR Code Detected!" "$QR_TEXT")

    if [ "$ACTION" = "open" ]; then
        xdg-open "$QR_TEXT" &
    elif [ "$ACTION" = "copy_img" ]; then
        cat "$TMP_IMG" | wl-copy -t image/png
    fi
elif [ -n "$OCR_TEXT" ]; then
    ACTION=$(notify-send -a "Smart Snip" \
        -i "image-x-generic" \
        -u normal \
        -A "copy_ocr=Copy Text (OCR)" \
        -A "open_file=Open File" \
        "Screenshot Copied to Clipboard" \
        "Teks terdeteksi: \"$(echo "$OCR_TEXT" | head -n 2 | tr '\n' ' ' | cut -c 1-50)...\"")

    if [ "$ACTION" = "copy_ocr" ]; then
        echo -n "$OCR_TEXT" | wl-copy
        notify-send -a "Smart Snip" -i "edit-copy" "Teks Disalin ke Clipboard" "$OCR_TEXT"
    elif [ "$ACTION" = "open_file" ]; then
        xdg-open "$FILE_PATH" &
    fi
else
    ACTION=$(notify-send -a "Smart Snip" \
        -i "image-x-generic" \
        -u normal \
        -A "open_file=Open File" \
        "Screenshot Saved & Copied" \
        "Disimpan ke $FILE_PATH")

    if [ "$ACTION" = "open_file" ]; then
        xdg-open "$FILE_PATH" &
    fi
fi

rm -f "$TMP_IMG"
