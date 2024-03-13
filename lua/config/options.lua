-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ";"

-- Enable LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.autowrite = false -- Auto write

opt.scrolloff = 5 -- Lines of context

opt.undofile = true

opt.showbreak = "↪"
opt.wrap = true -- Wrap lines
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.list = true
opt.listchars:append("trail:⋅")
opt.listchars:append("multispace:⋅")
opt.listchars:append("lead: ")

opt.pumblend = 0

if vim.g.neovide then
  vim.o.guifont = "VictorMono Nerd Font:h14"
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_window_blurred = true
  -- vim.g.neovide_floating_blur_amount_x = 0.5
  -- vim.g.neovide_floating_blur_amount_y = 0.5
  vim.g.neovide_transparency = 0.5
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.g.neovide_floating_shadow = false
end
