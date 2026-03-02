local M = {}
local api = vim.api
local cur_buf = api.nvim_get_current_buf
local set_buf = api.nvim_set_current_buf
local get_opt_val = api.nvim_get_option_value

local function buf_index(bufnr)
  for i, value in ipairs(vim.t.bufs) do
    if value == bufnr then
      return i
    end
  end
  return nil
end

M.next = function()
  local bufs = vim.t.bufs
  local cur_buf_index = buf_index(cur_buf())
  if not cur_buf_index then
    set_buf(bufs[1])
    return
  end

  set_buf((cur_buf_index == #bufs) and bufs[1] or bufs[cur_buf_index + 1])
end

M.prev = function()
  local bufs = vim.t.bufs
  local cur_buf_index = buf_index(cur_buf())
  if not cur_buf_index then
    set_buf(bufs[1])
    return
  end

  set_buf((cur_buf_index == 1) and bufs[#bufs] or bufs[cur_buf_index - 1])
end

---@param n number the number of buffers by which to move the current buffer
M.move_buf = function(n)
  local bufs = vim.t.bufs
  for i, bufnr in ipairs(bufs) do
    if bufnr == cur_buf() then
      local new_index = (i + n) % #bufs
      if new_index == 0 then
        new_index = #bufs
      end
      bufs[i], bufs[new_index] = bufs[new_index], bufs[i]
      break
    end
  end

  vim.t.bufs = bufs
  vim.cmd "redrawtabline"
end

---@param bufnr number the buffer number to go to
M.goto_buf = function(bufnr)
  local cur_win = api.nvim_get_current_win()
  local fixedbuf = get_opt_val("winfixbuf", { win = cur_win })

  if fixedbuf then
    for _, win in ipairs(api.nvim_list_wins()) do
      local buflisted = get_opt_val("buflisted", { buf = api.nvim_win_get_buf(win) })
      local tmp_fixedbuf = get_opt_val("winfixbuf", { win = win })

      if buflisted and not tmp_fixedbuf then
        api.nvim_set_current_win(win)
        break
      end
    end
  end

  set_buf(bufnr)
end

M.setup = function()
  return require "myplugins.tabline.tabline"()
end

return M
