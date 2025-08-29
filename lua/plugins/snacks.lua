---@diagnostic disable: missing-fields
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
        margin = { top = 0, right = 1, bottom = 1 },

        ---@type snacks.notifier.style
        style = function(buf, notif, ctx)
          local title = vim.trim(notif.icon .. " " .. (notif.title or ""))
          if title ~= "" then
            ctx.opts.title = { { " " .. title .. " ", ctx.hl.title } }
            ctx.opts.title_pos = "left"
          end

          ctx.opts.border = "solid"
          ctx.opts.wo.winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"

          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(notif.msg, "\n"))
        end,
      },

      win = {
        backdrop = 100, -- disable backdrop
      },

      picker = {
        previewers = {
          git = { native = true },
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

      terminal = { enabled = false },
      scratch = { enabled = false },
      dashboard = { enabled = false },
      scroll = { enabled = false },
      indent = { enabled = false },
    }

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
