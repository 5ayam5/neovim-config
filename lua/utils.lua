local M = {}

-- Wrap a function so it runs [count] times (defaults to 1) when the mapping is
-- invoked with a count, e.g. `3<leader>jr`.
function M.incorporate_count(key_func)
  return function()
    for _ = 1, vim.v.count1 do
      key_func()
    end
  end
end

return M
