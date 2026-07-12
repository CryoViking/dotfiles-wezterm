local wezterm = require("wezterm")
local functions = require("functions")
local constants = functions.require_host_or_default("constants")

local M = {}

local workspace_configs = {
	[constants.default_workspace] = {
		workspace = constants.default_workspace,
		cwd = wezterm.home_dir,
		args = nil,
	},
}

local function check_workspace_exists(workspace_to_check)
	local workspaces = wezterm.mux.get_workspace_names()
	for _, workspace in ipairs(workspaces) do
		if workspace == workspace_to_check then
			return true
		end
	end
	return false
end

function M.switch_workspace(config_key, cmd_args)
	local args = {}
	if cmd_args then
		args = cmd_args
	end

	local mux = wezterm.mux
	local config = workspace_configs[config_key]

	if not config then
		wezterm.log_warn(
			"No workspace configuration found for key: " .. config_key .. "Creating new workspace with name"
		)
		local tab, pane, window = mux.spawn_window({
			workspace = config_key,
			args = args,
		})

		-- Switch to the new workspace
		mux.set_active_workspace(config_key)
		return true -- Need to exit out of the function early
	end

	local spawn_args = config.args or args

	-- Check if the workspace exists
	local workspace_exists = check_workspace_exists(config.workspace)

	if workspace_exists then
		-- Switch to the workspace
		mux.set_active_workspace(config.workspace)
	else
		-- Create the new workspace
		local tab, pane, window = mux.spawn_window({
			workspace = config.workspace,
			cwd = config.cwd,
			args = spawn_args,
		})

		-- Switch to the new workspace
		mux.set_active_workspace(config.workspace)
	end
end

return M
