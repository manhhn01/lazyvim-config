-- local get_root_dir = function(fname)
--   local util = require("lspconfig.util")
--   return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
-- end

-- workaround for monorepo
local get_root_tsconfig = function(fname)
  local util = require("lspconfig.util")
  return util.root_pattern("tsconfig.json")(fname) or util.root_pattern(".git")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    version = "*",
    opts = {
      diagnostics = {
        float = {
          border = vim.g.transparent and "rounded" or nil,
        },
      },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        eslint = {
          root_dir = get_root_tsconfig,
        },
        vtsls = {
          root_dir = get_root_tsconfig,
          settings = {
            completitions = {
              completeFunctionCalls = false,
            },
          },
        },
      },
    },
  },
}
