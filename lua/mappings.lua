local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- navigation related
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<ESC>", function()
  vim.cmd "normal! \\<ESC\\>"
  vim.cmd ":noh"
end, { desc = "Search clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

local mux_with_g = function(key)
  local gkey = "g" .. key
  return function()
    if vim.v.count == 0 then
      return gkey
    else
      return key
    end
  end
end
map({ "n", "v" }, "j", mux_with_g "j", { expr = true })
map({ "n", "v" }, "k", mux_with_g "k", { expr = true })

map("i", "jk", "<ESC>")
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Tab related
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tt", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tT", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
for i = 1, 9 do
  map("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i })
end

-- File related
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map({ "n", "i", "v" }, "<C-x>", "<cmd> noa w <CR>", { desc = "Save without autocmds" })
map({ "n", "x" }, "<C-f>", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })
map("n", "<leader>n", ":e ", { desc = "Open new (or existing) file" })

-- buffer related
local count_windows_and_hide_floating = function()
  local wins = vim.api.nvim_tabpage_list_wins(0)

  local count = 0
  for _, w in ipairs(wins) do
    local config = vim.api.nvim_win_get_config(w)
    if config.relative > "" or config.external then
      vim.api.nvim_win_hide(w)
    else
      count = count + 1
    end
  end

  return count
end

local close_window = function()
  if
    (
      count_windows_and_hide_floating() == 1
      or (
        count_windows_and_hide_floating() == 2
        and vim.bo.filetype ~= "NvimTree"
        and require("nvim-tree.api").tree.is_visible()
      )
    ) and vim.bo.filetype ~= "nvdash"
  then
    vim.cmd "Nvdash"
  else
    vim.cmd ":q"
  end
end

map("n", "<leader>x", close_window, { desc = "Window close" })
map("n", "<leader>q", function()
  require("nvim-tree.api").tree.close()
  while vim.bo.filetype ~= "nvdash" do
    close_window()
  end
end, { desc = "Nvdash open" })

-- comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-CR>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- terminal
map("t", "<C-j><C-k>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Terminal toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Terminal toggleable horizontal term" })
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal toggle floating term" })

-- utility
map("n", "<leader>cc", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvcheatsheet" })
map("n", "<leader>ch", ":checkhealth ", { desc = "Checkhealth" })
map("n", "<leader>cn", "<cmd>lua Snacks.notifier.show_history()<CR>", { desc = "Show notification history" })

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- C++ debugging with dap
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP toggle breakpoint at line" })
map("n", "<leader>dr", function()
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
  end
  require("dap").continue()
end, { desc = "DAP start or continue the debugger" })

-- notebook-navigator keybindings
map("n", "<leader>jd", function()
  require("notebook-navigator").move_cell "d"
end, { desc = "Notebook-Navigator move cell down" })
map("n", "<leader>ju", function()
  require("notebook-navigator").move_cell "u"
end, { desc = "Notebook-Navigator move cell up" })
map(
  "n",
  "<leader>jR",
  "<cmd>lua require('notebook-navigator').run_cell()<CR>zz",
  { desc = "Notebook-Navigator run jupyter cell" }
)
map(
  "n",
  "<leader>jr",
  "<cmd>lua require('notebook-navigator').run_and_move()<CR>zz",
  { desc = "Notebook-Navigator run and move jupyter cell" }
)

-- Molten keybindings
map("n", "<leader>jm", "<cmd>MoltenInit<CR>", { desc = "Molten initialize", silent = true })
map("n", "<leader>je", "<cmd>MoltenEvaluateOperator<CR>", { desc = "Molten evaluate operator", silent = true })
map("n", "<leader>js", "<cmd>noautocmd MoltenEnterOutput<CR>", { desc = "Molten open output window", silent = true })
map(
  "v",
  "<leader>jx",
  "<cmd><C-u>MoltenEvaluateVisual<CR>gv",
  { desc = "Molten execute visual selection", silent = true }
)
map("n", "<leader>jh", "<cmd>MoltenHideOutput<CR>", { desc = "Molten close output window", silent = true })
map("n", "<leader>ji", "<cmd>MoltenImagePopup<CR>", { desc = "Molten popup output image", silent = true })

-- git related
autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "git toggle blame", silent = true })
    map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "git diff this", silent = true })
    map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "git stage hunk", silent = true })
    map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "git reset hunk", silent = true })
  end,
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("n", "<leader>m", ":Markview toggle<CR>", { desc = "Toggle Markdown rendering", silent = true, buffer = true })
  end,
})
