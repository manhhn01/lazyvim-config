local mini_files = require("mini.files")

return {
  "echasnovski/mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_nofocus = 20,
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
          table.insert(config.title, { " ", "NormalFloat" })
        end
        if config.title[1][1] ~= " " then
          table.insert(config.title, 1, { " ", "NormalFloat" })
        end

        vim.api.nvim_win_set_config(win_id, config)
      end,
    })
  end,
}
