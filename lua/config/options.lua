vim.g.mapleader = ";"

vim.g.autoformat = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

vim.o.shell = "/bin/bash"
vim.o.shortmess = "tFocWTCOl" -- enable intro

opt.autowrite = false

opt.scrolloff = 5

opt.undofile = true
opt.backup = true

opt.wrap = true
opt.showbreak = "↪"

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
opt.listchars:append("tab:→ ")

opt.spell = true
opt.spelllang = "en_us"
opt.spelloptions = { "camel", "noplainbuffer" }

opt.pumblend = 0

------------------------------
-- Status line
------------------------------
local mode_map = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  [""] = "V-BLOCK",
  c = "CMD",
  R = "REPLACE",
}

function _G.get_mode()
  local m = vim.fn.mode()
  return mode_map[m] or m
end

vim.opt.statusline = table.concat({
  "%#StatusLineMode# %{v:lua.get_mode()} ",
  "%#StatusLineFile# %<%f ",
  "%#StatusLineNormal# %m%r%h ",
  "%=",
  "%#StatusLineEnc#  %{&fenc==''?&enc:&fenc} ",
  "%#StatusLinePos# %l:%c %P ",
})
------------------------------
-- Rust LSP
------------------------------
vim.g.rustaceanvim = {
  server = {
    cmd = function()
      local mason_registry = require("mason-registry")
      local ra_binary = mason_registry.is_installed("rust-analyzer")
          -- This may need to be tweaked, depending on the operating system.
          and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
        or "rust-analyzer"
      return { ra_binary }
    end,
  },
}

------------------------------
-- NeoVide
------------------------------
if vim.g.neovide then
  vim.o.winblend = 0
  vim.o.guifont = "Maple Mono NF:h13"
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_input_macos_option_key_is_meta = "both"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_opacity = 0.925
  -- vim.g.neovide_text_gamma = 0.8
  -- vim.g.neovide_text_contrast = 0.2
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_blur_amount_x = 10.0
  vim.g.neovide_floating_blur_amount_y = 10.0

  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.2
  vim.g.transparent = false

  vim.g.neovide_cursor_hack = true
else
  vim.g.transparent = os.getenv("TRANSPARENT") == "1" or false

  opt.guicursor = "i:ver1,c:ver1,a:blinkon4,a:blinkwait1" -- blinking cursor
end

------------------------------
-- Backup and Undo Directories
------------------------------
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

------------------------------
-- Diff saved buffer
-- https://www.reddit.com/r/neovim/comments/15ue6vh/comment/jwpbbvr
------------------------------
vim.api.nvim_create_user_command("DiffOrig", function()
  local scratch_buffer = vim.api.nvim_create_buf(false, true)
  local current_ft = vim.bo.filetype
  vim.cmd("vertical sbuffer" .. scratch_buffer)
  vim.bo[scratch_buffer].filetype = current_ft
  vim.cmd("read ++edit #") -- load contents of previous buffer into scratch_buffer
  vim.cmd.normal('1G"_d_') -- delete extra newline at top of scratch_buffer without overriding register
  vim.cmd.diffthis() -- scratch_buffer
  vim.cmd.wincmd("p")
  vim.cmd.diffthis() -- current buffer
end, {})
