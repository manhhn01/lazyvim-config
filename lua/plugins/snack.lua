---@diagnostic disable-next-line: unused-local
local snacks = require("snacks")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function(_, opts)
    ---@type snacks.config
    local config = {
      terminal = {
        enabled = false,
      },

      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
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
          preset = "dropdown",
        },
      },

      input = {},

      dashboard = {
        enabled = false,
      },

      zen = {
        enabled = false,
      },

      words = {
        enabled = true,
      },

      scroll = {
        enabled = true,
      },

      indent = {
        enabled = false,
      },
    }

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
