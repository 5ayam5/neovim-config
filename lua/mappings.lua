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
map({ "n", "i", "v" }, "<C-x>", "<cmd>noa w<CR>", { desc = "Save without autocmds" })
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
  local num_windows = count_windows_and_hide_floating()
  if vim.bo.filetype ~= "nvdash" then
    if
      num_windows == 1
      or (num_windows == 2 and vim.bo.filetype ~= "NvimTree" and require("nvim-tree.api").tree.is_visible())
    then
      vim.cmd "Nvdash"
    else
      vim.cmd ":q"
    end
  end
end

map("n", "<leader>x", close_window, { desc = "Window close" })
map("n", "<leader>q", function()
  require("nvim-tree.api").tree.close()
  while vim.bo.filetype ~= "nvdash" do
    close_window()
  end
end, { desc = "Nvdash open" })

-- nvimtree
map("n", "<C-CR>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree toggle window" })

-- terminal
map("t", "<C-j><C-k>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- utility
map("n", "<leader>cc", "<cmd>NvCheatsheet<CR>", { desc = "Toggle nvCheatsheet" })
map("n", "<leader>ce", ":checkhealth ", { desc = "CheckhEalth" })
map("n", "<leader>cn", "<cmd>lua Snacks.notifier.show_history()<CR>", { desc = "Show Notification history" })

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- PLUGINS
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- C++ debugging with dap
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP toggle breakpoint at line" })
map("n", "<leader>dr", function()
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
  end
  require("dap").continue()
end, { desc = "DAP start or continue the debugger" })

-- jupyter
local toggle_molten = function()
  if vim.b.molten_initialized == true then
    vim.cmd ":OtterDeactivate"
    vim.cmd ":MoltenDeinit"
    vim.b.molten_initialized = false
  else
    vim.cmd ":MoltenInit"
    vim.cmd ":OtterActivate"
    vim.b.molten_initialized = true
  end
end

autocmd("FileType", {
  pattern = { "quarto" },
  callback = function()
    vim.b.molten_initialized = false

    -- navigating cells
    map("n", "<C-n>", function()
      pcall(function()
        vim.fn.search("^```\\(python\\|{python}\\)$", "W")
        vim.cmd ":noh"
      end)
    end)
    map("n", "<C-p>", function()
      pcall(function()
        vim.fn.search("^```\\(python\\|{python}\\)$", "Wb")
        vim.cmd ":noh"
      end)
    end)

    -- quarto keybindings
    map("n", "<leader>jr", function()
      require("quarto.runner").run_cell()
    end, { desc = "Notebook-Navigator run jupyter cell" })

    -- Molten keybindings
    map("n", "<leader>jo", "<cmd>MoltenToggleVirtual<CR>", { desc = "Molten toggle output window", silent = true })
    map("n", "<leader>jj", toggle_molten, { desc = "Molten toggle init", silent = true })
  end,
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "quarto" },
  callback = function()
    map(
      "n",
      "<leader>m",
      "<cmd>Markview toggle<CR>",
      { desc = "Toggle Markdown rendering", silent = true, buffer = true }
    )
  end,
})

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy open plugin manager" })
