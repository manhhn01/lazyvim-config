local disabled = {
  "folke/flash.nvim",
  "zbirenbaum/copilot-cmp",
  "echasnovski/mini.indentscope",
  "L3MON4D3/LuaSnip",
  "friendly-snippets",
  "nvim-snippets",
  "MeanderingProgrammer/markdown.nvim",
  "lukas-reineke/headlines.nvim"
}

local mapped = {}
for _, v in ipairs(disabled) do
  table.insert(mapped, { v, enabled = false })
end

return mapped
