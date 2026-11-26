#!/usr/bin/env bash
# Toggle Search Bar / Spotlight on Alt + Space across all shells

if pgrep -f "qs -c macos" >/dev/null 2>&1; then
    qs -c macos ipc call shell spotlight 2>/dev/null || true
elif pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call spotlight toggle 2>/dev/null || true
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call launcherphone toggle 2>/dev/null || true
elif pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    qs -c end4-pC ipc call search toggle 2>/dev/null || hyprctl dispatch "hl.dsp.global('quickshell:searchToggle')" 2>/dev/null || true
else
    pkill fuzzel 2>/dev/null || fuzzel
fi
