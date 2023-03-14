local function setup()
  local g = vim.g
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1
  g.python_recommended_style = 0
  g.rust_recommended_style = 0
  g.omni_sql_no_default_maps = 1
  return nil
end
return {setup = setup}
