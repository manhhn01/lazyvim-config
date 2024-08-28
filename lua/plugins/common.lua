return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "S",
        delete = "ds",
        replace = "cs",
      },
    },
    n_lines = 100,
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "VidocqH/lsp-lens.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        definition = false,
        references = function(count)
          return count .. " references"
        end,
        implements = function(count)
          return count .. " implements"
        end,
      },
    },
    config = function(_, opts)
      require("lsp-lens").setup(opts)
    end,
  },

  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    opts = {
      excluded_filetypes = { "NvimTree", "dashboard", "neoterm", "neo-tree" },
      current_only = true,
      winblend_gui = vim.g.transparent and 15 or 50,
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
    build = "./build",
    event = "VeryLazy",
    opts = {
      usercmds = true,
      log_level = "warn",

      timer = {
        enable = true,
        interval = 5000,
        reset_on_idle = false,
        reset_on_change = false,
      },
      editor = {
        image = nil,
        client = "neovim",
        tooltip = "hyperextensible Vim-based text editor ",
      },
      display = {
        show_time = true,
        show_repository = true,
        show_cursor_position = true,
        swap_fields = false,
        workspace_blacklist = { "private" }, -- List of workspace names to hide
      },
      lsp = {
        show_problem_count = true, -- Display number of diagnostics problems
        severity = 1, -- 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
        scope = "buffer", -- buffer or workspace
      },
      idle = {
        enable = true, -- Enable idle status
        show_status = true, -- Display idle status, disable to hide the rich presence on idle
        timeout = 1800000,
        disable_on_focus = true,
        text = "Idle",
        tooltip = "💤",
      },
      text = {
        viewing = "Viewing {}", -- Text to display when viewing a readonly file
        editing = "Editing {}", -- Text to display when editing a file
        file_browser = "Browsing files in {}",
        plugin_manager = "Managing plugins in {}", -- Text to display when managing plugins
        lsp_manager = "",
        workspace = "In a workspace",
      },
      buttons = {
        {
          label = "View Repository", -- Text displayed on the button
          url = "https://www.youtube.com/watch?v=iik25wqIuFo", -- URL where the button leads to ('git' = automatically fetch Git repository URL)
        },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
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
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      {
        "<C-t>",
        function()
          vim.cmd([[ ToggleTerm direction=horizontal name=' Term ' ]])
        end,
        mode = { "n", "x", "t", "i" },
      },
      {
        "<C-/>",
        function()
          vim.cmd([[ ToggleTerm size=40 direction=float name=' Float Term ' ]])
        end,
      },
    },
    opts = {
      open_mapping = nil,
      shell = "/usr/local/bin/fish",
      float_opts = {
        title_pos = "center",
        border = "rounded",
      },
      highlights = {
        FloatBorder = {
          link = "FloatBorder",
        },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    },
  },
}
