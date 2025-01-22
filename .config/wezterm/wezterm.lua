-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.disable_default_key_bindings = true
config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Debian",

		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.
		distribution = "Debian",
		default_cwd = "~",
	},
}
config.enable_kitty_keyboard = true
config.default_domain = "WSL:Debian"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 16
config.enable_scroll_bar = false
config.window_padding = { right = 2 }
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
	-- {
	-- 	key = "c",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action({ CopyTo = "Clipboard" }),
	-- },
	-- {
	-- 	key = "v",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action({ PasteFrom = "Clipboard" }),
	-- },
	-- {
	-- 	key = "Copy",
	-- 	action = wezterm.action({ CopyTo = "Clipboard" }),
	-- },
	-- {
	-- 	key = "Paste",
	-- 	action = wezterm.action({ PasteFrom = "Clipboard" }),
	-- },
}

-- and finally, return the configuration to wezterm
return config
