-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local map = function(mode, key, result, options)
  local opts = { noremap = true, silent = true }

  local modes = type(mode) == "string" and { mode } or mode

  if options then
    opts = vim.tbl_extend("force", opts, options)
  end

  vim.keymap.set(modes, key, result, opts)
end

local unmap = function(mode, key)
  local modes = type(mode) == "string" and { mode } or mode
  vim.keymap.del(modes, key)
end

map("n", "ga", "ggVG", { desc = "Select all" })

-- Move to window using the s + hjkl keys
map("n", "sh", "<C-w>h", { desc = "Go to left window" })
map("n", "sj", "<C-w>j", { desc = "Go to lower window" })
map("n", "sk", "<C-w>k", { desc = "Go to upper window" })
map("n", "sl", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> + hjkl keys
map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

-- Bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- Revert to original keymaps
unmap("n", "n")
unmap("x", "n")
unmap("o", "n")
unmap("n", "N")
unmap("x", "N")
unmap("o", "N")

map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })

-- Remove floating terminal mappings
unmap("n", "<leader>ft")
unmap("n", "<leader>fT")

map("t", "<C-[>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
map("n", "s", function() end, {})
map("n", "ss", "<C-W>s", { desc = "Split window below" })
map("n", "sv", "<C-W>v", { desc = "Split window right" })

map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Lsp
map("n", "L", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>rn", "<leader>cr", { desc = "Rename", remap = true })
map({ "n", "v" }, "<leader>i", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- Picker
map("n", "<leader>fd", "<leader>sd", { remap = true })
map("n", "<leader>fw", "<leader>sg", { remap = true })
map("n", "<leader>fW", "<leader>sG", { remap = true })
map("n", "<leader>rr", "<leader>sR", { remap = true })
map("n", "<leader>o", "<leader>ss", { remap = true })
map("n", "<leader>O", "<leader>sS", { remap = true })
map("n", "<leader>ft", "<leader>st", { remap = true })
map("n", "<leader>fo", "<leader>fr", { remap = true })
map("n", "<leader>fO", "<leader>fr", { remap = true })

-- Gitsigns
unmap("n", "<leader><space>")
map("n", "<space><space>", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "<space>j", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next hunk" })
map("n", "<space>k", function()
  require("gitsigns").nav_hunk("prev")
end, {
  desc = "Previous hunk",
})

-- Quick move cursor in insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Search and replace word under the cursor
map("n", "<leader>R", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Replace to black hole register
map("x", "<leader>P", '"_dP', { desc = "Replace to black hole register" })

-- Move selected lines with shift+j or shift+k
map("v", "J", ":m '>+1<CR>gv=gv", {
  silent = true,
})
map("v", "K", ":m '<-2<CR>gv=gv", {
  silent = true,
})

-- Reset terminal buffer
map("t", "<c-l>", function()
  vim.cmd(":set scrollback=1 | sleep 100m | set scrollback=10000")
end, { desc = "Reset terminal buffer" })

-- When lines are on, text is off.
map("", "<leader>cd", function()
  vim.diagnostic.config({
  virtual_lines = not vim.diagnostic.config().virtual_lines and { current_line = true } or false,
  virtual_text = not vim.diagnostic.config().virtual_text and { prefix = "" } or false,
  })
end, { desc = "Toggle diagnostic lines" })

-- Some abbreviations for common typos
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
