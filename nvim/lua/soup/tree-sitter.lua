local M = {}

--- Configure `nvim-treesitter`.
M.config = function()
  -- Enable highlighting with `nvim-treesitter`.
  require'nvim-treesitter.configs'.setup{highlight = {enable = true}}

  -- Fold with `nvim-treesitter`.
  local cmd = vim.cmd
  cmd'set foldexpr=nvim_treesitter#foldexpr()'
  cmd'set foldmethod=expr'
end

return M