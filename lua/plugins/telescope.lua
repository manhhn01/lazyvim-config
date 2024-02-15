local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
      keys = function()
        return {
          { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
          {
            "<leader>ff",
            Util.pick("files", {
              layout_strategy = "vertical",
            }),
            desc = "Find Files (root dir)",
          },
          {
            "<leader>fF",
            Util.pick("files", { layout_strategy = "vertical", root = false }),
            desc = "Find Files (cwd)",
          },
        }
      end,
    },
    opts = {
      defaults = {
        prompt_prefix = " ❯ ",
        layout_config = {
          vertical = {
            preview_cutoff = 1,
            prompt_positing = "top",
            height = 0.7,
            width = 0.6,
          },
        },
      },
    },
  },
}
