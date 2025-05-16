return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = vim.g.transparent or false,
      custom_highlights = function(colors)
        local custom_highlights = {
          -- FloatBorder = { bg = colors.mantle },

          PmenuExtra = { bg = "NONE" },

          -- Completion menu
          CmpBorder = { fg = colors.surface1 },
          CmpDocBorder = { fg = colors.surface1 },
          BlinkCmpLabelDescription = { link = "Comment" },
          BlinkCmpMenu = { bg = colors.base },
          BlinkCmpMenuSelection = { bg = colors.surface0 },
          BlinkCmpMenuBorder = { fg = colors.surface1 },

          TelescopeNormal = { link = "NormalFloat" },

          TreesitterContextBottom = { style = {} },

          IblScope = { fg = colors.surface2 },

          BufferLineIndicatorSelected = { fg = colors.blue },

          WindowPickerStatusLineNC = {
            fg = "#000000",
            bg = colors.blue,
          },

          SpellBad = {
            sp = colors.blue,
            style = { "undercurl" },
          },

          SpellLocal = {
            sp = colors.text,
            style = { "undercurl" },
          },

          SpellRare = {
            sp = colors.green,
            style = { "undercurl" },
          },

          SpellCap = {
            sp = colors.green,
            style = { "undercurl" },
          },

          WinSeparator = {
            fg = colors.surface0,
          },

          CmpItemKindCodeium = {
            fg = colors.lavender,
          },

          ToggleTermNormalFloat = {
            link = "NormalFloat",
          },

          ToggleTermNormalFloatBorder = {
            bg = "NONE",
            fg = colors.blue,
          },

          InclineBg = {
            bg = colors.mantle,
          },

          InclineNormal = {
            fg = colors.maroon,
          },

          NeoTreeIndentMarker = {
            fg = colors.surface1,
          },

          MiniFilesTitleFocused = {
            fg = colors.red,
          },

          FloatTitle = {
            fg = colors.blue,
          },

          StatusLineFile = {
            fg = colors.blue,
          },

          StatusLineNormal = {
            fg = colors.overlay0,
          },
        }

        if vim.g.transparent then
          vim.list_extend(custom_highlights, {
            -- custom highlight for transparent_background
            Clear = {
              bg = "NONE",
            },
            TreesitterContextLineNumber = {
              bg = "NONE",
            },
          })
        else
          vim.list_extend(custom_highlights, {
            TreesitterContextLineNumber = {
              bg = colors.mantle,
            },
          })
        end

        return custom_highlights
      end,
      highlight_overrides = {},
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        blink_cmp = true,
        dashboard = false,
        flash = false,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        snacks = true,
        indent_blankline = { enabled = true },
        leap = false,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "NONE" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        colorful_winsep = {
          enabled = false,
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
