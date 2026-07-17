local map = vim.keymap.set
local incorporate_count = require("utils").incorporate_count

-- navigation related
map("n", ";", ":")
map({ "n", "v" }, "\\", "-")

map("n", "<ESC>", function()
  vim.cmd "normal! \\<ESC\\>"
  vim.cmd ":noh"
end, { desc = "Search clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })
map("n", "<C-p>", "<C-w>p", { desc = "Switch to previous window" })

map("i", "jk", "<ESC>")
map("i", "<C-b>", "<ESC>^i", { desc = "Move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Tab related
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tt", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tT", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
for i = 1, 9 do
  map("n", "<leader>t" .. i, i .. "gt", { desc = "Go to tab " .. i })
end

-- File related
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map({ "n", "i", "v" }, "<C-x>", function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  if vim.b.disable_autoformat then
    vim.notify("Autoformat on save disabled", vim.log.levels.INFO, { title = "Conform" })
  else
    vim.notify("Autoformat on save enabled", vim.log.levels.INFO, { title = "Conform" })
  end
end, { desc = "Toggle autoformat" })
map({ "n", "x" }, "<C-a>", function()
  require("conform").format()
end, { desc = "Format file" })
map("n", "<leader>n", ":e ", { desc = "Open new (or existing) file" })

-- buffer related
map("n", "<leader>q", function()
  Snacks.bufdelete()
  vim.cmd "\\<C-w>\\>c"
end, { desc = "Delete buffer and close window" })

map("n", "<leader><Tab>", incorporate_count(require("myplugins.tabline").next), { desc = "Go to next <count> buffer" })
map(
  "n",
  "<leader><S-Tab>",
  incorporate_count(require("myplugins.tabline").prev),
  { desc = "Go to previous <count> buffer" }
)
map("n", "<leader>bl", function()
  require("myplugins.tabline").move_buf(vim.v.count1)
end, { desc = "Move current buffer by <count> to the right in bufferline" })
map("n", "<leader>bh", function()
  require("myplugins.tabline").move_buf(-vim.v.count1)
end, { desc = "Move current buffer by <count> to the left in bufferline" })
map("n", "<leader>bb", function()
  if vim.v.count then
    require("myplugins.tabline").goto_buf(vim.v.count)
  end
end, { desc = "Go to buffer in bufferline" })

-- terminal
map("t", "<C-j><C-k>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- utility
map("n", "<leader>ce", ":checkhealth ", { desc = "CheckhEalth" })
map("n", "<leader>cn", "<cmd>lua Snacks.notifier.show_history()<CR>", { desc = "Show Notification history" })

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- nvimtree
map("n", "<C-CR>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- DAP  FIXME: restrict these mappings to only when dap UI is active
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP toggle breakpoint at line" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "DAP start or continue execution" })
map("n", "<leader>ds", "<cmd>DapStepInto<CR>", { desc = "DAP step into" })
map("n", "<leader>dn", "<cmd>DapStepOver<CR>", { desc = "DAP step over" })
map("n", "<leader>do", "<cmd>DapStepOut<CR>", { desc = "DAP step out" })
map("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", { desc = "DAP toggle UI" })
map("n", "<leader>dx", "<cmd>DapTerminate<CR>", { desc = "DAP terminate" })
map({ "n", "v" }, "<leader>de", "<cmd>lua require('dapui').eval()<CR>", { desc = "DAP evaluate" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy open plugin manager" })

-- UFO
map("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
