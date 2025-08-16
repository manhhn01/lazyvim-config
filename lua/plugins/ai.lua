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
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "VeryLazy",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 150,
        keymap = {
          accept = "<C-u>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 16.x
      server_opts_overrides = {},
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = "make",
    version = false,
    opts = {
      provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          -- disable_tools = { "attempt_completion" },
          extra_request_body = {
            temperature = 0.5,
          },
        },
      },
    },
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
          provider = "mini_diff", -- default|mini_diff
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
          show_header_separator = true,
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
