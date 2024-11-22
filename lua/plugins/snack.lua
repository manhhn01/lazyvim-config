return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = function(_, opts)
    ---@type snacks.Config
    local config = {
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "compact",
      },
      win = {
        backdrop = 100, -- disable backdrop
      },
    }

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
