return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            selection_display = function(char, _windowid)
              return "%=「 " .. char .. " 」%="
            end,
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify", "noice", "incline" },
                buftype = { "terminal", "quickfix", "help" },
              },
            },
          })
        end,
      },
    },
    lazy = false,
    opts = {
      source_selector = {
        winbar = true,
        separator = "",
      },
      filesystem = {
        commands = {
          -- image_preview = function(state)
          --   local node = state.tree:get_node()
          --   if node.type == "file" then
          --     -- TODO:
          --   end
          -- end,
          -- over write default 'delete' command to 'trash'.
          delete = function(state)
            local inputs = require("neo-tree.ui.inputs")
            local path = state.tree:get_node().path
            local msg = "Are you sure you want to trash " .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end

              vim.fn.system({ "trash", vim.fn.fnameescape(path) })
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,

          -- over write default 'delete_visual' command to 'trash' x n.
          delete_visual = function(state, selected_nodes)
            local inputs = require("neo-tree.ui.inputs")

            -- get table items count
            function GetTableLen(tbl)
              local len = 0
              for n in pairs(tbl) do
                len = len + 1
              end
              return len
            end

            local count = GetTableLen(selected_nodes)
            local msg = "Are you sure you want to trash " .. count .. " files ?"
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, node in ipairs(selected_nodes) do
                vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
              end
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        },
      },
      close_if_last_window = true,
      window = {
        mappings = {
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
            vim.notify("Copied path to clipboard: " .. path)
          end,
          ["o"] = { "open_with_window_picker", nowait = true },
          ["oc"] = "none",
          ["od"] = "none",
          ["og"] = "none",
          ["om"] = "none",
          ["on"] = "none",
          ["os"] = "none",
          ["ot"] = "none",
          ["<c-h>"] = "open_split",
          ["<c-v>"] = "open_vsplit",
          ["<c-t>"] = "open_tabnew",
          ["s"] = "none",
          ["/"] = "none",
          -- ["<leader>p"] = "image_preview",
        },
      },
    },
  },
}
