local wezterm = require("wezterm")

M = {}

M.hostname_map = {
  ["CryoForge.local"] = "cryo-forge",
  ["CryoBeast"] = "cryo-beast",
}

function M.require_host_or_default(module_name)
  local hostname = wezterm.hostname()
  local host_dir = M.hostname_map[hostname]

  if host_dir then
    local host_module_path = host_dir .. "." .. module_name
    local success, result = pcall(require, host_module_path)
    if success then
      return result
    end
  end

  return require(module_name)
end

return M
