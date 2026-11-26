-- Custom Window & Layer Rules

-- Dropdown Scratchpad Notepad (Persistent Kate)
hl.workspace_rule({ workspace = "special:dropdown", gaps_out = 20 })
hl.window_rule({
    match = { class = "^(org\\.kde\\.kate)$" },
    float = true,
    size = { "(monitor_w*0.75)", "(monitor_h*0.65)" },
    center = true,
    workspace = "special:dropdown silent",
})

-- Tearing (immediate) for games
hl.window_rule({
    match = { class = "^(steam_app_.*|gamescope|.*\\.exe)$" },
    immediate = true,
})

-- Liquid Glass effects via hyprliquid plugin (only for terminal and safe windows)
if hl.plugin and hl.plugin.hyprliquid then
    -- Kitty Terminal: Liquid Glass with RGB dispersion
    hl.window_rule({
        name = "kitty-liquid-glass",
        match = { class = "kitty" },
        ["hyprliquid:effect"] = "liquid_glass",
        ["hyprliquid:tint_color"] = "rgba(0x1a, 0x1b, 0x26, 0.45)",
        ["hyprliquid:highlight_style"] = 2,
        ["hyprliquid:glass_dispersion"] = true,
    })
end

-- MacShell (Liquid) blur & no_anim layer rules
hl.layer_rule({ name = "macdock",  match = { namespace = "macdock"  }, blur = true, ignore_alpha = 0.2,  no_anim = true })
hl.layer_rule({ name = "macspot",  match = { namespace = "macspot"  }, blur = true, ignore_alpha = 0.05, no_anim = true })
hl.layer_rule({ name = "macbarbg", match = { namespace = "macbarbg" }, blur = true, ignore_alpha = 0.05, no_anim = true })
hl.layer_rule({ name = "macshot",  match = { namespace = "macshot"  }, no_anim = true })
