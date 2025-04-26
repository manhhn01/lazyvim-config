return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = { "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local cspell = require("cspell")

      opts.sources = opts.sources or {}
      local config = {
        config = {
          config_file_preferred_name = "cspell.json",
          cspell_config_dirs = { "~/.config/nvim" },
        },
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      }

      table.insert(opts.sources, cspell.diagnostics.with(config))

      table.insert(opts.sources, cspell.code_actions.with(config))
    end,
  },
}
