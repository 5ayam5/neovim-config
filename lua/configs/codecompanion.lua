return {
  adapters = {
    acp = {
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          defaults = {
            auth_method = "chat-gpt",
          },
        })
      end,
    },
  },
  interactions = {
    background = {
      chat = {
        opts = {
          enabled = true,
        },
        slash_commands = {
          ["file"] = {
            opts = {
              provider = "snacks",
            },
          },
        },
        callbacks = {
          ["on_ready"] = {
            actions = {
              "interactions.background.builtin.chat_make_title",
            },
            enabled = true,
          },
        },
      },
    },
    chat = {
      adapter = "claude_code",
    },
  },
  display = {
    chat = {
      window = {
        layout = "buffer",
        buflisted = true,
        opts = {
          number = true,
          relativenumber = true,
          wrap = true,
        },
      },
      fold_reasoning = true,
      show_reasoning = true,
    },
  },
  extensions = {
    display_tweaks = {
      callback = {
        setup = function()
          -- Rewrite LaTeX math delimiters so markview renders them:
          -- \( \) -> $ $   and   \[ \] -> $$ $$
          local function fix_math(s)
            return (s:gsub("\\%[", "$$"):gsub("\\%]", "$$"):gsub("\\%(", "$"):gsub("\\%)", "$"))
          end
          -- streaming can split a delimiter across chunks (the `\` ends one
          -- chunk, the bracket starts the next), so hold a trailing backslash
          -- until the next chunk completes it; keyed per formatter instance
          -- (one per chat), weak so instances can be collected
          local pending = setmetatable({}, { __mode = "k" })
          for _, mod in ipairs {
            "codecompanion.interactions.chat.ui.formatters.standard",
            "codecompanion.interactions.chat.ui.formatters.reasoning",
          } do
            local ok, formatter = pcall(require, mod)
            if ok and not formatter.__math_patched then
              formatter.__math_patched = true
              local format = formatter.format
              formatter.format = function(self, message, opts, state)
                if type(message.content) == "string" then
                  local content = (pending[self] or "") .. message.content
                  pending[self] = nil
                  if content:sub(-1) == "\\" then
                    pending[self] = "\\"
                    content = content:sub(1, -2)
                  end
                  message.content = fix_math(content)
                end
                return format(self, message, opts, state)
              end
            end
          end

          ---@class CodeCompanion.PatchedBlinkSource: blink.cmp.Source
          ---@field __buflisted_patched? boolean
          local blink_ok, blink_src = pcall(require, "codecompanion.providers.completion.blink")
          ---@cast blink_src CodeCompanion.PatchedBlinkSource
          if blink_ok and not blink_src.__buflisted_patched then
            blink_src.__buflisted_patched = true
            local execute = blink_src.execute
            ---@diagnostic disable-next-line: duplicate-set-field
            blink_src.execute = function(self, ctx, item, callback, default_implementation)
              local prev = vim.bo[ctx.bufnr].buflisted
              local ret = execute(self, ctx, item, callback, default_implementation)
              if prev and vim.api.nvim_buf_is_valid(ctx.bufnr) then
                vim.bo[ctx.bufnr].buflisted = true
              end
              return ret
            end
          end
        end,
      },
    },
  },
}
