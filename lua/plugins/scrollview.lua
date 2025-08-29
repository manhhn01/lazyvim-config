return {
  "dstein64/nvim-scrollview",
  event = "BufReadPost",
  opts = {
    excluded_filetypes = { "NvimTree", "dashboard", "snacks_dashboard", "neoterm", "neo-tree" },
    current_only = true,
    winblend_gui = vim.g.transparent and 15 or 20,
    base = "right",
    column = 1,
    signs_column = 0,
    -- diagnostics_error_symbol = "x",
    -- diagnostics_warn_symbol = "!",
    -- diagnostics_hint_symbol = "i",
  },
}
