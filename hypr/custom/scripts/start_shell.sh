#!/usr/bin/env bash
# Autostart the configured desktop shell if not already running
# Give compositor 1 second to initialize
sleep 1

# If a desktop shell (macos or end4-pC) is already running, do nothing
if pgrep -f "quickshell.*macos" >/dev/null 2>&1 || pgrep -f "quickshell.*end4-pC" >/dev/null 2>&1; then
    exit 0
fi

# Determine configured shell (default to macos)
QS_CONFIG="macos"
if [ -f "$HOME/.config/hypr/custom/env.lua" ]; then
    if grep -q "end4-pC" "$HOME/.config/hypr/custom/env.lua"; then
        QS_CONFIG="end4-pC"
    elif grep -q "macos" "$HOME/.config/hypr/custom/env.lua"; then
        QS_CONFIG="macos"
    fi
fi

if [ "$QS_CONFIG" = "macos" ]; then
    quickshell -p "$HOME/.config/quickshell/macos/shell.qml" >/dev/null 2>&1 &
else
    qs -c end4-pC >/dev/null 2>&1 &
fi
