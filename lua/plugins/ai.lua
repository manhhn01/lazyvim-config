return {
  {
    "Exafunction/codeium.nvim",
    commit = "2b10c17c46e43154ebd058f6b3d3842dd8fa7cab",
    enabled = true,
    cmd = "Codeium",
    event = "BufReadPost",
    opts = {},
    config = function()
      require("codeium").setup({
        enable_chat = true,
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          map_ktyes = true,
          filetypes = {
            TelescopePrompt = false,
            codecompanion = false,
            snacks_input = false,
            snacks_picker_input = false,
            AvanteInput = false,
            typr = false,
            sh = false,
            yaml = false,
          },
          key_bindings = {
            accept = "<C-u>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-]>",
          },
        },
      })
    end,
  },
}
