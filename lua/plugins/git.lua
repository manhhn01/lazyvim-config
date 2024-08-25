return {
  { "akinsho/git-conflict.nvim", version = "*", config = true },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      preview_config = {
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 0,
        title = "Preview hunk",
      },
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        topdelete = { text = "‾" },
        changedelete = { text = "│" },
        untracked = { text = "│" },
      },
    },
  },
}
