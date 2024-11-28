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
      dashboard = {
        width = 60,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 8, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
          -- header = [[
          -- ]],
        },
        -- item field formatters
        -- formats = {
        --   icon = function(item)
        --     if item.file and item.icon == "file" or item.icon == "directory" then
        --       return M.icon(item.file, item.icon)
        --     end
        --     return { item.icon, width = 2, hl = "icon" }
        --   end,
        --   footer = { "%s", align = "center" },
        --   header = { "%s", align = "center" },
        --   file = function(item, ctx)
        --     local fname = vim.fn.fnamemodify(item.file, ":~")
        --     fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
        --     local dir, file = fname:match("^(.*)/(.+)$")
        --     return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        --   end,
        -- },
        sections = {
          {
            pane = 1,
            section = "terminal",
            -- cmd = "chafa ~/.config/nvim/assets/background/doge.png --format symbols --symbols vhalf --size 60x30 --fit-width; sleep .1",
            cmd = "cbonsai -li",
            height = 24, -- TODO: recalculate base on window height and width
            padding = 2,
          },

          {
            icon = " ",
            indent = 0,
            title = "Keymaps",
            pane = 2,
            padding = 1,
          },

          {
            pane = 2,
            section = "keys",
            gap = 0,
            padding = 2,
            indent = 2,
          },

          {
            icon = "",
            enabled = vim.fn.isdirectory(".git") == 1 and vim.fn.executable("onefetch") == 1,
            title = "Git Status",
            pane = 2,
            padding = 1,
            indent = 0,
          },

          {
            pane = 2,
            section = "terminal",
            enabled = vim.fn.isdirectory(".git") == 1 and vim.fn.executable("onefetch") == 1,
            cmd = "onefetch --no-art --no-color-palette --nerd-fonts --no-title -d url -d languages -d project",
            height = 8,
            padding = 1,
            indent = 2,
          },

          { section = "startup" },
        },
      },
    }

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
