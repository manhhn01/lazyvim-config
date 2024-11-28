local kind = require("utils.kind")

-- TODO: Todo list
-- - Update kind color for tailwind

return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
    },
    kind_icons = kind.vscode_kind,
    windows = {
      ghost_text = {
        enabled = false,
      },
      autocomplete = {
        border = "rounded",
        winhighlight = "Normal:CmpPmenu,CursorLine:Visual,Search:None",
        draw = {
          columns = {
            { "label", "label_description", gap = 2 },
            { "kind_icon", "kind" },
          },
        },
      },
      documentation = {
        border = "rounded",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      },
    },
  },
}
