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
          ------------------------------
          -- Statusline blocks
          ------------------------------
          StatusLineMode = transparent and { fg = colors.mauve, bg = "NONE" }
            or { fg = colors.base, bg = colors.mauve, bold = true },
          StatusLineFile = transparent and { fg = colors.overlay1, bg = "NONE" }
            or { fg = colors.text, bg = colors.surface0 },
          StatusLineNormal = { fg = colors.overlay0, bg = transparent and "NONE" or colors.mantle },
          StatusLineEnc = transparent and { fg = colors.overlay1, bg = "NONE" }
            or { fg = colors.overlay0, bg = colors.mantle },
          StatusLinePos = transparent and { fg = colors.overlay1, bg = "NONE" }
            or { fg = colors.overlay0, bg = colors.mantle },

          ------------------------------
          -- Spell underline
          ------------------------------
          SpellBad = { sp = colors.blue, style = { "undercurl" } },
          SpellLocal = { sp = colors.text, style = { "undercurl" } },
          SpellRare = { sp = colors.green, style = { "undercurl" } },
          SpellCap = { sp = colors.green, style = { "undercurl" } },

          ------------------------------
          -- Incline
          ------------------------------
          InclineBg = { bg = colors.mantle },
          InclineNormal = { fg = colors.maroon },

          ------------------------------
          -- Snacks
          ------------------------------
          SnacksInputTitle = { link = "FloatTitle" },
          SnacksInputBorder = { link = "FloatBorder" },
          SnacksInputNormal = { link = "NormalFloat" },
          SnacksNotifierTitleDebug = { fg = colors.crust, bg = colors.teal },
          SnacksNotifierTitleWarn = { fg = colors.crust, bg = colors.yellow },
          SnacksNotifierTitleError = { fg = colors.crust, bg = colors.red },
          SnacksNotifierTitleTrace = { fg = colors.crust, bg = colors.flamingo },
          SnacksNotifierTitleInfo = { fg = colors.crust, bg = colors.blue },

          ------------------------------
          -- Others
          ------------------------------
          BlinkCmpLabelDescription = { link = "Comment" },
          TreesitterContextBottom = { style = {} },
          IblScope = { fg = colors.surface2 },
          BufferLineIndicatorSelected = { fg = colors.blue },
          DiagnosticFloatingWarn = { bg = colors.mantle },
          LazyGitBorder = { bg = colors.mantle, fg = colors.overlay0 },
          WinSeparator = transparent and { fg = colors.overlay0 } or { fg = colors.surface0 },
        }

        if transparent then
          return vim.tbl_extend("force", custom_highlights, {
            Clear = { bg = "NONE" },
            TreesitterContextLineNumber = { bg = "NONE" },
            BlinkCmpMenu = { bg = colors.mantle },
            BlinkCmpMenuSelection = { bg = colors.surface1 },
          })
        else
          return vim.tbl_extend("force", custom_highlights, {
            TreesitterContextLineNumber = { bg = colors.mantle },
          })
        end
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
        neogit = true,
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
