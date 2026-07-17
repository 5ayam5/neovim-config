vim.bo.commentstring = "# %s"

local map = vim.keymap.set
local incorporate_count = require("utils").incorporate_count

-- Notebook-Navigator
map(
  "n",
  "]]",
  incorporate_count(function()
    require("notebook-navigator").move_cell "d"
  end),
  { buffer = true, desc = "Jupyter move to next <count> cell" }
)
map(
  "n",
  "[[",
  incorporate_count(function()
    require("notebook-navigator").move_cell "u"
  end),
  { buffer = true, desc = "Jupyter move to previous <count> cell" }
)

map(
  "n",
  "<leader>jR",
  "<cmd>lua require('notebook-navigator').run_cell()<CR>",
  { buffer = true, desc = "Jupyter Run current cell", silent = true }
)
map(
  "n",
  "<leader>jr",
  incorporate_count(function()
    require("notebook-navigator").run_and_move()
  end),
  { buffer = true, desc = "Jupyter run next <count> cell(s) and move", silent = true }
)
map(
  "n",
  "<leader>ja",
  "<cmd>lua require('notebook-navigator').run_cells_below()<CR>",
  { buffer = true, desc = "Jupyter run (a)ll cells below", silent = true }
)
map(
  "n",
  "<leader>jA",
  "<cmd>lua require('notebook-navigator').run_all_cells()<CR>",
  { buffer = true, desc = "Jupyter run All cells", silent = true }
)

-- Molten
map(
  "n",
  "<leader>ji",
  "<cmd>MoltenImagePopup<CR>",
  { buffer = true, desc = "Jupyter show Image output in popup", silent = true }
)
map(
  "n",
  "<leader>jo",
  "<cmd>noautocmd MoltenEnterOutput<CR>",
  { buffer = true, desc = "Jupyter open/enter cell Output", silent = true }
)
map(
  "n",
  "<leader>jh",
  "<cmd>noautocmd MoltenHideOutput<CR>",
  { buffer = true, desc = "Jupyter Hide cell output", silent = true }
)
map("n", "<leader>js", "<cmd>MoltenRestart<CR>", { buffer = true, desc = "Jupyter reStart kernel", silent = true })
