#!/usr/bin/env bash

SWITCHWALL="$HOME/.config/quickshell/end4-pC/scripts/colors/switchwall.sh"
AGY_SETTINGS="$HOME/.gemini/antigravity-cli/settings.json"
AGY_SCHEME="colorblind-friendly dark"

CURRENT_SCHEME="$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")"
if [ "$CURRENT_SCHEME" = "prefer-dark" ]; then
    NEW_MODE="light"
else
    NEW_MODE="dark"
fi

if pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call theme darkToggle 2>/dev/null || true
    exit 0
fi

if pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call appearance set "$NEW_MODE" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface color-scheme "prefer-$NEW_MODE" 2>/dev/null || true
elif [ -x "$SWITCHWALL" ]; then
    "$SWITCHWALL" --mode "$NEW_MODE" --noswitch
fi

# Reload Kitty live
KITTY_THEME="$HOME/.local/state/quickshell/user/generated/terminal/kitty-theme.conf"
for pid in $(pgrep -x kitty); do
    kitten @ --to "unix:@kitty-$pid" set-colors --all --configured "$KITTY_THEME" >/dev/null 2>&1 \
        || kill -SIGUSR1 "$pid" 2>/dev/null
done

# Sync agy colorScheme so agy CLI text matches the new background
if [ -f "$AGY_SETTINGS" ] && command -v jq >/dev/null 2>&1; then
    jq --arg s "$AGY_SCHEME" '.colorScheme = $s' "$AGY_SETTINGS" > /tmp/agy_st.json && mv /tmp/agy_st.json "$AGY_SETTINGS"
fi

notify-send -a "System Theme" "Theme Changed" "Mode: ${NEW_MODE^^}" -i preferences-desktop-theme -t 1500
