#!/usr/bin/env bash
# Hyprland Smart Lock Screen Trigger (end4-pC, sekaipop, MacShell/MacLock, macos)

LOCK_FILE="/tmp/lock_screen.lock"
if [ -f "$LOCK_FILE" ]; then
    OLD_PID=$(cat "$LOCK_FILE" 2>/dev/null || true)
    if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
        exit 0
    fi
fi
(
    echo $$ > "$LOCK_FILE"
    sleep 1.2
    rm -f "$LOCK_FILE"
) &

if pgrep -f "qs -c end4-pC" >/dev/null 2>&1; then
    qs -c end4-pC ipc call lock activate
elif pgrep -f "qs -c sekaipop" >/dev/null 2>&1; then
    qs -c sekaipop ipc call lock lock
elif pgrep -f "qs -c MacShell" >/dev/null 2>&1; then
    # Clear stale MacLock stuck in busy/stopping (SUPER+L only fires when unlocked)
    state=$(qs -c MacLock ipc call lockscreen state 2>/dev/null || true)
    if [ "$state" = "busy" ] || [ "$state" = "stopping" ]; then
        pkill -9 -f 'qs -c Mac[L]ock' 2>/dev/null || true
        sleep 0.15
    fi
    setsid -f bash -c 'sh "$HOME/.config/quickshell/MacLock/lock-via-ipc.sh" || (pidof hyprlock >/dev/null || hyprlock)' >/dev/null 2>&1 < /dev/null
else
    # In macos or standalone shell, use hyprlock (clear stale hung hyprlock if no layer exists)
    if pidof hyprlock >/dev/null 2>&1 && ! hyprctl layers 2>/dev/null | grep -q "hyprlock"; then
        pkill -9 -x hyprlock 2>/dev/null || true
    fi
    pidof hyprlock >/dev/null || hyprlock
fi
