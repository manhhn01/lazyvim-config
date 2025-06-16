return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "S",
        delete = "ds",
        replace = "cs",
      },
      n_lines = 100,
    },
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    opts = {
      excluded_filetypes = { "NvimTree", "dashboard", "snacks_dashboard", "neoterm", "neo-tree" },
      current_only = true,
      winblend_gui = vim.g.transparent and 15 or 20,
      base = "right",
      column = 1,
      signs_column = 0,
      diagnostics_error_symbol = "x",
      diagnostics_warn_symbol = "!",
      diagnostics_hint_symbol = "i",
    },
  },

  -- TODO: Improve the config of visual multi
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    config = function()
      vim.g.VM_maps["Select Cursor Down"] = "<M-j>"
      vim.g.VM_maps["Select Cursor Up"] = "<M-k>"
      vim.g.VM_maps["Undo"] = "u"
      vim.g.VM_theme = "codedark"
      vim.g.VM_silent_exit = 1
    end,
  },

  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    opts = {
      idle = {
        enabled = false,
      },
      editor = {
        image = nil,
        client = "neovim",
        tooltip = vim.g.neovide and "neovide" or "hyperextensible Vim-based text editor",
      },
      display = {
        display = {
          theme = "pastel",
        },
      },
      text = {
        editing = function(opts)
          if opts.filetype == "rust" then
            return "🦀 Crafting in Rust"
          end
          return "Editing " .. opts.filename
        end,
        workspace = "In a workspace",
        viewing = function(opts)
          return "Viewing " .. opts.filename
        end,
        file_browser = function(opts)
          return "Browsing files in " .. opts.name
        end,
        plugin_manager = function(opts)
          return "Managing plugins in " .. opts.name
        end,
        lsp = function(opts)
          return "Configuring LSP in " .. opts.name
        end,
        docs = function(opts)
          return "Reading " .. opts.name
        end,
        vcs = function(opts)
          return "Committing changes in " .. opts.name
        end,
        notes = function(opts)
          return "Taking notes in " .. opts.name
        end,
        debug = function(opts)
          return "Debugging in " .. opts.name
        end,
        test = function(opts)
          return "Testing in " .. opts.name
        end,
        diagnostics = function(opts)
          return "Fixing problems in " .. opts.name
        end,
        games = function(opts)
          return "Playing"
        end,
        terminal = function(opts)
          return "Running commands in " .. opts.name
        end,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    main = "ibl",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        indent = { char = "┊" },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
        },
      })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion", "Avante" },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        render_modes = { "n", "c", "i" },
      })
    end,
  },

  {
    "nvzone/typr",
    dependencies = {
      "nvzone/volt",
    },
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}
