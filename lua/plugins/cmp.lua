local cmp = require("cmp")
local kind = require("utils.kind")
local api = vim.api

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local function tailwind(entry, item)
  local entryItem = entry:get_completion_item()
  local color = entryItem.documentation

  if color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
    local hl = "hex-" .. color:sub(2)

    if #api.nvim_get_hl(0, { name = hl }) == 0 then
      api.nvim_set_hl(0, hl, { fg = color })
    end

    item.kind_hl_group = hl
  end
end

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
            tailwind(entry, item)
          end

          item.kind = ((icons[item.kind] or "   ") .. (kind.kind_abbrev[item.kind] or "") or item.kind or "")

          item.menu_hl_group = "Comment"
          item.menu = item.menu and item.menu:sub(1, 40) or ""

          if #item.abbr > 30 then
            item.abbr = item.abbr:sub(1, 30 - 1) .. "…   "
          end

          return item
        end,
      },

      window = {
        completion = {
          side_padding = 1,
          winhighlight = "Normal:CmpPmenu,CursorLine:Visual,Search:None",
          border = border("CmpBorder"),
        },
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          border = border("CmpDocBorder"),
        }),
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          -- entry_filter = function(entry)
          --   return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
          -- end,
        },

        {
          name = "html-css",
          option = {
            enable_on = {
              "typescriptreact",
            }, -- set the file types you want the plugin to work on
            file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
            style_sheets = {
              -- example of remote styles, only css no js for now
              "https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css",
            },
          },
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

  {
    "Jezda1337/nvim-html-css",
    enabled = false,
    event = "VeryLazy",
    ft = "typescriptreact",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("html-css"):setup()
    end,
  },
}
