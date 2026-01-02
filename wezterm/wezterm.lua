local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono' 
config.font_size = 12.0

config.colors = {
  foreground = '#ebdbb2',
  background = '#32302f',
  cursor_bg = '#ebdbb2',
  cursor_fg = '#32302f',
  
  ansi = {
    '#32302f', -- Black
    '#fb4934', -- Red
    '#b8bb26', -- Green
    '#fabd2f', -- Yellow
    '#83a598', -- Blue
    '#d3869b', -- Magenta
    '#8ec07c', -- Cyan
    '#ebdbb2', -- White
  },
  brights = {
    '#928374', -- Bright Black
    '#fb4934', -- Bright Red
    '#b8bb26', -- Bright Green
    '#fabd2f', -- Bright Yellow
    '#83a598', -- Bright Blue
    '#d3869b', -- Bright Magenta
    '#8ec07c', -- Bright Cyan
    '#fbf1c7', -- Bright White
  },
}

config.window_decorations = "RESIZE" 
config.enable_tab_bar = false     
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config