return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = vim.g.transparent or false,
      float = {
        transparent = false,
        solid = true,
      },
      custom_highlights = function(colors)
        local transparent = vim.g.transparent or false
        local custom_highlights = {
          -- FloatBorder = { bg = colors.mantle },

          BlinkCmpLabelDescription = { link = "Comment" },

          TreesitterContextBottom = { style = {} },

          IblScope = { fg = colors.surface2 },

          BufferLineIndicatorSelected = { fg = colors.blue },

          DiagnosticFloatingWarn = {
            bg = colors.mantle, -- set background color for float warn (solid)
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

          WinSeparator = transparent and {
            fg = colors.overlay0,
          } or {
            fg = colors.surface0,
          },

          CmpItemKindCodeium = {
            fg = colors.lavender,
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
