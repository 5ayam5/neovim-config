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
      adapter = "codex",
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
}
