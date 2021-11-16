--- Configurations for the `harpoon` plugin.
local M = {}

--- Configure `harpoon`.
M.config = function()
  require'harpoon'.setup{
    global_settings = {
      enter_on_sendcmd = true,
    },
  }

  local opts = {noremap = true, silent = true}
  local map = require'soup.map'.lua_wrapper('n', opts)

  -- File Navigation
  map('<Leader>j0', 'harpoon.ui', 'nav_file(10)')
  map('<Leader>j1', 'harpoon.ui', 'nav_file(1)')
  map('<Leader>j2', 'harpoon.ui', 'nav_file(2)')
  map('<Leader>j3', 'harpoon.ui', 'nav_file(3)')
  map('<Leader>j4', 'harpoon.ui', 'nav_file(4)')
  map('<Leader>j5', 'harpoon.ui', 'nav_file(5)')
  map('<Leader>j6', 'harpoon.ui', 'nav_file(6)')
  map('<Leader>j7', 'harpoon.ui', 'nav_file(7)')
  map('<Leader>j8', 'harpoon.ui', 'nav_file(8)')
  map('<Leader>j9', 'harpoon.ui', 'nav_file(9)')
  map('<Leader>ja', 'harpoon.mark', 'add_file()')
  map('<Leader>jj', 'harpoon.ui', 'toggle_quick_menu()')

  -- Terminal Stuff
  map('<Leader>jc0', 'harpoon.term', 'sendCommand(1, 10)')
  map('<Leader>jc1', 'harpoon.term', 'sendCommand(1, 1)')
  map('<Leader>jc2', 'harpoon.term', 'sendCommand(1, 2)')
  map('<Leader>jc3', 'harpoon.term', 'sendCommand(1, 3)')
  map('<Leader>jc4', 'harpoon.term', 'sendCommand(1, 4)')
  map('<Leader>jc5', 'harpoon.term', 'sendCommand(1, 5)')
  map('<Leader>jc6', 'harpoon.term', 'sendCommand(1, 6)')
  map('<Leader>jc7', 'harpoon.term', 'sendCommand(1, 7)')
  map('<Leader>jc8', 'harpoon.term', 'sendCommand(1, 8)')
  map('<Leader>jc9', 'harpoon.term', 'sendCommand(1, 9)')
  map('<Leader>jcc', 'harpoon.cmd-ui', 'toggle_quick_menu()')
  map('<Leader>jt', 'harpoon.term',' gotoTerminal(1)')
end

return M
