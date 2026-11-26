#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%F_%H%M%S)"
BACKUP_DIR="$HOME/.config/hypr/backups/pre_myendv_$TS"

echo "[1/7] Checking AUR helper (yay)..."
if ! command -v yay >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm base-devel git
    TMP_YAY="$(mktemp -d)"
    git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$TMP_YAY/yay-bin"
    (cd "$TMP_YAY/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$TMP_YAY"
fi

echo "[2/7] Installing pacman & AUR packages..."
mapfile -t PKGS < <(grep -vE '^\s*(#|$)' "$REPO_DIR/pkglist.txt")
yay -S --needed --noconfirm "${PKGS[@]}"

echo "[3/7] Installing Flathub (--user) apps..."
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
mapfile -t FLATPAKS < <(grep -vE '^\s*(#|$)' "$REPO_DIR/flatpak.txt")
flatpak install --user -y flathub "${FLATPAKS[@]}"

echo "[4/7] Backing up existing configs..."
mkdir -p "$BACKUP_DIR"
[ -d "$HOME/.config/hypr" ] && cp -a "$HOME/.config/hypr" "$BACKUP_DIR/hypr" || true
[ -d "$HOME/.config/swaync" ] && cp -a "$HOME/.config/swaync" "$BACKUP_DIR/swaync" || true

echo "[5/7] Deploying Hyprland, SwayNC, and PipeWire configs..."
mkdir -p "$HOME/.config/hypr/custom" "$HOME/.config/swaync" "$HOME/.config/pipewire/pipewire.conf.d"
cp "$REPO_DIR/hypr/hyprland.lua" "$REPO_DIR/hypr/hypridle.conf" "$REPO_DIR/hypr/hyprlock.conf" "$HOME/.config/hypr/"
cp -a "$REPO_DIR/hypr/custom/"* "$HOME/.config/hypr/custom/"
chmod +x "$HOME/.config/hypr/custom/scripts/"*.sh
cp -a "$REPO_DIR/swaync/"* "$HOME/.config/swaync/"
cp "$REPO_DIR/pipewire/10-hires-rates.conf" "$HOME/.config/pipewire/pipewire.conf.d/"
systemctl --user restart pipewire pipewire-pulse wireplumber || true

echo "[6/7] Installing Quickshell shells (MacShell + SekaiPop)..."
mkdir -p "$HOME/.config/quickshell" "$HOME/.config/hypr-macshell"
TMP_SHELLS="$(mktemp -d)"

git clone --depth 1 https://github.com/0-ss/MacShell.git "$TMP_SHELLS/MacShell"
rm -rf "$HOME/.config/quickshell/MacShell" "$HOME/.config/quickshell/MacLock"
cp -a "$TMP_SHELLS/MacShell/MacShell" "$HOME/.config/quickshell/MacShell"
cp -a "$TMP_SHELLS/MacShell/MacLock" "$HOME/.config/quickshell/MacLock"
cp -a "$TMP_SHELLS/MacShell/hypr-macshell/"* "$HOME/.config/hypr-macshell/"
cp "$REPO_DIR/patches/MacShell/shell.qml" "$REPO_DIR/patches/MacShell/MacBar.qml" "$HOME/.config/quickshell/MacShell/"
chmod +x "$HOME/.config/hypr-macshell/scripts/"*.sh "$HOME/.config/quickshell/MacLock/"*.sh 2>/dev/null || true

git clone --depth 1 https://github.com/Blapples/SekaiPop.git "$TMP_SHELLS/SekaiPop"
rm -rf "$HOME/.config/quickshell/sekaipop"
cp -a "$TMP_SHELLS/SekaiPop/sekaipop" "$HOME/.config/quickshell/sekaipop"
rm -rf "$TMP_SHELLS"

echo "[7/7] Installing Ghost Downloader v4.6 + Firefox/Zen extension..."
mkdir -p "$HOME/.local/share/ghost-downloader" "$HOME/.local/bin" "$HOME/.local/share/applications"
TMP_GD="$(mktemp -d)"
curl -fsSL -L -o "$TMP_GD/gd.tar.xz" "https://github.com/XiaoYouChR/Ghost-Downloader-3/releases/download/v4.6/Ghost-Downloader-v4.6-Linux-x86_64.tar.xz"
tar -xJf "$TMP_GD/gd.tar.xz" -C "$HOME/.local/share/ghost-downloader"
ln -sf "$HOME/.local/share/ghost-downloader/Ghost-Downloader-3.bin" "$HOME/.local/bin/ghost-downloader"
cat > "$HOME/.local/share/applications/ghost-downloader.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Ghost Downloader
Comment=A multi-threading async downloader
Exec=$HOME/.local/share/ghost-downloader/Ghost-Downloader-3.bin
Icon=$HOME/.local/share/ghost-downloader/logo.png
Terminal=false
Categories=Network;FileTransfer;
StartupWMClass=Ghost-Downloader-3
EOF
curl -fsSL -L -o "$TMP_GD/gd.xpi" "https://addons.mozilla.org/firefox/downloads/latest/ghost-downloader/addon-latest.xpi" || true
if [ -s "$TMP_GD/gd.xpi" ]; then
    for pdir in "$HOME/.config/mozilla/firefox/"*.default* "$HOME/.config/zen/"*.Default*; do
        [ -d "$pdir" ] || continue
        mkdir -p "$pdir/extensions"
        cp "$TMP_GD/gd.xpi" "$pdir/extensions/ghostdownloader@github.com.xpi"
    done
fi
rm -rf "$TMP_GD"
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

echo ""
echo "Done! Backup saved at: $BACKUP_DIR"
echo "Notes:"
echo "  1. Rebuild Hyprland plugins (hyprbars, Hyprspace, hyprfocus, hyprliquid) via hyprpm if needed."
echo "  2. If you use end4-pC or macos shell, install their upstream quickshell configs into ~/.config/quickshell/."
echo "  3. For Tauon Hi-Res FLAC on external drives, run: flatpak override --user --filesystem=/path/to/FLAC com.github.taiko2k.tauonmb"
