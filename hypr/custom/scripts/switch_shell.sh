#!/usr/bin/env bash
# Switch active Quickshell config cleanly without self-killing

TARGET="${1:-end4-pC}"
ENV_FILE="$HOME/.config/hypr/custom/env.lua"
VARS_FILE="$HOME/.config/hypr/custom/variables.lua"

printf 'hl.env("qsConfig", "%s")\n' "$TARGET" > "$ENV_FILE"
printf -- '-- Quickshell config selector\nhl.env("qsConfig", "%s")\n' "$TARGET" > "$VARS_FILE"

# Kill only shell instances (-c <name>), never -p shell_switcher.qml or this script
pkill -f "qs -c " 2>/dev/null || true
pkill -x quickshell 2>/dev/null || true
pkill -x awww-daemon 2>/dev/null || true

sleep 0.4

setsid -f qs -c "$TARGET" >/dev/null 2>&1 < /dev/null

if [ "$TARGET" = "macos" ]; then
    sleep 0.3
    setsid -f awww-daemon >/dev/null 2>&1 < /dev/null
    sleep 0.3
    setsid -f awww img "$HOME/Pictures/Wallpapers/winter-blossom-miku-moewalls-com.gif" \
        --transition-type wipe --transition-angle 30 --transition-step 90 >/dev/null 2>&1 < /dev/null
fi
