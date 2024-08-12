return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "S",
        delete = "ds",
        replace = "cs",

        -- default
        -- find = "gsf",
        -- find_left = "gsF",
        -- highlight = "gsh",
        -- update_n_lines = "gsn",
      },
    },
    n_lines = 100,
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
        debounce = 75,
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
    "folke/noice.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.routes, {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+ lines yanked" },
            },
          },
          view = "mini",
        },

        -- skip notify
        {
          filter = {
            event = "notify",
            any = {
              { find = "Cannot find provider for the feature" },
            },
          },
          opts = {
            skip = true,
          },
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "Pick window:%s*" },
              { find = "tsserver" },
            },
          },
          opts = {
            skip = true,
          },
        },
        {
          filter = {
            event = "notify",
            any = {
              { find = "tsserver" },
              { find = "No information available" },
            },
          },
          opts = {
            skip = true,
          },
        },
        {
          filter = {
            event = "lsp",
            any = {
              { find = "Inlay Hints request failed" },
            },
          },
          opts = {
            skip = true,
          },
        },
      })

      return vim.tbl_deep_extend("force", opts, {
        cmdline = {
          format = {
            cmdline = { title = " Commands ", pattern = "^:", icon = " ", lang = "vim" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
            search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
          },
        },
        lsp = {
          hover = {
            silent = true,
          },
        },
        presets = {
          lsp_doc_border = vim.g.transparent or false,
        },
      })
    end,
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")
      local wpm = require("wpm")

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            Util.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
          },
          lualine_x = {
          -- stylua: ignore
          {
            --- @diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.command.get() end,
            --- @diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            --- @diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.mode.get() end,
            --- @diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            wpm.wpm,
            wpm.historic_graph,
          },
          lualine_z = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },

  {
    "b0o/incline.nvim",
    event = "BufReadPost",
    dependencies = {
      {
        "echasnovski/mini.icons",
      },
    },

    opts = {
      highlight = {
        groups = {
          InclineNormal = {
            default = true,
            group = "TelescopePreviewLink",
          },
          InclineNormalNC = {
            default = true,
            group = "Comment",
          },
        },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local helpers = require("incline.helpers")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local modified = vim.bo[props.buf].modified

        if filename == "" then
          filename = "[No Name]"
        end

        local icon, hl = MiniIcons.get("file", filename)
        local hl_info = vim.api.nvim_get_hl(0, {
          name = hl,
        })

        local bg_color = hl_info.bg and string.format("#%06X", hl_info.bg)
        local fg_color = hl_info.fg and string.format("#%06X", hl_info.fg)

        -- See: https://github.com/b0o/incline.nvim/issues/41
        local shorten_path_styled = require("utils.utils").shorten_path_styled(vim.api.nvim_buf_get_name(props.buf), {
          short_len = 1,
          tail_count = 2,
          head_max = 4,
          head_style = { group = "Comment" },
        })

        return {
          guibg = "#1e1e2e",
          not vim.g.transparent
              and icon
              and bg_color
              and { " ", icon, "  ", guibg = bg_color, guifg = helpers.contrast_color(bg_color) }
            or "",
          vim.g.transparent and icon and fg_color and { " ", icon, " ", guifg = fg_color } or "",
          " ",
          shorten_path_styled,
          modified and " 󰙴 " or "",
          " ",
        }
      end,
    },
    config = function(_, opts)
      require("incline").setup(opts)
    end,
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

  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinNew",
    opts = {
      highlight = {
        bg = vim.g.transparent and "NONE" or nil,
        fg = vim.g.transparent and "#48548a" or nil,
      },
      interval = 45,
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "neo-tree" },
      symbols = { "─", "│", "┌", "┐", "└", "┘" },
      close_event = function() end,
      create_event = function()
        local win_n = require("colorful-winsep.utils").calculate_number_windows()
        if win_n == 2 then
          local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
          local filetype = vim.api.nvim_get_option_value("filetype", {
            buf = vim.api.nvim_win_get_buf(win_id),
          })
          if filetype == "neo-tree" then
            require("colorful-winsep").NvimSeparatorDel()
          end
        end
      end,
    },
    config = function(_, opts)
      require("colorful-winsep").setup(opts)
    end,
  },

  {
    "smoka7/hop.nvim",
    event = "BufReadPost",
    keys = {
      {
        "f",
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
          })
        end,
        mode = { "n", "x" },
        desc = "Hop next character",
        remap = true,
      },
      {
        "F",
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          })
        end,
        mode = { "n", "x" },
        desc = "Hop previous character",
        remap = true,
      },
      {
        "t",
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
          })
        end,
        mode = { "n", "x" },
        desc = "Hop till next characters",
        remap = true,
      },
      {
        "T",
        function()
          require("hop").hint_char1({
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          })
        end,
        mode = { "n", "x" },
        desc = "Hop till previous characters",
        remap = true,
      },
    },
    config = function()
      require("hop").setup({
        keys = "asdghklqwertyuiopzxcvbnmfj123",
        teasing = false,
      })
    end,
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
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "<Tab>",
      backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = true, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      -- default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
      -- default_shift_tab = "<C-d>", -- reverse shift default action,
      enable_backwards = false,
      completion = false, -- if the tabkey is used in a completion pum
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      ignore_beginning = true,
      exclude = {},
    },
    config = function(_, opts)
      require("tabout").setup(opts)
    end,
  },

  {
    "vyfor/cord.nvim",
    build = "./build",
    event = "VeryLazy",
    opts = {
      usercmds = true, -- Enable user commands
      log_level = "warn",

      timer = {
        enable = true, -- Enable automatically updating presence
        interval = 5000,
        reset_on_idle = false, -- Reset start timestamp on idle
        reset_on_change = false, -- Reset start timestamp on presence change
      },
      editor = {
        image = nil, -- Image ID or URL in case a custom client id is provided
        client = "neovim", -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
        tooltip = "hyperextensible Vim-based text editor ", -- Text to display when hovering over the editor's image
      },
      display = {
        show_time = true, -- Display start timestamp
        show_repository = true, -- Display 'View repository' button linked to repository url, if any
        show_cursor_position = true, -- Display line and column number of cursor's position
        swap_fields = false, -- If enabled, workspace is displayed first
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
        timeout = 1800000, -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
        disable_on_focus = true, -- Do not display idle status when neovim is focused
        text = "Idle", -- Text to display when idle
        tooltip = "💤", -- Text to display when hovering over the idle image
      },
      text = {
        viewing = "Viewing {}", -- Text to display when viewing a readonly file
        editing = "Editing {}", -- Text to display when editing a file
        file_browser = "Browsing files in {}", -- Text to display when browsing files (Empty string to disable)
        plugin_manager = "Managing plugins in {}", -- Text to display when managing plugins (Empty string to disable)
        lsp_manager = "Configuring LSP in {}", -- Text to display when managing LSP servers (Empty string to disable)
        workspace = "In a workspace", -- Text to display when in a workspace (Empty string to disable)
      },
      buttons = {
        {
          label = "View Repository", -- Text displayed on the button
          url = "https://www.youtube.com/watch?v=iik25wqIuFo", -- URL where the button leads to ('git' = automatically fetch Git repository URL)
        },
      },
      assets = { -- Custom file icons
        -- lazy = {                                 -- Vim filetype or file name or file extension = table or string (see wiki)*
        --   name = 'Lazy',                         -- Optional override for the icon name, redundant for language types
        --   icon = 'https://example.com/lazy.png', -- Rich Presence asset name or URL
        --   tooltip = 'lazy.nvim',                 -- Text to display when hovering over the icon
        --   type = 2,                              -- 0 = language, 1 = file browser, 2 = plugin manager, 3 = lsp manager; defaults to language
        -- },
        -- ['Cargo.toml'] = 'crates',
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

  { "akinsho/git-conflict.nvim", version = "*", config = true },

  {
    "lukas-reineke/headlines.nvim",
    opts = {
      markdown = {
        fat_headline_upper_string = "▁",
        fat_headline_lower_string = "▔", -- better font support
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade_in_slide_out",
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      ["*"] = {
        css = true,
        css_fn = true,
        mode = "background",
      },
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

  {
    "jcdickinson/wpm.nvim",
    event = "BufEnter",
    config = true,
  },
}
