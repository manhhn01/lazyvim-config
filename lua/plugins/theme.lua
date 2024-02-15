return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = vim.g.transparent or false,
      custom_highlights = function(colors)
        local custom_highlights = {
          IblScope = {
            fg = colors.surface2,
          },

          BufferLineIndicatorSelected = {
            fg = colors.blue,
          },

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
        }

        if vim.g.transparent then
          vim.list_extend(custom_highlights, {
            -- custom highlight for transparent_background
            Clear = {
              bg = "NONE",
            },
          })
        end

        return custom_highlights
      end,
      highlight_overrides = {
        all = function(colors)
          return {
            TreesitterContextLineNumber = {
              bg = colors.base,
            },
            TreesitterContextBottom = {
              style = {},
            },
          }
        end,
      },
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = false,
        flash = false,
        gitsigns = true,
        headlines = true,
        illuminate = true,
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
          -- color = "#48548a",
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
