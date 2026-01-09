-- pull in the wezterm API
local wezterm = require("wezterm")

local functions = require("functions")

local config = {}
local constants = functions.require_host_or_default("constants")

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configuration line height
local height_base = 1
local height_fractal = 0.5
config.line_height = height_base + (height_fractal / 10)
-- Cell Width
config.cell_width = 1.05
-- Font settings
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"FiraMono Nerd Font",
})
-- Font Size
config.font_size = 18

-- Colourscheme
config.color_scheme_dirs = { wezterm.config_dir .. "/themes" }
config.color_scheme = "fallout4_enhanced"
config.colors = require("themes.fallout4_enhanced")

-- tab bar stuff
config.enable_tab_bar = false

-- Window sizing options
config.adjust_window_size_when_changing_font_size = false

-- keymaps
local keys_config = functions.require_host_or_default("keymaps")
config.keys = keys_config

config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin/:/usr/local/bin/:" .. os.getenv("PATH"),
}

config.window_padding = {
	left = 1,
	right = 2,
	top = 0,
	bottom = 0,
}

local wallpapers = "/Users/cryosis/.config/wezterm/wallpapers/"
-- Terminal background image
config.background = {
	{
		source = {
			File = wallpapers .. "waifu_wallpaper_001.png",
		},
		width = "Cover",
		height = "Cover",
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		horizontal_align = "Center",
		vertical_align = "Middle",
		hsb = {
			brightness = 0.005,
		},
	},
}

-- Mux setup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	-- We want to startup in the default workspace
	if constants.default_workspace then
		mux.set_active_workspace(constants.default_workspace)
	end
end)

return config
