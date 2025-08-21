return {
  "akinsho/bufferline.nvim",
  init = function() -- HACK: workaround
    local bufline = require("catppuccin.groups.integrations.bufferline")
    function bufline.get()
      return bufline.get_theme()
    end
  end,
  opts = {
    options = {
      indicator = {
        icon = "▌",
        style = "icon",
      },
      separator_style = { " ", " " },
    },
  },
}
