local kind = require("utils.kind")

-- TODO: Update kind color for tailwind

return {
  "saghen/blink.cmp",
  event = "VeryLazy",
  opts = {
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
