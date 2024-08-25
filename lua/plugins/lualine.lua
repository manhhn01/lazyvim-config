return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = vim.tbl_deep_extend("force", opts.sections, {
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      }),
    }
  end,
}
