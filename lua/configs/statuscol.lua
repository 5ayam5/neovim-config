local builtin = require "statuscol.builtin"

local M = {
  segments = {
    { text = { builtin.foldfunc, " " } },
    { text = { builtin.lnumfunc, " " } },
    {
      sign = {
        name = { "Dap.*", "todo*" },
        namespace = { "gitsigns", ".*diagnostic%.signs.*" },
        maxwidth = 1,
        auto = " ",
      },
    },
  },
}

return M
