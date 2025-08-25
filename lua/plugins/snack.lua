---@diagnostic disable-next-line: unused-local
local snacks = require("snacks")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<leader>/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Grep Buffer",
    },
    {
      "<leader>fi",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
  },
  opts = function(_, opts)
    ---@type snacks.Config
    local config = {
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
      },

      terminal = {
        shell = "fish",
      },

      win = {
        backdrop = 100, -- disable backdrop
      },

      picker = {
        previewers = {
          git = {
            native = true,
          },
        },
        layout = {
          preset = function(source)
            if source == "grep" or string.match(source, "^git_.+") then
              return "default"
            end

            return "dropdown"
          end,
        },
      },

      input = {},

      scratch = {
        zindex = 50,
      },

      lazygit = {
        theme = {
          [241] = { fg = "Special" },
          activeBorderColor = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor = { fg = "Identifier" },
          cherryPickedCommitFgColor = { fg = "Function" },
          defaultFgColor = { fg = "Normal" },
          optionsTextColor = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor = { bg = "Visual" },
          unstagedChangesColor = { fg = "DiagnosticError" },
          inactiveBorderColor = { fg = "LazyGitBorder" },
        },
      },

      dashboard = {
        enabled = false,
      },

      words = {
        enabled = true,
      },

      scroll = {
        enabled = false,
      },

      indent = {
        enabled = false,
      },
    }

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
