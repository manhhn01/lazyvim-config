local kind = require("utils.kind")

return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "AvanteInput", "minifiles" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    keymap = { preset = "default" },
    appearance = {
      kind_icons = kind.vscode_kind,
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
      menu = {
        border = "rounded",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
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
      documentation = {
        window = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
      },
    },
  },
}
