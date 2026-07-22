---@module "indent_blankline"
local M = {}

---@type ibl.config
M.opts = {
  indent = { char = "│", highlight = "IblChar" },
  scope = { char = "│", highlight = "IblScopeChar" },
}

M.config = function(_, opts)
  dofile(vim.g.base46_cache .. "blankline")

  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
  require("ibl").setup(opts)

  -- setup() regenerates the internal @ibl.scope.underline.N groups, clobbering
  -- base46's, so the cache must be applied again (upstream won't preserve them:
  -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/754)
  dofile(vim.g.base46_cache .. "blankline")
end

return M
