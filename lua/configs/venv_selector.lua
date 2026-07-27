---@module "venv-selector"
return {
  options = {
    picker = "snacks",
  },
  search = {
    miniconda_envs = {
      command = "$FD 'bin/python$' /opt/miniconda3/envs --no-ignore-vcs --full-path --color never",
      type = "anaconda",
    },
    miniconda_base = {
      command = "$FD '/python$' /opt/miniconda3/bin --no-ignore-vcs --full-path --color never",
      type = "anaconda",
    },
  },
}
