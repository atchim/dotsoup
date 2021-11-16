--- Configurations for the `telescope.nvim` plugin.
local M = {}

--- Configure `telescope.nvim`.
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

  local opts = {noremap = true, silent = true}
  local map = require'soup.map'.lua_wrapper('n', opts)

  map('<Leader>ff', 'telescope.builtin', 'find_files()')
  map('<Leader>fg', 'telescope.builtin', 'live_grep()')
  map('<Leader>fh', 'telescope.builtin', 'help_tags()')
end

return M
