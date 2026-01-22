local wezterm = require 'wezterm'
local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_domain = 'WSL:Ubuntu'
end

config.color_scheme = "SleepyHollow"
config.font = wezterm.font "Dank Mono"
config.font_size = 22.0
config.audible_bell = "Disabled"
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.disable_default_key_bindings = true
config.adjust_window_size_when_changing_font_size = false

local act = wezterm.action
config.keys = {
    { key = 'v', mods = 'SHIFT | CTRL', action = act.PasteFrom 'Clipboard'},
    { key = 'c', mods = 'SHIFT | CTRL', action = act.CopyTo 'Clipboard'},
    { key = 'f', mods = 'ALT', action = act.ToggleFullScreen},
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1)},
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1)},
    { key = '-', mods = 'ALT', action = act.DecreaseFontSize},
    { key = '=', mods = 'ALT', action = act.IncreaseFontSize},
    { key = 'q', mods = 'ALT', action = act.CloseCurrentTab{confirm = false}},
}

return config
