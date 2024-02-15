-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local bufremove = require("mini.bufremove")
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
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the right" })
map("n", "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })

-- clear search, diff update and redraw
map(
  "n",
  "<leader><Space>",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- TODO: Remove these mappings
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Remove lazy mapping
unmap("n", "<leader>l")

-- new file
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })

-- formatting
map({ "n", "v" }, "<leader>i", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- Remove floating terminal mappings
unmap("n", "<leader>ft")
unmap("n", "<leader>fT")

-- terminal Mappings
map("t", "<C-[", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
map("n", "ss", "<C-W>s", { desc = "Split window below" })
map("n", "sv", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- lsp
map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "L", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>rn", "<leader>cr", { desc = "Rename" })

-- neo-tree
map("n", "se", function()
  neotreecmd.execute({ toggle = false, dir = vim.loop.cwd() })
end, { desc = "Focus NeoTree(cwd)" })
map("n", "sE", function()
  neotreecmd.execute({ toggle = false, dir = Util.root() })
end, { desc = "Focus NeoTree(root dir)" })

-- telescope
map("n", "<leader>fa", "<leader>sa", { remap = true })
map("n", "<leader>fb", "<leader>fb", { remap = true })
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
