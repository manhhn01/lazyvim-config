local disabled = {
  "folke/tokyonight.nvim",
  "folke/flash.nvim",
  "zbirenbaum/copilot-cmp",
  "echasnovski/mini.indentscope",
  "L3MON4D3/LuaSnip",
  "friendly-snippets",
  "nvim-snippets",
}

local mapped = {}
for _, v in ipairs(disabled) do
  table.insert(mapped, { v, enabled = false })
end

return mapped
