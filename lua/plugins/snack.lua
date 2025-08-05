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
    ---@type snacks.config
    local config = {
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
          preset = function(source)
            if source == "grep" or string.match(source, "^git_.+") then
              return "default"
            end

            return "dropdown"
          end,
        },
      },

      input = {},

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
