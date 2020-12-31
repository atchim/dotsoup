local M = {}

M.setup = function()
  require'telescope'.setup {}

  local kmap = vim.api.nvim_set_keymap
  kmap('n', '<Leader>/b', '<cmd>lua require"telescope.builtin".buffers()<cr>', { noremap = true })
  kmap('n', '<Leader>/f', '<cmd>lua require"telescope.builtin".find_files()<cr>', { noremap = true })
  kmap('n', '<Leader>/g', '<cmd>lua require"telescope.builtin".live_grep()<cr>', { noremap = true })
  kmap('n', '<Leader>/h', '<cmd>lua require"telescope.builtin".help_tags()<cr>', { noremap = true })
end

return M
