#!/usr/bin/env bash
# Dropdown Scratchpad (Persistent Kate) — Toggle open/hide via Super + U / F12

if ! hyprctl clients -j | jq -e '.[] | select(.class == "org.kde.kate")' >/dev/null 2>&1; then
    setsid -f flatpak run org.kde.kate -s dropdown >/dev/null 2>&1 < /dev/null
    for _ in $(seq 1 25); do
        if hyprctl clients -j | jq -e '.[] | select(.class == "org.kde.kate")' >/dev/null 2>&1; then
            break
        fi
        sleep 0.1
    done
fi

hyprctl dispatch "hl.dsp.workspace.toggle_special('dropdown')"
