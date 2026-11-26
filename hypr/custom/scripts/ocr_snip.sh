#!/usr/bin/env bash
# Direct OCR Text Snip

REGION=$(slurp 2>/dev/null)
[ -z "$REGION" ] && exit 0

TMP="/tmp/ocr_$(date +%s).png"
grim -g "$REGION" "$TMP" || exit 1

TEXT=$(tesseract "$TMP" stdout -l eng 2>/dev/null | sed '/^[[:space:]]*$/d')
rm -f "$TMP"

if [ -n "$TEXT" ]; then
    echo -n "$TEXT" | wl-copy
    notify-send -a "Text OCR" -i "edit-copy" "Teks Berhasil Disalin!" "$TEXT"
else
    notify-send -a "Text OCR" -i "dialog-warning" "Tidak ada teks yang terdeteksi"
fi
