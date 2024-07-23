-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Turn off number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber signcolumn=no nospell",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_wrap_spell"),
  pattern = { "TelescopePrompt", "dashboard", "neo-tree", "lazy", "spectre_panel", "neotest-summary" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt.wrap = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
    vim.o.backupext = extension
  end,
})
