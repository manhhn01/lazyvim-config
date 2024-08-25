-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local neotreecmd = require("neo-tree.command")

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

-- Select all text in the buffer
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("n", "<D-a>", "ggVG", { desc = "Select all" })

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

-- buffers
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
unmap("n", "n")
unmap("x", "n")
unmap("o", "n")
unmap("n", "N")
unmap("x", "N")
unmap("o", "N")

-- new file
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })

-- formatting
map({ "n", "v" }, "<leader>i", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- Remove floating terminal mappings
unmap("n", "<leader>ft")
unmap("n", "<leader>fT")

map("t", "<C-[>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
map("n", "ss", "<C-W>s", { desc = "Split window below" })
map("n", "sv", "<C-W>v", { desc = "Split window right" })

map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- lsp
map("n", "L", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>rn", "<leader>cr", { desc = "Rename", remap = true })

-- neo-tree
map("n", "se", function()
  neotreecmd.execute({ toggle = false, dir = vim.uv.cwd() })
end, { desc = "Focus NeoTree(cwd)" })
map("n", "sE", function()
  neotreecmd.execute({ toggle = false, dir = Util.root() })
end, { desc = "Focus NeoTree(root dir)" })

-- telescope
map("n", "<leader>fd", "<leader>sd", { remap = true })
map("n", "<leader>fw", "<leader>sg", { remap = true })
map("n", "<leader>fW", "<leader>sG", { remap = true })
map("n", "<leader>rr", "<leader>sR", { remap = true })
map("n", "<leader>o", "<leader>ss", { remap = true })
map("n", "<leader>O", "<leader>sS", { remap = true })
map("n", "<leader>ft", "<leader>st", { remap = true })
map("n", "<leader>fo", "<leader>fr", { remap = true })
map("n", "<leader>fO", "<leader>fr", { remap = true })

-- gitsigns
unmap("n", "<leader><space>")
map("n", "<space><space>", function()
  require("gitsigns").preview_hunk()
end)
map("n", "<space>j", function()
  require("gitsigns").next_hunk()
end)

map("n", "<space>k", function()
  require("gitsigns").prev_hunk()
end)

-- quick move cursor in insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })

-- replace to black hole register
map("x", "<leader>P", '"_dP', { desc = "Replace to black hole register" })

-- some abbreviations for common typos
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
