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
      -- diagnostics_error_symbol = "x",
      -- diagnostics_warn_symbol = "!",
      -- diagnostics_hint_symbol = "i",
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
    opts = {
      idle = {
        enabled = false,
      },
      editor = {
        image = nil,
        client = "neovim",
        tooltip = vim.g.neovide and "neovide" or "hyperextensible Vim-based text editor",
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
    enabled = false, -- replaced by hlchunk
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
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "┌",
          left_bottom = "└",
          right_arrow = "─",
        },
      },
      line_num = { enable = true },
      indent = {
        enable = true,
        chars = { "┊" },
      },
    },
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
  {
    "mvllow/modes.nvim",
    lazy = false,
    opts = {
      -- Set opacity for cursorline and number background
      line_opacity = 0.15,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Enable sign column highlights to match cursorline
      set_signcolumn = true,

      -- Disable modes highlights for specified filetypes
      -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
      -- Can also be a function fun():boolean that disables modes highlights when true
      ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
    },
  },

  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
            vim.notify("Harpoon File Added", vim.log.levels.INFO)
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
