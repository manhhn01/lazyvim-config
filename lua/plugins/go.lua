return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.setup = opts.setup or {}

      opts.setup.gopls = function()
        Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
          if client.server_capabilities.semanticTokensProvider then
            return
          end

          local semantic = vim.tbl_get(client.config, "capabilities", "textDocument", "semanticTokens")
          if not semantic then
            return
          end

          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
              tokenTypes = semantic.tokenTypes,
              tokenModifiers = semantic.tokenModifiers,
            },
            range = true,
          }
        end)
      end
    end,
  },
}
