hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )
hl.bind("SUPER + ALT + b", hl.dsp.exec_cmd("hyprctl plugin list | grep -q hyprbars && hyprctl plugin unload \"$HOME/.config/hypr/plugins/hyprbars.so\" || (hyprctl plugin load \"$HOME/.config/hypr/plugins/hyprbars.so\" && hyprctl reload)"), {description = "Toggle hyprbars titlebar"})

-- Hyprspace Overview keybind (replaces default quickshell overview)
hl.unbind("SUPER + Tab")
hl.bind("SUPER + Tab", function()
    if hl.plugin and hl.plugin.overview and hl.plugin.overview.toggle then
        hl.plugin.overview.toggle()
    else
        hl.dsp.global("quickshell:overviewWorkspacesToggle")()
    end
end, { description = "Toggle Hyprspace workspace overview" })

-- Overview on Alt + Tab
hl.unbind("ALT + Tab")
hl.bind("ALT + Tab", function()
    if hl.plugin and hl.plugin.overview and hl.plugin.overview.toggle then
        hl.plugin.overview.toggle()
    else
        hl.dsp.global("quickshell:overviewWorkspacesToggle")()
    end
end, { description = "Toggle Hyprspace workspace overview (Alt + Tab)" })

-- Extra bind: SUPER + Grave (`)
hl.bind("SUPER + grave", function()
    if hl.plugin and hl.plugin.overview and hl.plugin.overview.toggle then
        hl.plugin.overview.toggle()
    end
end, { description = "Toggle Hyprspace workspace overview" })

-- Shell Switcher popup (Hyprland | SekaiPop | macOS) — ← → Enter
hl.unbind("SUPER + ALT + slash")
hl.unbind("SUPER + ALT + Slash")
hl.bind("SUPER + ALT + Slash", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/open_switcher.sh"), { description = "Shell: Open shell switcher" })

-- Unified Sidebar / Quick Panel Toggle (Super + A) across end4-pC, sekaipop, macos
hl.unbind("SUPER + A")
hl.bind("SUPER + A", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_sidebar.sh"), { description = "Shell: Toggle sidebar / quick panel" })

-- File Manager: Finder (Nautilus)
hl.unbind("SUPER + E")
hl.unbind("SUPER + e")
hl.bind("SUPER + E", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/open_nautilus.sh"), { description = "App: Finder (Nautilus)" })
hl.bind("SUPER + e", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/open_nautilus.sh"), { description = "App: Finder (Nautilus)" })

-- Disable single-click Super completely
hl.unbind("SUPER_L")
hl.unbind("SUPER_R")
hl.unbind("SUPER + SUPER_L")
hl.unbind("SUPER + SUPER_R")
hl.unbind("SUPER + space")
hl.bind("SUPER + space", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_launcher.sh"), { description = "Toggle App Launcher / Launchpad" })

-- Search Bar on Alt + Space (Spotlight in macOS / SearchWidget in end4-pC)
hl.unbind("ALT + space")
hl.bind("ALT + space", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_searchbar.sh"), { description = "Toggle Search Bar" })

-- Lock Screen on Super + L
hl.unbind("SUPER + L")
hl.unbind("SUPER + l")
hl.bind("SUPER + L", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/lock_screen.sh"), { description = "Session: Lock Screen" })

-- Sleep / Suspend (Fn+F1, XF86Sleep, XF86Suspend, Super + Shift + L)
hl.unbind("XF86Sleep")
hl.bind("XF86Sleep", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/suspend_system.sh"), { locked = true, description = "Session: Sleep" })
hl.unbind("XF86Suspend")
hl.bind("XF86Suspend", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/suspend_system.sh"), { locked = true, description = "Session: Sleep" })
hl.unbind("SUPER + SHIFT + L")
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/suspend_system.sh"), { locked = true, description = "Session: Sleep" })

-- Smart Screenshot with OCR & QR Scanner (Super + Shift + S)
hl.unbind("SUPER + SHIFT + S")
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/smart_snip.sh"), { description = "Utilities: Smart Screen Snip (Screenshot, OCR, QR)" })

-- Direct OCR Text Grabber (Super + Shift + O)
hl.unbind("SUPER + SHIFT + O")
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/ocr_snip.sh"), { description = "Utilities: Screen OCR to Clipboard" })

-- Disable unused screen translate bind
hl.unbind("SUPER + SHIFT + T")

-- Unified Clipboard & Emoji across all shells (Super + V / Super + .)
hl.unbind("SUPER + V")
hl.bind("SUPER + V", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_clipboard.sh"), { description = "Utilities: Clipboard history >> clipboard" })
hl.unbind("SUPER + Period")
hl.bind("SUPER + Period", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_emoji.sh"), { description = "Utilities: Emoji >> clipboard" })

-- Dropdown Scratchpad Notepad (Super + U or F12)
hl.unbind("F12")
hl.bind("F12", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_dropdown.sh"), { description = "App: Toggle Dropdown Notepad" })
hl.unbind("SUPER + U")
hl.bind("SUPER + U", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_dropdown.sh"), { description = "App: Toggle Dropdown Notepad" })



-- Toggle Tide Island (Dynamic Island)
hl.unbind("SUPER + ALT + I")
hl.bind("SUPER + ALT + I", hl.dsp.exec_cmd("quickshell ipc --any-display -p ~/.local/share/tide-island call island toggle"), { description = "Toggle Tide Island Dynamic Island" })

-- Toggle Light / Dark Mode (Ctrl + Super + Shift + D)
hl.unbind("CTRL + SUPER + SHIFT + D")
hl.bind("CTRL + SUPER + SHIFT + D", hl.dsp.exec_cmd("~/.config/hypr/custom/scripts/toggle_dark_light.sh"), { description = "Appearance: Toggle Light / Dark Theme" })

-- Toggle MacShell WindowDecor (Super + Alt + N)
hl.unbind("SUPER + ALT + N")
hl.bind("SUPER + ALT + N", hl.dsp.exec_cmd("qs -c MacShell ipc call windecor toggle"), { description = "MacShell: Toggle WindowDecor" })

