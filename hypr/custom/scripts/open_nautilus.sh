#!/usr/bin/env bash
# Smart File Manager (Nautilus) Launcher with Debounce

# 1. Debounce protection: ignore repeat presses within 1.2 seconds
LOCK_FILE="/tmp/nautilus_launch.lock"
if [ -f "$LOCK_FILE" ]; then
    PID=$(cat "$LOCK_FILE" 2>/dev/null)
    if kill -0 "$PID" 2>/dev/null; then
        exit 0
    fi
fi

(
    echo $$ > "$LOCK_FILE"
    sleep 1.2
    rm -f "$LOCK_FILE"
) &

# 2. Check if a Nautilus window is already open
if hyprctl clients -j 2>/dev/null | jq -e '.[] | select(.class == "org.gnome.Nautilus")' >/dev/null 2>&1; then
    # Bring existing window to focus
    hyprctl dispatch focuswindow "class:^(org.gnome.Nautilus)$"
else
    # Start fresh instance
    nautilus &
fi
