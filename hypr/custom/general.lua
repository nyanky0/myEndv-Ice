-- Load plugins
pcall(function() hl.plugin.load(HOME .. "/.config/hypr/plugins/hyprbars.so") end)
pcall(function() hl.plugin.load(HOME .. "/.config/hypr/plugins/Hyprspace.so") end)
pcall(function() hl.plugin.load(HOME .. "/.config/hypr/plugins/hyprfocus.so") end)
pcall(function() hl.plugin.load(HOME .. "/.config/hypr/plugins/hyprliquid.so") end)
pcall(function() hl.plugin.load(HOME .. "/.config/hypr/plugins/hypr-dynamic-cursors.so") end)

-- Hyprbars, Hyprspace, Hyprfocus, Hyprliquid, Dynamic Cursors and general custom settings
hl.config({
    general = {
        allow_tearing = false,
    },
    misc = {
        vrr = 0, -- Disabled: eDP-1 does not support VRR
    },
    plugin = {
        hyprliquid = {
            enabled = false,
            watch_system_color_scheme = true,
            background_sharing = true,
        },
        overview = {
            panelColor = "rgba(24, 24, 37, 0.85)",
            panelBorderColor = "rgba(0, 0, 0, 0)",
            workspaceActiveBackground = "rgba(255, 255, 255, 0.12)",
            workspaceActiveBorder = "rgb(180, 190, 254)",
            workspaceInactiveBackground = "rgba(0, 0, 0, 0.2)",
            workspaceInactiveBorder = "rgba(255, 255, 255, 0.1)",
            onBottom = false,
            autoDrag = true,
            autoScroll = true,
            exitOnClick = true,
            exitOnSwitch = true,
            drawActiveWorkspace = true,
            showNewWorkspace = true,
            showEmptyWorkspace = true,
        },
        hyprfocus = {
            enable = true,
            animate_floating = true,
            only_on_monitor_change = false,
            keyboard_focus_animation = "flash",
            mouse_focus_animation = "flash",
            group_focus_animation = "flash",
            fade_opacity = 0.85,
            shrink_percentage = 0.95,
        },
    },
    gestures = {
        workspace_swipe_invert = true,
        workspace_swipe_distance = 300,
    },
    input = {
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Hyprbars config & macOS style traffic light buttons (only when plugin is loaded)
if hl.plugin and hl.plugin.hyprbars then
    hl.config({
        plugin = {
            hyprbars = {
                -- Bar dimensions and positioning (macOS style proportions)
                bar_height = 30,
                bar_buttons_alignment = "left",
                bar_text_align = "center",
                bar_text_size = 12,
                bar_text_font = "SF Pro Display",
                bar_padding = 14,
                bar_button_padding = 8,
                bar_precedence_over_border = true,
                bar_part_of_window = true,
                icon_on_hover = false,
                on_double_click = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
            },
        },
    })
end

if hl.plugin and hl.plugin.hyprbars and hl.plugin.hyprbars.add_button then
    -- Red: Close window
    hl.plugin.hyprbars.add_button({
        bg_color = "rgb(ff5f56)",
        fg_color = "rgb(4c0000)",
        size = 13,
        icon = "✕",
        action = "hyprctl dispatch 'hl.dsp.window.close()'",
    })

    -- Yellow: Toggle float/tile
    hl.plugin.hyprbars.add_button({
        bg_color = "rgb(ffbd2e)",
        fg_color = "rgb(5c4400)",
        size = 13,
        icon = "−",
        action = [[hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })']],
    })

    -- Green: Fullscreen / Maximize
    hl.plugin.hyprbars.add_button({
        bg_color = "rgb(27c93f)",
        fg_color = "rgb(004d12)",
        size = 13,
        icon = "＋",
        action = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
    })
end

-- Hyprfocus animations
hl.animation({
    leaf = "hyprfocusIn",
    enabled = true,
    speed = 1.7,
    bezier = "emphasizedDecel",
})
hl.animation({
    leaf = "hyprfocusOut",
    enabled = true,
    speed = 1.7,
    bezier = "emphasizedDecel",
})
