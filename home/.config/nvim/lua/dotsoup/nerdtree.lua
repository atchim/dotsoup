local api = vim.api
local g = vim.g

local M = {}

M.setup = function()
  g.NERDTreeDirArrowCollapsible = '-'
  g.NERDTreeDirArrowExpandable = '+'
  g.NERDTreeMininalMenu = 1
  g.NERDTreeMinimalUI = 1
  g.NERDTreeQuitOnOpen = 1

  api.nvim_set_keymap('n', '<Leader><Space>', ':NERDTreeToggle<CR>', { noremap = true })
end

return M
