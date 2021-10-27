local M = {}

M.config = function()
  require'telescope'.setup{
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  }

  require'telescope'.load_extension'fzf'

  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}

  map('n', ']g', '<Cmd>lua require"telescope.builtin".live_grep()<CR>', opts)
  map('n', ']f', '<Cmd>lua require"telescope.builtin".find_files()<CR>', opts)
  map('n', ']h', '<Cmd>lua require"telescope.builtin".help_tags()<CR>', opts)
end

return M
