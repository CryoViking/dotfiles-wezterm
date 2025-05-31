-- pull in the wezterm API
local wezterm = require("wezterm")

local config = {}
local constants = require("constants")

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- FONT OPTIONS
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
-- config.color_scheme = "Kasugano (terminal.sexy)"
-- config.color_scheme = "Rosé Pine Moon (base16)"
config.color_scheme = "Kanagawa Dragon (Gogh)"
-- config.color_scheme = "Nord (Gogh)"
-- config.colors = {
-- 	-- The default text color
-- 	foreground = "#E4C7FC",
-- 	-- The default background color
-- 	background = "#09090D",
--
-- 	-- Overrides the cell background color when the current cell is occupied by the
-- 	-- cursor and the cursor style is set to Block
-- 	cursor_bg = "#52ad70",
-- 	-- Overrides the text color when the current cell is occupied by the cursor
-- 	cursor_fg = "black",
-- 	-- Specifies the border color of the cursor when the cursor style is set to Block,
-- 	-- or the color of the vertical or horizontal bar when the cursor style is set to
-- 	-- Bar or Underline.
-- 	cursor_border = "#52ad70",
--
-- 	-- the foreground color of selected text
-- 	selection_fg = "black",
-- 	-- the background color of selected text
-- 	selection_bg = "#fffacd",
--
-- 	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
-- 	scrollbar_thumb = "#222222",
--
-- 	-- The color of the split lines between panes
-- 	split = "#444444",
--
-- 	-- Colours here are based on: https://github.com/Shadorain/shadotheme/tree/master
-- 	ansi = {
-- 		"#140A1D",
-- 		"#B52A5B",
-- 		"#FF4971",
-- 		"#8897FA",
-- 		"#BD93F9",
-- 		"#E9729D",
-- 		"#F18FB0",
-- 		"#F1C4E0",
-- 	},
-- 	brights = {
-- 		"#A8899C",
-- 		"#B52A5B",
-- 		"#FF4971",
-- 		"#8897F4",
-- 		"#BD93F9",
-- 		"#E9729D",
-- 		"#F18FB0",
-- 		"#F1C4E0",
-- 	},
--
-- 	-- Arbitrary colors of the palette in the range from 16 to 255
-- 	indexed = { [136] = "#af8700" },
-- }

-- tab bar stuff
config.enable_tab_bar = false

-- Window sizing options
config.adjust_window_size_when_changing_font_size = false

-- keymaps
local keys_config = require("keymaps")
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
			File = wallpapers .. "ice_flake_wallpaper.jpg",
		},
		width = "Cover",
		height = "Cover",
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		horizontal_align = "Center",
		vertical_align = "Middle",
		hsb = {
			brightness = 0.011,
		},
	},
}

-- Mux setup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	-- We want to startup in the default workspace
	mux.set_active_workspace(constants.default_workspace)
end)

return config
