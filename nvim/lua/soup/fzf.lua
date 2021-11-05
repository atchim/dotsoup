local M = {}

--- Configure `telescope.nvim`, the fuzzy finder.
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

  --- Define a mapping to `telescope.nvim` which is equivalent to
  --- `nnoremap <silent> ...`.
  --- @param seq string The key sequence.
  --- @param cmd string The `telescope.nvim` command.
  local function map(seq, cmd)
    vim.api.nvim_set_keymap(
      'n',
      seq,
      '<Cmd>lua require"telescope.builtin".'..cmd..'()<CR>',
      {noremap = true, silent = true}
    )
  end

  map('<Leader>ff', 'find_files')
  map('<Leader>fh', 'help_tags')
  map('<Leader>f<Space>', 'live_grep')
end

return M
