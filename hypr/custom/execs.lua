-- Autostart custom background services
hl.exec_cmd("pgrep -x avizo-service >/dev/null || avizo-service &")
hl.exec_cmd("pgrep -f polkit-gnome-authentication-agent-1 >/dev/null || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
hl.exec_cmd("pgrep -f 'nautilus --gapplication-service' >/dev/null || nautilus --gapplication-service &")
hl.exec_cmd("pgrep -f 'kate.*dropdown' >/dev/null || flatpak run org.kde.kate -s dropdown >/dev/null 2>&1 &")

-- Autostart awww-daemon for macOS shell wallpaper
hl.exec_cmd([[bash -c 'if [ "$qsConfig" = "macos" ]; then pgrep -x awww-daemon >/dev/null || (awww-daemon & sleep 0.5 && [ -f "$HOME/Pictures/Wallpapers/winter-blossom-miku-moewalls-com.gif" ] && awww img "$HOME/Pictures/Wallpapers/winter-blossom-miku-moewalls-com.gif" --transition-type wipe --transition-angle 30 --transition-step 90 &); fi']])
