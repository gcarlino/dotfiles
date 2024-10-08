local wezterm = require 'wezterm'
local act = wezterm.action

--
-- CONFIGURATION
--

local config = wezterm.config_builder()

-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

-- Disable automatic check for updated
config.check_for_updates = false

-- Window size at startup
config.initial_cols = 120
config.initial_rows = 32

config.quit_when_all_windows_are_closed = false
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'
config.native_macos_fullscreen_mode = true
config.scrollback_lines = 5000
config.enable_scroll_bar = true
config.font_size = 12
config.font = wezterm.font {
    family = 'MesloLGS NF',
    weight = 'Regular'
}
config.window_padding = {
    left = 10,
    right = 25,
    top = 5,
    bottom = 0,
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- -- Muxing by default
-- config.unix_domains = {
--   {
--     name = 'unix',
--   },
-- }
-- config.default_gui_startup_args = { 'connect', 'unix' }


config.launch_menu = {
    {
        label = 'nvim',
        args = { '/Users/beps/.local/bin/nvim' },
    },
    {
        label = 'zsh',
        args = { '/bin/zsh' },
    },
    {
        label = 'bash',
        args = { '/bin/bash', '-l' },
    },
}


-- Colorscheme depending on appearance
-- ---@param arg { light: any, dark: any }
-- ---@return any
-- local function depending_on_appearance(arg)
--     local appearance = wezterm.gui.get_appearance()
--     if appearance:find 'Dark' then
--         return arg.dark
--     else
--         return arg.light
--     end
-- end
-- config.color_scheme = depending_on_appearance {
--     -- light = 'Tokyo Night Day',
--     light = 'Tokyo Night Storm',
--     dark = 'Tokyo Night Storm',
-- }

local dark_theme = 'Tokyo Night Storm'
local light_theme = 'Tokyo Night Day'

-- Default color_scheme
config.color_scheme = dark_theme

-- Override color_scheme
wezterm.on('toggle_color_scheme', function (window)
    local overrides = window:get_config_overrides() or {}

    if not overrides.color_scheme then
        overrides.color_scheme = dark_theme
    else
        overrides.color_scheme = overrides.color_scheme == light_theme and dark_theme or light_theme
    end
    window:set_config_overrides(overrides)
end)

-- Tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32
config.window_frame = {
    font = wezterm.font { family = "SF Pro Text", weight = "Medium" },
    font_size = 14,
    active_titlebar_bg = '#F0F0F0',
    inactive_titlebar_bg = '#F0F0F0',

}
config.colors = {
  tab_bar = {
    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = '#24283b',
      -- bg_color = '#454545',
      fg_color = '#ffffff',
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#EEEEEE',
      fg_color = '#808080',
    },

    -- Alternate styling when the mouse pointer moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#DDDDDD',
      fg_color = '#808080',
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#f0F0F0',
      fg_color = '#808080',
    },

    -- Alternate styling when the mouse pointer moves over the new tab button
    new_tab_hover = {
      bg_color = '#DDDDDD',
      fg_color = '#808080',
    },
  },
}

-- Keys
-- config.disable_default_key_bindings = true
config.keys = {
    -- Toggle dark and light color_scheme
    {
        key = 'C',
        mods = 'CTRL',
        action = act.EmitEvent 'toggle_color_scheme',
    },

    -- This will create a new split and run your default program inside it
    {
        key = 'd', mods = 'CMD',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    -- This will create a new split and run your default program inside it
    {
        key = 'D', mods = 'CMD',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Move between panes
    -- { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    -- { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    -- { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
    {
        key = '[', mods = 'CMD',
        action = act.ActivatePaneDirection 'Prev'
    },
    {
        key = ']', mods = 'CMD',
        action = act.ActivatePaneDirection 'Next'
    },

    -- Scroll to prompt (needs shell integration for wezterm)
    {
        key = 'UpArrow', mods = 'SHIFT',
        action = act.ScrollToPrompt(-1)
    },
    {
        key = 'DownArrow', mods = 'SHIFT',
        action = act.ScrollToPrompt(1)
    },

    -- Open settings
    {
        key = ',', mods = 'CMD',
        action = act.SpawnCommandInNewWindow {
            args = {
                wezterm.home_dir .. '/.local/bin/nvim',
                wezterm.config_file
            }
        },
    },

    -- Show pane selector
    {
        key = 'm', mods = 'CMD',
        action = act.PaneSelect,
    },
    -- Show tab navigator
    {
        key = 'p', mods = 'CMD',
        action = act.ShowTabNavigator,
    },
    -- Show launcher navigator
    {
        key = 'P', mods = 'CMD',
        action = act.ShowLauncher,
    },
}


-- Dead keys for accented characters:
-- left Option key performs composition
-- right Option does not. (As it is standard on the mac)
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

return config
