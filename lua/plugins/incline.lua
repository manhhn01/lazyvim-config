return {
  "b0o/incline.nvim",
  event = "BufReadPost",
  dependencies = { { "echasnovski/mini.icons" } },

  opts = {
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "InclineNormal",
        },
        InclineNormalNC = {
          default = true,
          group = "Comment",
        },
      },
    },
    window = {
      zindex = 30,
      margin = {
        horizontal = 0,
        vertical = 0,
      },
      padding = 0,
      padding_char = " ",
    },
    hide = {
      cursorline = true,
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local modified = vim.bo[props.buf].modified

      if filename == "" then
        filename = "[No Name]"
      end

      local icon, hl = MiniIcons.get("file", filename)
      local hl_info = vim.api.nvim_get_hl(0, {
        name = hl,
      })

      local fg_color = hl_info.fg and string.format("#%06X", hl_info.fg)

      -- See: https://github.com/b0o/incline.nvim/issues/41
      local shorten_path_styled = filename == "[No Name]" and "[No Name]"
        or require("utils.utils").shorten_path_styled(vim.api.nvim_buf_get_name(props.buf), {
          short_len = 1,
          tail_count = 2,
          head_max = 4,
          head_style = { group = "Comment" },
        })

      return {
        icon and fg_color and { " ", icon, " ", guifg = fg_color, guibg = "none" } or "",
        " ",
        shorten_path_styled,
        modified and " 󰙴 " or "",
        " ",
        group = "InclineBg",
      }
    end,
  },
  config = function(_, opts)
    require("incline").setup(opts)
  end,
}
