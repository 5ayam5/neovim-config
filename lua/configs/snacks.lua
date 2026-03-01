---@module 'snacks'

local M = {}

---@type snacks.config
M.opts = {}

M.opts.terminal = {
  win = {
    position = "float",
  },
}

M.opts.words = {
  enabled = true,
}

M.opts.picker = {
  enabled = true,
}

M.keys = {
  -- Snacks picker
  {
    "<leader>fw",
    function()
      Snacks.picker.grep()
    end,
    desc = "Find word",
  },

  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find file",
  },

  {
    "<leader>fa",
    function()
      Snacks.picker.files {
        hidden = true,
        ignored = true,
      }
    end,
    desc = "Find all file",
  },

  {
    "<leader>fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Find buffer",
  },

  {
    "<leader>ch",
    function()
      Snacks.picker.help()
    end,
    desc = "Find help",
  },

  {
    "<leader>fh",
    function()
      Snacks.picker.highlights()
    end,
    desc = "Find highlights",
  },

  {
    "<leader>fc",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Find in open buffer",
  },

  {
    "<leader>fm",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Find keymaps",
  },

  -- LazyGit
  {
    "<leader>gg",
    function()
      Snacks.lazygit.open()
    end,
    desc = "git open lazygit",
  },

  -- todo_comments
  {
    "<leader>ft",
    function()
      require("todo-comments").setup {}
      Snacks.picker.todo_comments {} ---@diagnostic disable-line: undefined-field
    end,
    desc = "Find TODO comments",
  },

  -- buffer delete
  {
    "<leader>w",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete buffer",
  },

  -- jump symbols
  {
    "<C-f>",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Jump symbol forward under cursor",
  },
  {
    "<C-b>",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Jump symbol backward under cursor",
  },
}

-- Terminal toggles
for i = 0, 9 do
  table.insert(M.keys, {
    "<M-" .. i .. ">",
    function()
      Snacks.terminal.toggle(nil, {
        count = i,
      })
    end,
    desc = "Toggle terminal " .. i,
    mode = { "n", "t" },
  })
end

M.opts.notifier = {
  enabled = true,
  level = vim.log.levels.DEBUG,
}

M.opts.image = {
  enabled = true,
  doc = {
    max_height = 10,
    inline = false,
  },
  convert = {
    notify = true,
  },
  math = {
    latex = {
      font_size = "normalsize",
      packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools", "braket" },
      tpl = [[
      \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
      \usepackage{${packages}}
      \ExplSyntaxOn%
      \NewDocumentCommand{\getenv}{om}
      {
        \sys_get_shell:nnN { kpsewhich ~ --var-value ~ #2 } % texlab: ignore
        { \cctab_select:N \c_str_cctab } \l_tmpa_tl
        \tl_trim_spaces:N \l_tmpa_tl
        \IfNoValueTF{ #1 }
        { \tl_use:N \l_tmpa_tl }
        { \tl_set_eq:NN #1 \l_tmpa_tl }
      }
      \ExplSyntaxOff%
      \getenv[\HOME]{HOME}
      \input{\HOME/Documents/definitions.tex}
      \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
    },
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = M.opts.image.formats,
  callback = function()
    require "snacks.image"
  end,
})

M.opts.input = {
  enabled = true,
  win = {
    width = function(win)
      local len = 0.9
      if type(win.opts.title) == "string" then
        len = math.min(#win.opts.title + 15, math.floor(vim.o.columns * 0.8))
      elseif type(win.opts.title) == "table" then
        len = math.min(#win.opts.title[1][1] + 15, math.floor(vim.o.columns * 0.8))
      end
      return len
    end,
    relative = "cursor",
    row = 1,
    col = 0,
  },
}

M.opts.scroll = {
  enabled = true,
  filter = function(buf)
    return vim.bo[buf].filetype ~= "bigfile" and vim.bo[buf].filetype ~= "snacks_terminal"
  end,
}

return M
