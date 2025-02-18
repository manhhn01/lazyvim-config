return {
  {
    "Exafunction/codeium.nvim",
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
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.icons",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    build = "make BUILD_FROM_SOURCE=true",
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini",
        timeout = 30000,
        temperature = 0.4,
        max_tokens = 8000,
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-1.5-flash-latest",
        timeout = 30000,
        temperature = 0.4,
        max_tokens = 8000,
        ["local"] = false,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        diff = {
          ours = "co",
          theirs = "ct",
          none = "c0",
          both = "cb",
          next = "]x",
          prev = "[x",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle = {
          debug = "<leader>ad",
          hint = "<leader>ah",
        },
      },
      hints = { enabled = true },
      windows = {
        sidebar_header = {
          rounded = false,
        },
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim" },
    },
    event = "BufReadPost",
    opts = {
      display = {
        diff = {
          enabled = false,
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
            llm = "CodeCompanion ✨", -- The markdown header content for the LLM's responses
            user = "Me", -- The markdown header for your questions
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
                default = "gpt-4o-mini",
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
          vim.cmd("CodeCompanion /explain")
        end,
        mode = { "n", "x" },
        desc = "Code companion action",
      }

    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },
}
