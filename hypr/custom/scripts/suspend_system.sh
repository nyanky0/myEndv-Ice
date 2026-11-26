#!/usr/bin/env bash
# Hyprland Smart Suspend Script (Locks before sleeping)

# 1. Trigger lock screen
~/.config/hypr/custom/scripts/lock_screen.sh

# 2. Brief delay to let the lock screen surface initialize and render
sleep 0.5

# 3. Trigger system suspend
systemctl suspend || loginctl suspend
