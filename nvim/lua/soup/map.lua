local M = {}

--- Define key mappings.
M.init = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}

  -- Buffer
  map('n', 'gb', '<Cmd>SoupBufGoto<CR>', opts)
  map('n', '[b', '<Cmd>SoupBufPrev<CR>', opts)
  map('n', ']b', '<Cmd>SoupBufNext<CR>', opts)

  -- Misc
  map('n', '<Leader>,', '<Cmd>setl spell!<CR>', opts)
  map('n', '<Leader>.', '<Cmd>setl list!<CR>', opts)
  map('n', '<Leader>/', '<Cmd>noh<CR>', opts)

  -- Tab
  map('n', '[t', '<Cmd>SoupTabPrev<CR>', opts)
  map('n', ']t', '<Cmd>SoupTabNext<CR>', opts)

  -- Quickfix
  map('n', '<Leader>cc', '<Cmd>copen<CR>', opts)
  map('n', '<Leader>cn', '<Cmd>cnext<CR>', opts)
  map('n', '<Leader>cp', '<Cmd>cprevious<CR>', opts)
  map('n', '<Leader>cq', '<Cmd>cclose<CR>', opts)

  -- Yank
  map('v', '<Leader>y', '"+y', opts)
end

return M
