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
          if icons[item.kind] then
            item.kind = icons[item.kind] .. kind.kind_abbrev[item.kind] or item.kind
          end

          if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
            item.menu_hl_group = "CurSearch"
            if #entry.completion_item.detail > 10 then
              item.menu = " " .. entry.completion_item.detail:sub(1, 10 - 1) .. "…"
            else
              item.menu = " " .. entry.completion_item.detail
            end
          end

          if #item.abbr > 15 then
            item.abbr = item.abbr:sub(1, 15 - 1) .. "…"
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
