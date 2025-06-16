return {
  "folke/noice.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.routes, {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+ lines yanked" },
          },
        },
        view = "mini",
      },

      {
        filter = {
          event = "msg_show",
          any = {
            { find = "Hop%s*" },
          },
        },
        view = "mini",
      },

      {
        filter = {
          event = "notify",
          error = true,
          any = {
            { find = "completion request failed%s*" },
          },
        },
        view = "mini",
      },

      {
        filter = {
          event = "lsp",
          any = {
            { find = "Inlay Hints request failed" },
          },
        },
        view = "mini",
      },

      -- skip notify

      -- Codeium error message
      {
        filter = {
          event = "msg_show",
          kind = "echomsg",
          any = {
            { find = "codeium" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "Pick window:%s*" },
            { find = "tsserver" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          any = {
            { find = "tsserver" },
            { find = "No information available" },
          },
        },
        opts = {
          skip = true,
        },
      },
    })

    return vim.tbl_deep_extend("force", opts, {
      cmdline = {
        format = {
          cmdline = { title = " Commands ", pattern = "^:", icon = " ", lang = "vim" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
          search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
        },
      },
      lsp = {
        hover = {
          silent = true,
        },
      },
      presets = {
        bottom_search = false,
      },
    })
  end,
}
