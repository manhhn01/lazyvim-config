local kind = require("utils.kind")

return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "AvanteInput", "AvantePromptInput", "minifiles", "typr" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    keymap = { preset = "default" },
    sources = {
      providers = {
        lsp = {
          opts = {
            tailwind_color_icon = kind.vscode_kind.Color,
          },
        },
      },
    },
    appearance = {
      kind_icons = kind.vscode_kind,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      ghost_text = {
        enabled = false,
      },
      menu = {
        draw = {
          gap = 2,
          columns = { { "label", "label_description", gap = 2 }, { "kind_icon", "kind" } },
          treesitter = {},
          components = {
            label = {
              width = { fill = true, max = 35 },
            },
          },
        },
      },
      -- documentation = {
      --   window = {
      --     border = "rounded",
      --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      --   },
      -- },
    },
  },
}
