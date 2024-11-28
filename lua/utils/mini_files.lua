local mini_files = require("mini.files")

local M = {}

--- Given a path, return a shortened version of it.
--- @param buf_id number - The buffer ID
--- @param lhs string - The left-hand side key to map
--- @param direction string - The direction for the split ('h' for horizontal, 'v' for vertical)
--- @param close_on_file boolean - Indicates whether to close the file
--- @return nil - This function does not return anything
M.map_split = function(buf_id, lhs, direction, close_on_file)
  local rhs = function()
    local new_target_window
    local cur_target_window = mini_files.get_explorer_state().target_window

    if cur_target_window ~= nil then
      vim.api.nvim_win_call(cur_target_window, function()
        vim.cmd("belowright " .. direction .. " split")
        new_target_window = vim.api.nvim_get_current_win()
      end)

      mini_files.set_target_window(new_target_window)
      mini_files.go_in({ close_on_file = close_on_file })
    end
  end

  local desc = "Open in " .. direction .. " split"
  if close_on_file then
    desc = desc .. " and close"
  end

  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

---@diagnostic disable-next-line: unused-local
M.filter_show = function(fs_entry)
  return true
end

M.filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

return M
