local cmp = require("cmp")
local kind = require("utils.kind")

return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      experimental = {
        ghost_text = false, -- this feature conflict with copilot.vim's preview.
      },

      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
          -- local icons = require("lazyvim.config").icons.kinds
          local icons = kind.vscode_kind

          local is_color = item.kind == "Color"

          if is_color then
            local formatterd_item = require("tailwindcss-colorizer-cmp").formatter(entry, item)

            if formatterd_item.kind == "XX" then
              item.kind = formatterd_item.kind
            end
          else
            item.kind = (icons[item.kind] or "   ") .. kind.kind_abbrev[item.kind] or item.kind
          end

          item.menu_hl_group = "Comment"

          if #item.abbr > 20 then
            item.abbr = item.abbr:sub(1, 20 - 1) .. "…   "
          end

          return item
        end,
      },

      window = vim.g.transparent and {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      } or nil,

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry)
            return kind.vscode_kind.Snippet ~= entry:get_kind() -- hide snippets
          end,
        },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<S-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
    },
  },
}
