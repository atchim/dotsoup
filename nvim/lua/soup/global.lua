local M = {}

--- Define globals.
M.init = function()
  local g = vim.g

  -- Disable Things
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1

  -- Misc
  g.omni_sql_no_default_maps = 1
  g.vimsyn_embed = 1

  -- No Recommended Styles
  g.python_recommended_style = 0
  g.rust_recommended_style = 0
end

return M
