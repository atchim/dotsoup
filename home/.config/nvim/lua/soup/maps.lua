local M = {}

M.setup = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}

  -- Buffer
  map('n', 'ZX', ':lua require"soup.f".buf_del()<CR>', opts)
  map('n', 'gb', ':lua require"soup.f".buf_goto()<CR>', opts)
  map('n', '[b', ':lua require"soup.f".buf_prev()<CR>', opts)
  map('n', ']b', ':lua require"soup.f".buf_next()<CR>', opts)

  -- Tab
  map('n', 'ZC', ':lua require"soup.f".tab_close()<CR>', opts)
  map('n', '[t', ':lua require"soup.f".tab_prev()<CR>', opts)
  map('n', ']t', ':lua require"soup.f".tab_next()<CR>', opts)
end

return M
