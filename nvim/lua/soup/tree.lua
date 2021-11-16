--- Configurations for the `nvim-tree` plugin.
local M = {}

--- Configure `nvim-tree`.
M.config = function()
  require'nvim-tree'.setup{}

  local opts = {noremap = true, silent = true}
  local map = require'soup.map'.cmd_wrapper('n', opts)

  map('<Leader><Space>c', 'NvimTreeClose')
  map('<Leader><Space><Space>', 'NvimTreeToggle')
  map('<Leader><Space><CR>', 'NvimTreeFocus')
end

return M
