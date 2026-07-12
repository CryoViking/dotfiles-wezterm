local M = {}

function M.toggle_ai_pair(window, pane)
	local user_vars = pane:get_user_vars()
	local project_name = user_vars.AI_PAIR
	local active = user_vars.AI_ACTIVE

	local next_active = (active == "agy") and "codex" or "agy"

	if user_vars.AI_SLOT ~= "1" or not project_name or not active then
		window:toast_notification("AI Pair", "The active pane is not an AI pair", nil, 3000)
		return
	end

	local state_file = "/tmp/ai_pair_active_" .. project_name
	local f = io.open(state_file, "w")
	if f then
		f:write(next_active)
		f:close()
	end

	pane:send_text("\x1c")
end

return M
