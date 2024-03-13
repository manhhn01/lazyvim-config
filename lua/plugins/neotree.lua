return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            selection_display = function(char, _windowid)
              return "%=「 " .. char .. " 」%="
            end,
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "incline" },
                buftype = { "terminal", "quickfix", "help" },
              },
            },
          })
        end,
      },
    },
    lazy = false,
    opts = {
      source_selector = {
        winbar = true,
        separator = "",
      },
      close_if_last_window = true,
      window = {
        mappings = {
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
            vim.notify("Copied path to clipboard: " .. path)
          end,
          ["o"] = { "open_with_window_picker", nowait = true },
          ["oc"] = "none",
          ["od"] = "none",
          ["og"] = "none",
          ["om"] = "none",
          ["on"] = "none",
          ["os"] = "none",
          ["ot"] = "none",
          ["<c-h>"] = "open_split",
          ["<c-v>"] = "open_vsplit",
          ["<c-t>"] = "open_tabnew",
          ["s"] = "none",
        },
      },
    },
  },
}
