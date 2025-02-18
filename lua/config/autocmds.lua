-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Disable number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber signcolumn=no nospell",
})

-- Disable comment on new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_wrap_spell"),
  pattern = { "TelescopePrompt", "dashboard", "snacks_dashboard", "neo-tree", "lazy", "grug-far", "neotest-summary" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt.wrap = false
  end,
})

-- Backup on write
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
    local backupdir = vim.fn.expand("~") .. "/.vim/backup/"

    vim.o.backupext = extension
    vim.o.backupdir = backupdir .. vim.fn.getcwd()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "AvanteInput",
  callback = function()
    vim.keymap.set({ "n", "o" }, "q", ":close<CR>", { buffer = true, silent = true })
  end,
})
