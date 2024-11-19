local ls = require('luasnip')
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
  s("sol",
    fmt([[
      \begin{{solution}}[label={1}]
        \begin{{question}}
          {2}
        \end{{question}}
        \tcblower{{}}
        \begin{{proof}}[{3}]
          {4}
        \end{{proof}}
      \end{{solution}}
    ]], {
        i(1, "label"),
        i(2, "Question"),
        i(3, "Proof"),
        i(4, "Proof")
      })
  )
})
