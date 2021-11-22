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

  require'which-key'.register({
    f = {
      name = 'Telescope',
      b = {
        '<Cmd>lua require"telescope.builtin".buffers()<CR>',
        'Telescope buffers',
      },
      f = {
        '<Cmd>lua require"telescope.builtin".find_files()<CR>',
        'Telescope files',
      },
      g = {
        '<Cmd>lua require"telescope.builtin".live_grep()<CR>',
        'Telescope grep',
      },
      h = {
        '<Cmd>lua require"telescope.builtin".help_tags()<CR>',
        'Telescope help tags',
      },
    },
  }, {prefix = '<Leader>'})
end

return M
