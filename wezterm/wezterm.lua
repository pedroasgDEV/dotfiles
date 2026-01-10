local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono' 
config.font_size = 12.0
config.term = "xterm-256color"
config.tab_bar_at_bottom = true     
config.use_fancy_tab_bar = false  
config.hide_tab_bar_if_only_one_tab = true

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
  tab_bar = {
    background = '#32302f',

    active_tab = {
      bg_color = '#ebdbb2',
      fg_color = '#32302f',
      intensity = 'Bold',
    },

    inactive_tab = {
      bg_color = '#3c3836',
      fg_color = '#a89984', 
    },

    inactive_tab_hover = {
      bg_color = '#504945',
      fg_color = '#ebdbb2',
    },

    new_tab = {
      bg_color = '#32302f',
      fg_color = '#ebdbb2',
    },
    
    new_tab_hover = {
      bg_color = '#fabd2f',
      fg_color = '#32302f',
    },
  },
}

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
