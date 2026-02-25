local builtin = require "statuscol.builtin"

local M = {
  segments = {
    { text = { builtin.foldfunc, " " } },
    { text = { builtin.lnumfunc } },
    { sign = { name = { "Dap.*" }, namespace = { "gitsigns", ".*diagnostic%.signs.*" }, maxwidth = 1, auto = " " } },
    { sign = { name = { ".*" }, text = { ".*" }, namespace = { ".*" }, maxwidth = 1, auto = true } },
  },
}

return M
