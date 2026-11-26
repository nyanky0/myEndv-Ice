#!/usr/bin/env bash
# Unified Emoji Picker Toggle (SUPER + Period) across all shells

if pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call spotlight emoji 2>/dev/null || true
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call launcherphone toggleMode emoji 2>/dev/null || true
elif pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    hyprctl dispatch "hl.dsp.global('quickshell:overviewEmojiToggle')" 2>/dev/null || true
else
    pkill fuzzel 2>/dev/null || "$HOME/.config/hypr/hyprland/scripts/fuzzel-emoji.sh" copy
fi
