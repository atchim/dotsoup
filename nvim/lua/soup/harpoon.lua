local M = {}

M.config = function()
  require'harpoon'.setup{
    global_settings = {
      enter_on_sendcmd = true,
    },
  }

  local term = 'term'
  if vim.fn.exists'$TMUX' then
    term = 'tmux'
  end

  local function cmd(i)
    return {
      '<Cmd>lua require"harpoon.'..term..'".sendCommand(1, '..i..')<CR>',
      'Harpoon send command #'..i,
    }
  end

  local function go_to(i)
    return {
      '<Cmd>lua require"harpoon.ui".nav_file('..i..')<CR>',
      'Harpoon go to entry #'..i,
    }
  end

  require'which-key'.register({
    j = {
      name = 'Harpoon',
      ['0'] = go_to(10),
      ['1'] = go_to(1),
      ['2'] = go_to(2),
      ['3'] = go_to(3),
      ['4'] = go_to(4),
      ['5'] = go_to(5),
      ['6'] = go_to(6),
      ['7'] = go_to(7),
      ['8'] = go_to(8),
      ['9'] = go_to(9),
      a = {
        '<Cmd>lua require"harpoon.mark".add_file()<CR>',
        'Harpoon push current file',
      },
      j = {
        '<Cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>',
        'Harpoon toggle quick menu',
      },
      t = {
        '<Cmd>lua require"harpoon.'..term..'".gotoTerminal(1)<CR>',
        'Harpoon go to terminal',
      },
      c = {
        name = "Harpoon's commands",
        ['0'] = cmd(10),
        ['1'] = cmd(1),
        ['2'] = cmd(2),
        ['3'] = cmd(3),
        ['4'] = cmd(4),
        ['5'] = cmd(5),
        ['6'] = cmd(6),
        ['7'] = cmd(7),
        ['8'] = cmd(8),
        ['9'] = cmd(9),
        c = {
          '<Cmd>lua require"harpoon.cmd-ui".toggle_quick_menu()<CR>',
          'Harpoon toggle command quick menu',
        }
      },
    },
  }, {prefix = '<Leader>'})
end

return M
