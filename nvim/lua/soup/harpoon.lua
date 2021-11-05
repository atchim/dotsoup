local M = {}

--- Configure `harpoon`.
M.config = function()
  --- Define a mapping for `harpoon` which is equivalent to
  --- `nnoremap <silent> ...`.
  --- @param seq string The key sequence.
  --- @param mod string The `harpoon` module name.
  --- @param cmd string The command for `harpoon`.
  local function map(seq, mod, cmd)
    vim.api.nvim_set_keymap(
      'n',
      seq,
      '<Cmd>lua require"harpoon.'..mod..'".'..cmd..'<CR>',
      {noremap = true, silent = true}
    )
  end

  map('<Leader>0', 'ui', 'nav_file(10)')
  map('<Leader>1', 'ui', 'nav_file(1)')
  map('<Leader>2', 'ui', 'nav_file(2)')
  map('<Leader>3', 'ui', 'nav_file(3)')
  map('<Leader>4', 'ui', 'nav_file(4)')
  map('<Leader>5', 'ui', 'nav_file(5)')
  map('<Leader>6', 'ui', 'nav_file(6)')
  map('<Leader>7', 'ui', 'nav_file(7)')
  map('<Leader>8', 'ui', 'nav_file(8)')
  map('<Leader>9', 'ui', 'nav_file(9)')
  map('<Leader>jj', 'ui', 'toggle_quick_menu()')
  map('<Leader>j<Space>', 'mark', 'add_file()')
end

return M
