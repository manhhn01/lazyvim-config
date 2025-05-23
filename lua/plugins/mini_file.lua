local mini_files = require("mini.files")
local mini_utils = require("utils.mini_files")

return {
  "echasnovski/mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_nofocus = 25,
      width_preview = 45,
    },
    options = {
      permanent_delete = false,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        mini_files.open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      "<leader>E",
      function()
        mini_files.open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        local show_dotfiles = true

        local toggle_dotfiles = function()
          show_dotfiles = not show_dotfiles
          local new_filter = show_dotfiles and mini_utils.filter_show or mini_utils.filter_hide
          MiniFiles.refresh({ content = { filter = new_filter } })
        end

        mini_utils.map_split(buf_id, "<C-s>", "belowright horizontal", true)
        mini_utils.map_split(buf_id, "<C-v>", "belowright vertical", true)

        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowOpen",
      callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        local config = vim.api.nvim_win_get_config(win_id)
        config.border, config.title_pos = "rounded", "left"
        vim.api.nvim_win_set_config(win_id, config)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(args)
        local win_id = args.data.win_id

        -- Customize window-local settings
        local config = vim.api.nvim_win_get_config(win_id)

        -- Ensure max height
        config.height = math.min(60, config.height)

        -- Ensure title padding
        if config.title[#config.title][1] ~= " " then
          table.insert(config.title, { " ", "MiniFilesTitle" })
        end
        if config.title[1][1] ~= " " then
          table.insert(config.title, 1, { " ", "MiniFilesTitle" })
        end

        vim.api.nvim_win_set_config(win_id, config)
      end,
    })
  end,
}
