local wezterm = require("wezterm")
local functions = require("functions")
local constants = functions.require_host_or_default("constants")
local workspaces = functions.require_host_or_default("workspaces")

function table_contains(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

local disable = "DisableDefaultAssignment"

local SEP = "|"

local ALT = "ALT"
local CTRL = "CTRL"
local SHIFT = "SHIFT"
local SUPER = "CMD"

local LEADER = SUPER .. SEP .. SHIFT
local CTRL_SHIFT = CTRL .. SEP .. SHIFT
local SHIFT_CTRL = SHIFT .. SEP .. CTRL
local SHIFT_ALT_CTRL = SHIFT .. SEP .. ALT .. SEP .. CTRL

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

-- Configure key bindings
local keys = {
	{ key = "n", mods = CTRL_SHIFT, action = wezterm.action.AdjustPaneSize({ "Left", 2 }) },
	{ key = "m", mods = CTRL_SHIFT, action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
	{ key = ",", mods = CTRL_SHIFT, action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
	{ key = ".", mods = CTRL_SHIFT, action = wezterm.action.AdjustPaneSize({ "Right", 2 }) },

	{
		key = "9",
		mods = LEADER,
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},

	-- Direction switch between panes
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Switch to the default workspace
	{
		key = "n",
		mods = LEADER,
		action = wezterm.action_callback(function()
			workspaces.switch_workspace(constants.default_workspace, nil)
		end),
	},
	-- Switch to muli workspace
	{
		key = "w",
		mods = LEADER,
		action = wezterm.action_callback(function()
			workspaces.switch_workspace(constants.muli_workspace, nil)
		end),
	},
	-- Switch to obsidian workspace
	{
		key = "o",
		mods = LEADER,
		action = wezterm.action_callback(function()
			workspaces.switch_workspace(constants.obsidian_workspace, nil)
		end),
	},
	-- Switch to a monitoring workspace, which will have `top` launched into it
	{
		key = "i",
		mods = LEADER,
		action = wezterm.action_callback(function()
			workspaces.switch_workspace(constants.monitoring_workspace, nil)
		end),
	},
	-- Disable keymaps
	{
		key = "-",
		mods = CTRL,
		action = disable,
	},
	{
		key = "+",
		mods = CTRL,
		action = disable,
	},
	-- New keymaps
	{
		key = "o",
		mods = CTRL_SHIFT,
		action = wezterm.action.PaneSelect({ alphabet = "jurftyghieowpq", mode = "SwapWithActive" }),
	},
	{
		key = "i",
		mods = CTRL,
		action = wezterm.action.PaneSelect({ alphabet = "jurftyghieowpq" }),
	},
	{
		key = "r",
		mods = SUPER,
		action = wezterm.action.ReloadConfiguration,
	},
	{
		key = "c",
		mods = SUPER,
		action = wezterm.action.Multiple({
			{ CopyTo = "ClipboardAndPrimarySelection" },
			{ CopyMode = "ScrollToBottom" },
			{ CopyMode = "Close" },
		}),
	},
	{
		key = "v",
		mods = SUPER,
		action = wezterm.action.Multiple({
			{ PasteFrom = "PrimarySelection" },
			{ PasteFrom = "Clipboard" },
		}),
	},
	{
		key = "v",
		mods = CTRL_SHIFT,
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = {
				Percent = 50,
			},
		}),
	},
	{
		key = "s",
		mods = CTRL_SHIFT,
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = {
				Percent = 50,
			},
		}),
	},
}

return keys
