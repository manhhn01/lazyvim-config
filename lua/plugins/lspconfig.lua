local util = require("lspconfig.util")

local get_root_tsconfig = function(fname)
  return util.root_pattern("tsconfig.json")(fname) or util.root_pattern(".git")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    opts = {
      diagnostics = { virtual_text = { prefix = "" } },
      inlay_hints = {
        enabled = true,
        exclude = {
          "typescriptreact",
          "javascript",
          "javascriptreact",
        },
      },
      servers = {
        motoko_lsp = {},

        eslint = {
          root_dir = util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.mjs"),
        },
        vtsls = {
          root_dir = get_root_tsconfig,

          settings = {
            typescript = { format = { indentSize = 2 } },
            typescriptreact = { format = { indentSize = 2 } },
            completions = {
              completeFunctionCalls = false,
            },
          },
        },
      },
    },
  },
}
