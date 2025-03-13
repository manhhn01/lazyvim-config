return {
  "stevearc/conform.nvim",
  keys = {
    opts = {
      formatters_by_ft = {
        motoko = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = function(self, ctx)
            return { "--plugin", "prettier-plugin-motoko" }
          end,
        },
      },
    },
  },
}
