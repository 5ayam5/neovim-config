local api = vim.api
local autocmd = api.nvim_create_autocmd
local cur_buf = api.nvim_get_current_buf
local get_opt_val = api.nvim_get_option_value

vim.t.bufs = vim.t.bufs
  or vim.tbl_filter(function(bufnr)
    return vim.fn.buflisted(bufnr) == 1
  end, api.nvim_list_bufs())

local group = api.nvim_create_augroup("tabline_lazyload", { clear = true })

autocmd({ "BufAdd", "BufEnter", "TabNew" }, {
  group = group,
  callback = function(args)
    local bufs = vim.t.bufs
    local is_curbuf = cur_buf() == args.buf

    if bufs == nil then
      bufs = is_curbuf and {} or { args.buf }
    else
      if
        not vim.tbl_contains(bufs, args.buf)
        and (args.event == "BufEnter" or not is_curbuf or get_opt_val("buflisted", { buf = args.buf }))
        and api.nvim_buf_is_valid(args.buf)
        and get_opt_val("buflisted", { buf = args.buf })
      then
        table.insert(bufs, args.buf)
      end
    end

    if args.event == "BufAdd" then
      for i, bufnr in ipairs(bufs) do
        if
          bufnr == args.buf
          and #api.nvim_buf_get_name(bufnr) == 0
          and not get_opt_val("buflisted", { buf = bufnr })
        then
          table.remove(bufs, i)
          break
        end
      end
    end

    vim.t.bufs = bufs
  end,
})

autocmd("BufDelete", {
  group = group,
  callback = function(args)
    for _, tab in ipairs(api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
