#!/usr/bin/env bash
if pgrep -f "qs -p.*shell_switcher.qml" >/dev/null 2>&1; then
    pkill -f "qs -p.*shell_switcher.qml"
else
    nohup qs -p "$HOME/.config/hypr/custom/scripts/shell_switcher.qml" >/dev/null 2>&1 &
fi
