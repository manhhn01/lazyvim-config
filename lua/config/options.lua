-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ";"

-- LazyVim auto format
vim.g.autoformat = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

vim.o.shell = "/bin/bash"

opt.autowrite = false -- Auto write

opt.scrolloff = 5 -- Lines of context

opt.undofile = true
opt.backup = true

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
opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = { "camel", "noplainbuffer" }

opt.pumblend = 0

vim.g.rustaceanvim = {
  server = {
    cmd = function()
      local mason_registry = require("mason-registry")
      local ra_binary = mason_registry.is_installed("rust-analyzer")
          -- This may need to be tweaked, depending on the operating system.
          and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
        or "rust-analyzer"
      return { ra_binary } -- You can add args to the list, such as '--log-file'
    end,
  },
}

if vim.g.neovide then
  vim.o.guifont = "VictorMono Nerd Font:h15:w1:#e-subpixelantialias:#h-slight"
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_window_blurred = false
  vim.g.neovide_transparency = 1
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.g.neovide_floating_shadow = false

  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.2

  vim.g.transparent = false
else
  vim.g.transparent = os.getenv("TRANSPARENT") == "1" or true

  opt.guicursor = "i:ver1,c:ver1,a:blinkon4,a:blinkwait1" -- blinking cursor
end

local BACKUPDIR = vim.fn.expand("~") .. "/.vim/backup"
local UNDODIR = vim.fn.expand("~") .. "/.vim/undo"

if vim.fn.isdirectory(BACKUPDIR) == 0 then
  vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
  vim.fn.mkdir(UNDODIR, "p", "0o700")
end

opt.backupdir = BACKUPDIR
opt.undodir = UNDODIR
