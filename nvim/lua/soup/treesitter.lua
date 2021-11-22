local M = {}

M.config = function()
  -- Enable highlighting with `nvim-treesitter`.
  require'nvim-treesitter.configs'.setup{highlight = {enable = true}}

  -- Fold with `nvim-treesitter`.
  local cmd = vim.cmd
  cmd'set foldexpr=nvim_treesitter#foldexpr()'
  cmd'set foldmethod=expr'

  -- Set highlight groups from `sopa.nvim`.
  require'sopa.treesitter'.init()
end

return M
