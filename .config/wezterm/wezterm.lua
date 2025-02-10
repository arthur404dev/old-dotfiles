-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Detect the operating system
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local is_macos = wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin"
local is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu" or
    wezterm.target_triple == "aarch64-unknown-linux-gnu"

-- Create config
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Apply WSL settings only on Windows
if is_windows then
  config.wsl_domains = {
    {
      name = "WSL:Debian",
      distribution = "Debian",
      default_cwd = "~",
    },
  }
  config.default_domain = "WSL:Debian"
end

config.enable_kitty_keyboard = true
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 16
config.enable_scroll_bar = false
config.window_padding = { top = 30, right = 30, left = 50 }
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- Return config
return config
