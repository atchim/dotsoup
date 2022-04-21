local function init()
  local g = vim.g
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1
  vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", {noremap = true})
  g.mapleader = " "
  g.omni_sql_no_default_maps = 1
  g.vimsyn_embed = 1
  g.python_recommended_style = 0
  g.rust_recommended_style = 0
  return nil
end
return {init = init}
