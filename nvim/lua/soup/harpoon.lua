local M = {}

--- Configure `harpoon`.
M.config = function()
  require'harpoon'.setup{
    global_settings = {
      enter_on_sendcmd = true,
    },
  }

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

  -- File Navigation
  map('<Leader>j0', 'ui', 'nav_file(10)')
  map('<Leader>j1', 'ui', 'nav_file(1)')
  map('<Leader>j2', 'ui', 'nav_file(2)')
  map('<Leader>j3', 'ui', 'nav_file(3)')
  map('<Leader>j4', 'ui', 'nav_file(4)')
  map('<Leader>j5', 'ui', 'nav_file(5)')
  map('<Leader>j6', 'ui', 'nav_file(6)')
  map('<Leader>j7', 'ui', 'nav_file(7)')
  map('<Leader>j8', 'ui', 'nav_file(8)')
  map('<Leader>j9', 'ui', 'nav_file(9)')
  map('<Leader>ja', 'mark', 'add_file()')
  map('<Leader>jj', 'ui', 'toggle_quick_menu()')

  -- Terminal Stuff
  map('<Leader>jc0', 'term', 'sendCommand(1, 10)')
  map('<Leader>jc1', 'term', 'sendCommand(1, 1)')
  map('<Leader>jc2', 'term', 'sendCommand(1, 2)')
  map('<Leader>jc3', 'term', 'sendCommand(1, 3)')
  map('<Leader>jc4', 'term', 'sendCommand(1, 4)')
  map('<Leader>jc5', 'term', 'sendCommand(1, 5)')
  map('<Leader>jc6', 'term', 'sendCommand(1, 6)')
  map('<Leader>jc7', 'term', 'sendCommand(1, 7)')
  map('<Leader>jc8', 'term', 'sendCommand(1, 8)')
  map('<Leader>jc9', 'term', 'sendCommand(1, 9)')
  map('<Leader>jcc', 'cmd-ui', 'toggle_quick_menu()')
  map('<Leader>jt', 'term', 'gotoTerminal(1)')
end

return M
