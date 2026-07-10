local wezterm = require("wezterm")

local ok, loaded = pcall(require, "local")
local local_config = ok and loaded or {}

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = true,
	window_close_confirmation = "NeverPrompt",
  use_fancy_tab_bar = true,
  show_tab_index_in_tab_bar = true,
  show_new_tab_button_in_tab_bar = true,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },
  integrated_title_button_style = 'MacOsNative',
  integrated_title_button_alignment = 'Left',
  window_frame = {
    font_size = 14.5,
    active_titlebar_bg = '#16161e',
    inactive_titlebar_bg = '#16161e',
    active_titlebar_fg = '#c0caf5',
    inactive_titlebar_fg = '#565f89',
    active_titlebar_border_bottom = '#1a1b26',
    inactive_titlebar_border_bottom = '#1a1b26',
    button_fg = '#565f89',
    button_bg = '#16161e',
    button_hover_fg = '#c0caf5',
    button_hover_bg = '#292e42',
  },
	-- window_decorations = "RESIZE",
  font_size = 14.5,
  -- line_height = 1.2,
  color_scheme = "tokyonight_night",
  colors = {
    cursor_bg = "#7aa2f7",
    cursor_border = "#7aa2f7",

    tab_bar = {
      background = "#16161e",

      active_tab = {
        bg_color = "#1a1b26",
        fg_color = "#7aa2f7",
      },

      inactive_tab = {
        bg_color = "#16161e",
        fg_color = "#565f89",
      },

      inactive_tab_hover = {
        bg_color = "#292e42",
        fg_color = "#7aa2f7",
      },

      new_tab = {
        bg_color = "#16161e",
        fg_color = "#565f89",
      },

      new_tab_hover = {
        bg_color = "#292e42",
        fg_color = "#7dcfff",
      },
    },
  },
  ssh_domains = {
    {
      name = 'proxmox',
      remote_address = local_config.proxmox_host,
      username = local_config.proxmox_user,
      multiplexing = 'WezTerm',
      ssh_option = {
        identityfile = local_config.proxmox_identity,
        identitiesonly = 'yes',
      },
    },
  },
  keys = {
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
      key = 'd',
      mods = 'CMD|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
      key = 'w',
      mods = 'CMD',
      action = wezterm.action.CloseCurrentPane { confirm = false }
    },
    {
      key = 'LeftArrow',
      mods = 'CMD',
      action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
      key = 'RightArrow',
      mods = 'CMD',
      action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
      key = 'UpArrow',
      mods = 'CMD',
      action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
      key = 'DownArrow',
      mods = 'CMD',
      action = wezterm.action.ActivatePaneDirection 'Down'
    },
    {
      key = 'k',
      mods = 'CMD',
      action = wezterm.action.SendString 'clear\n'
    }
  }
}

return config
