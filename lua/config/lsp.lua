local util = require("lspconfig.util")

local get_root_tsconfig = function(fname)
  return util.root_pattern("tsconfig.json")(fname) or util.root_pattern(".git")(fname)
end

vim.lsp.config("*", {
  diagnostics = { virtual_text = { prefix = "" } },
  inlay_hints = {
    enabled = true,
    exclude = { "typescriptreact", "javascript", "javascriptreact" },
  },
})
