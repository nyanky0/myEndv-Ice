#!/usr/bin/env bash
# Unified Left Sidebar / Control Center / Quick Panel Toggle (SUPER + A) across all shells

if pgrep -f "qs -c macos" >/dev/null 2>&1; then
    qs -c macos ipc call shell toggle controlcenter 2>/dev/null || true
elif pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    qs -c MacShell ipc call controlcenter toggle 2>/dev/null || true
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call quickpanel toggle 2>/dev/null || true
elif pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    hyprctl dispatch "hl.dsp.global('quickshell:sidebarLeftToggle')" 2>/dev/null || true
fi
