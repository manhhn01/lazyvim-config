return {
  "smoka7/hop.nvim",
  event = "BufReadPost",
  keys = {
    {
      "f",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop next character",
      remap = true,
    },
    {
      "F",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop previous character",
      remap = true,
    },
    {
      "t",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          hint_offset = -1,
          current_line_only = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop till next characters",
      remap = true,
    },
    {
      "T",
      function()
        require("hop").hint_char1({
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          hint_offset = 1,
          current_line_only = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Hop till previous characters",
      remap = true,
    },
  },
  config = function()
    require("hop").setup({
      keys = "asdghklqwertyuiopzxcvbnmfj123",
      teasing = false,
    })
  end,
}
