local disabled = {
  "folke/flash.nvim",
  "zbirenbaum/copilot-cmp",
  "echasnovski/mini.indentscope",
}

local mapped = {}
for _, v in ipairs(disabled) do
  table.insert(mapped, { v, enabled = false })
end

return mapped
