local image_sections = {
  {
    pane = 1,
    section = "terminal",
    enabled = vim.fn.executable("cbonsai") == 1,
    cmd = "cbonsai -li",
    height = math.max(8, math.floor(vim.o.lines * 0.5)),
    padding = 2,
  },

  {
    pane = 1,
    section = "terminal",
    enabled = vim.fn.executable("chafa") == 1,
    cmd = "chafa ~/.config/nvim/assets/background/doge.png --format symbols --symbols vhalf --size 60x30 --fit-width",
    height = 18,
    padding = 2,
  },
}

---@type snacks.dashboard.Section[]
local section = {
  vim.o.columns >= 128 and image_sections[1] or {},

  {
    icon = " ",
    indent = 0,
    title = "Keymaps",
    pane = 2,
    padding = 1,
  },

  {
    pane = 2,
    section = "keys",
    gap = 0,
    padding = 2,
    indent = 2,
  },

  vim.o.lines >= 24 and {
    icon = "",
    enabled = vim.fn.isdirectory(".git") == 1 and vim.fn.executable("onefetch") == 1,
    title = "Git Status",
    pane = 2,
    padding = 1,
    indent = 0,
  } or {},

  vim.o.lines >= 24 and {
    pane = 2,
    section = "terminal",
    enabled = vim.fn.isdirectory(".git") == 1 and vim.fn.executable("onefetch") == 1,
    cmd = "onefetch --no-art --no-color-palette --nerd-fonts --no-title -d url -d languages -d project",
    height = 8,
    padding = 1,
    indent = 2,
  } or {},

  { section = "startup" },
}

return section
