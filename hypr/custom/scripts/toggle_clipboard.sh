#!/usr/bin/env bash
# Unified Clipboard History Toggle (SUPER + V) across all shells

if pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call spotlight clipboard 2>/dev/null || true
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call launcherphone toggleMode clip 2>/dev/null || true
elif pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    hyprctl dispatch "hl.dsp.global('quickshell:overviewClipboardToggle')" 2>/dev/null || true
else
    pkill fuzzel 2>/dev/null || cliphist list | fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy
fi
