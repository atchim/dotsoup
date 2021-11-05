local M = {}

--- Define mappings.
M.init = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}

  -- Buffer
  map('n', '[b', ':SoupBufPrev<CR>', opts)
  map('n', ']b', ':SoupBufNext<CR>', opts)

  -- Misc
  map('n', '<Leader>.', ':setl list!<CR>', opts)
  map('n', '<Leader>/', ':noh<CR>', opts)

  -- Tab
  map('n', '[t', ':SoupTabPrev<CR>', opts)
  map('n', ']t', ':SoupTabNext<CR>', opts)
end

return M
