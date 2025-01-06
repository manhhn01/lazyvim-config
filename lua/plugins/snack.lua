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

      input = {
        win = {
          keys = {
            i_del_word = { "<C-w>", "delete_word", mode = "i" }, -- Delete word in insert mode with ctrl-w
          },
          actions = {
            delete_word = function()
              return "<cmd>normal! diw<cr><right>"
            end,
          },
        },
      },

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
