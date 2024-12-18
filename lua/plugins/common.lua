local togglerterm_count = function()
  local count = 0

  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "toggleterm" then
      count = count + 1
    end
  end

  return count
end

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
        tooltip = "hyperextensible Vim-based text editor",
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
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<C-\\>n",
        function()
          local count = togglerterm_count()
          vim.print(count)
          vim.cmd([[ ToggleTerm direction=horizontal name=' Term ' ]])
        end,
        mode = { "n", "x", "t", "i" },
      },
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
          vim.cmd([[ ToggleTerm size=40 direction=float name=' Term ' ]])
        end,
        mode = { "n", "x", "t", "i" },
      },
    },
    opts = {
      open_mapping = nil,
      shell = vim.fn.executable("fish") == 1 and "fish" or vim.o.shell,
      float_opts = {
        title_pos = "center",
        border = "rounded",
      },
      highlights = {
        FloatBorder = {
          link = "ToggleTermNormalFloatBorder",
        },
        NormalFloat = {
          link = "ToggleTermNormalFloat",
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

  {
    "mikesmithgh/kitty-scrollback.nvim",
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    version = "*",
    config = function()
      require("kitty-scrollback").setup()
    end,
  },

  {
    "3rd/image.nvim",
    build = false,
    enabled = not vim.g.neovide,
    event = "VeryLazy",
    opts = {
      processor = "magick_cli",
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = false,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    },

    config = function(_, opts)
      require("image").setup(opts)
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
    cmd = { "Typr" },
  },
}
