return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
      default_mappings = false,
      default_commands = true,
      disable_diagnostics = true,
    },
    event = "VeryLazy",
    keys = {
      {
        "<space>cc",
        function()
          local actions = {
            GitConflictCurrent = "ours",
            GitConflictCurrentLabel = "ours",
            GitConflictAncestor = "base",
            GitConflictAncestorLabel = "base",
            GitConflictIncoming = "theirs",
            GitConflictIncomingLabel = "theirs",
          }

          local mark = vim.iter(vim.inspect_pos().extmarks):find(function(e)
            return e.ns == "git-conflict" and actions[e.opts.hl_group]
          end)

          if not mark then
            vim.notify("No conflict under cursor", vim.log.levels.WARN)
            return
          end
          require("git-conflict").choose(actions[mark.opts.hl_group])
        end,
        mode = { "n" },
        desc = "Choose conflict: cursor",
      },
      {
        "<space>co",
        "<Plug>(git-conflict-ours)",
        mode = { "n" },
        desc = "Choose conflict: ours",
      },
      {
        "<space>ct",
        "<Plug>(git-conflict-theirs)",
        mode = { "n" },
        desc = "Choose conflict: theirs",
      },
      {
        "<space>cb",
        "<Plug>(git-conflict-both)",
        mode = { "n" },
        desc = "Choose conflict: both",
      },
      {
        "<space>c0",
        "<Plug>(git-conflict-none)",
        mode = { "n" },
        desc = "Choose conflict: none",
      },
      {
        "[x",
        "<Plug>(git-conflict-prev-conflict)",
        mode = { "n" },
        desc = "Previous conflict",
      },
      {
        "]x",
        "<Plug>(git-conflict-next-conflict)",
        mode = { "n" },
        desc = "Next conflict",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      preview_config = {
        style = "minimal",
        relative = "cursor",
        border = "rounded",
        row = 1,
        col = 0,
        title = " Preview hunk ",
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

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "folke/snacks.nvim", -- optional
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
}
