---@module "venv-selector"

local function conda_env_name(path)
  return path:match "/envs/([^/]+)/" or "base"
end

return {
  options = {
    picker = "snacks",
  },
  search = {
    conda = {
      command = "$FD 'bin/python$' /opt/miniconda3/envs --no-ignore-vcs --full-path --color never",
      type = "anaconda",
      on_telescope_result_callback = conda_env_name,
    },
    base = {
      command = "$FD '/python$' /opt/miniconda3/bin --no-ignore-vcs --full-path --color never",
      type = "anaconda",
      on_telescope_result_callback = conda_env_name,
    },
  },
}
