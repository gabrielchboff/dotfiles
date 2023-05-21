-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Dracula'
config.font = wezterm.font 'Fira Code'
config.line_height = 1.0

config.font_size = 16.0
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.

config.window_background_opacity = 1.0

config.window_padding = {
  left = 3, right = 3,
  top = 3, bottom = 3,
}

config.enable_scroll_bar = true,


-- some events

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window. If they didn't specify it, use a default empty SpawnCommand.
  local cmd = cmd or {}
  -- I prefer to use the cwd of the gui process instead of (probably) the home dir
  if not cmd.cwd then
     cmd.cwd = wezterm.procinfo.current_working_dir_for_pid(wezterm.procinfo.pid())
  end
  mux.spawn_window(cmd)
end)

wezterm.on('window-focus-changed', function(window, pane)
  wezterm.log_info(
    'the focus state of ',
    window:window_id(),
    ' changed to ',
    window:is_focused()
  )
end)

-- and finally, return the configuration to wezterm
return config

