return {
  {
    "Exafunction/codeium.nvim",
    commit = "2b10c17c46e43154ebd058f6b3d3842dd8fa7cab",
    enabled = true,
    cmd = "Codeium",
    event = "BufReadPost",
    opts = {},
    config = function()
      require("codeium").setup({
        enable_chat = true,
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          map_ktyes = true,
          filetypes = {
            TelescopePrompt = false,
            codecompanion = false,
            snacks_input = false,
            snacks_picker_input = false,
            AvanteInput = false,
            typr = false,
            sh = false,
            yaml = false,
          },
          key_bindings = {
            accept = "<C-u>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-]>",
          },
        },
      })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim" },
    },
    event = "BufReadPost",
    opts = {
      opts = {
        -- Set debug logging
        log_level = "DEBUG",
      },
      display = {
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
        },
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            border = "single",
            height = 0.8,
            width = 0.25,
            relative = "editor",
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = true,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              signcolumn = "no",
              spell = false,
              wrap = true,
              number = false,
              relativenumber = false,
            },
          },
          intro_message = "✨ Press ? for options",
          start_in_insert_mode = true,
          show_header_separator = false,
          ---@param adapter CodeCompanion.Adapter
          token_count = function(tokens, adapter) -- The function to display the token count
            return " " .. tokens .. " tokens"
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "openai",
          roles = {
            llm = "CodeCompanion ✨",
            user = "Me",
          },
          keymaps = {
            close = {
              modes = {
                n = "<C-c>",
                i = "<C-c>",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
          },
          opts = {
            system_prompt = [[
You are CodeCompanion, an AI programming helper in Neovim.

Tasks: answer programming or Neovim questions, explain/review code, create tests, suggest fixes, or scaffold code.

Rules:
- When the user asks for code → output **only code** inside 4 backticks + language ID, no explanation unless asked.
- When the user asks for text → reply very briefly and clearly in ${language}.
- Use `// filepath: /path` only if file location is known; use `// ...existing code...` for context.
- No diff formatting, no line numbers, no headers.
- Show only essential code.

Process:
1. Think step by step.
2. Give a short plan (pseudocode) first only if needed.
3. End text answers with a brief next-step suggestion.
]],
          },
        },
        inline = {
          adapter = "openai",
        },
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
          })
        end,
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          vim.cmd("CodeCompanionChat Toggle")
        end,
        mode = { "n", "x" },
        desc = "Code companion chat",
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionAction")
        end,
        mode = { "n", "x" },
        desc = "Code companion action",
      },
      {
        "<leader>ae",
        function()
          local message = vim.fn.input("Enter message: ")
          vim.cmd("CodeCompanion " .. message)
        end,
        mode = { "n", "x" },
        desc = "Code companion inline edit",
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },
}
