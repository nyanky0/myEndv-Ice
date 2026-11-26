# myEndv-Ice

Konfigurasi pribadi EndeavourOS + Hyprland (Lua config 0.55+) dengan dukungan multi-shell di Quickshell, keybind terpadu, audio Hi-Res PipeWire, dan installer otomatis untuk pindah laptop.

## Isi Repositori

- `hypr/`: `hyprland.lua`, `hypridle.conf`, `hyprlock.conf`, dan folder `custom/` berisi aturan jendela, autostart, keybind, dan skrip router di `custom/scripts/`.
- `swaync/`: tema dark frosted glass untuk notification center (`config.json`, `style.css`, `colors.css`).
- `pipewire/`: `10-hires-rates.conf` untuk membuka sample rate `44100` sampai `192000` Hz.
- `patches/MacShell/`: modifikasi `shell.qml` dan `MacBar.qml` (mengaktifkan `WindowBar` bawaan serta IPC `windecor` dan `appearance`).
- `pkglist.txt` & `flatpak.txt`: daftar paket `pacman`/`yay` dan aplikasi Flathub (`--user`).

Folder berat seperti `end4-pC`, `sekaipop`, `MacShell`, dan binary `.so` plugin Hyprland tidak disimpan di repositori ini. Skrip `install.sh` akan mengunduh shell dari sumber aslinya saat pemasangan.

## Cara Pasang di EndeavourOS Baru

```bash
git clone https://github.com/nyanky0/myEndv-Ice.git ~/myEndv-Ice
cd ~/myEndv-Ice
chmod +x install.sh
./install.sh
```

Skrip akan membuat cadangan folder `~/.config/hypr` dan `~/.config/swaync` sebelum menimpa apa pun.

## Shortcut Utama (Multi-Shell)

| Shortcut | Fungsi |
|---|---|
| `SUPER + ALT + /` | Buka popup Shell Switcher (`Hyprland`, `SekaiPop`, `macOS`, `Liquid`) |
| `SUPER + Space` | Buka launcher sesuai shell aktif |
| `ALT + Space` | Buka search bar / Spotlight sesuai shell aktif |
| `SUPER + A` | Toggle sidebar / Control Center / QuickPanel |
| `SUPER + V` / `SUPER + .` | Clipboard history / Emoji picker |
| `SUPER + L` | Kunci layar (`MacLock`, `sekaipop`, `end4-pC`, atau `hyprlock`) |
| `SUPER + U` / `F12` | Toggle dropdown scratchpad Kate |
| `SUPER + E` | Buka atau fokuskan Nautilus (Spacebar untuk peek via Sushi) |
| `SUPER + N` | Buka notification center SwayNC |
| `SUPER + ALT + N` | Toggle `WindowBar` di shell `Liquid` (`MacShell`) |
| `CTRL + SUPER + SHIFT + D` | Toggle mode gelap dan terang |

## Catatan Pasca-Instalasi

1. Plugin Hyprland (`hyprbars`, `Hyprspace`, `hyprfocus`, `hyprliquid`, `dynamic-cursors`) perlu dikompilasi ulang melalui `hyprpm` agar sesuai dengan versi Hyprland di mesin baru.
2. Untuk koleksi FLAC lokal di drive eksternal, izinkan akses Flatpak Tauon ke folder tersebut:
   ```bash
   flatpak override --user --filesystem="/path/ke/folder/FLAC" com.github.taiko2k.tauonmb
   ```
3. File `monitors.lua` dan `workspaces.lua` sengaja tidak disertakan karena bergantung pada resolusi layar masing-masing perangkat.
