local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Window size at startup
config.initial_cols = 120
config.initial_rows = 28

-- Do not quit when all windows are closed
config.quit_when_all_windows_are_closed = false

-- Do not display confirmation prompt
config.window_close_confirmation = 'NeverPrompt'

-- Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.color_scheme = "Tomorrow"

config.font = wezterm.font 'MesloLGS NF'

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

config.window_frame = {
    font = wezterm.font { family = "SF Pro Text", weight = "Bold" },
    font_size = 12,
    active_titlebar_bg = '#FFFFFF',
    inactive_titlebar_bg = '#FFFFFF',
}

config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    -- background = '#0b0022',
    -- background = '#ffffff',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      -- bg_color = '#2b2042',
      bg_color = '#c0c0c0',
      -- The color of the text for the tab
      -- fg_color = '#c0c0c0',
      fg_color = '#2b2042',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      -- bg_color = '#1b1032',
      bg_color = '#EEEEEE',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      -- bg_color = '#1b1032',
      bg_color = '#EEEEEE',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

-- Keys
-- config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {

    -- This will create a new split and run your default program inside it
    { key = 'd', mods = 'CMD',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },

    -- This will create a new split and run your default program inside it
    { key = 'D', mods = 'CMD',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },

    -- Move between panes
    -- { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    -- { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    -- { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    -- { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = '[', mods = 'CMD', action = act.ActivatePaneDirection 'Prev' },
    { key = ']', mods = 'CMD', action = act.ActivatePaneDirection 'Next' },

    -- Scroll to prompt
    { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },

    -- Open settings
    { key = ',', mods = 'CMD', action = act.SpawnCommandInNewWindow {
        args = {
            wezterm.home_dir .. '/.local/bin/nvim',
            wezterm.config_file
        } },
    },
}


-- Dead keys for accented characters: left Option key performs composition
-- right Option does not. (As it is standard on the mac)
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

return config
