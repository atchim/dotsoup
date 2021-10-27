local M = {}

M.setup = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}

  -- Buffer
  map('n', 'dx', ':SoupBufDel<CR>', opts)
  map('n', 'dX', ':SoupBufDel!<CR>', opts)
  map('n', 'gb', ':SoupBufGoto<CR>', opts)
  map('n', '[b', ':SoupBufPrev<CR>', opts)
  map('n', ']b', ':SoupBufNext<CR>', opts)

  -- Misc
  map('n', '].', ':setl list!<CR>', opts)
  map('n', '];', ':noh<CR>', opts)

  -- Tab
  map('n', 'dc', ':SoupTabClose<CR>', opts)
  map('n', '[t', ':SoupTabPrevious<CR>', opts)
  map('n', ']t', ':SoupTabNext<CR>', opts)
end

return M
