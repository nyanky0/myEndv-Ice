#!/usr/bin/env bash
# Toggle App Launcher / Launchpad on Super + Space across all shells

if pgrep -f "qs -c macos" >/dev/null 2>&1; then
    qs -c macos ipc call shell launcher 2>/dev/null || true
elif pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call spotlight apps 2>/dev/null || true
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call launcherphone toggle 2>/dev/null || true
elif pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    hyprctl dispatch "hl.dsp.global('quickshell:overviewWorkspacesToggle')" 2>/dev/null || true
else
    pkill fuzzel 2>/dev/null || fuzzel
fi
