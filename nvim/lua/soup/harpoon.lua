local M = {}

M.config = function()
  require'harpoon'.setup{
    global_settings = {
      enter_on_sendcmd = true,
    },
  }

  require'which-key'.register({
    j = {
      name = 'Harpoon',
      ['0'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(10)<CR>',
        "Go to 10th entry of the Harpoon's list",
      },
      ['1'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(1)<CR>',
        "Go to 1st entry of the Harpoon's list",
      },
      ['2'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(2)<CR>',
        "Go to 2nd entry of the Harpoon's list",
      },
      ['3'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(3)<CR>',
        "Go to 3rd entry of the Harpoon's list",
      },
      ['4'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(4)<CR>',
        "Go to 4th entry of the Harpoon's list",
      },
      ['5'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(5)<CR>',
        "Go to 5th entry of the Harpoon's list",
      },
      ['6'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(6)<CR>',
        "Go to 6th entry of the Harpoon's list",
      },
      ['7'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(7)<CR>',
        "Go to 7th entry of the Harpoon's list",
      },
      ['8'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(8)<CR>',
        "Go to 8th entry of the Harpoon's list",
      },
      ['9'] = {
        '<Cmd>lua require"harpoon.ui".nav_file(9)<CR>',
        "Go to 9th entry of the Harpoon's list",
      },
      a = {
        '<Cmd>lua require"harpoon.mark".add_file()<CR>',
        "Push current file to the Harpoon's list",
      },
      j = {
        '<Cmd>lua require"harpoon.ui".toggle_quick_menu()<CR>',
        "Togle Harpoon's quick menu",
      },
      t = {
        '<Cmd>lua require"harpoon.term".gotoTerminal(1)<CR>',
        "Go to Harpoon's 1st terminal",
      },
      c = {
        name = "Harpoon's commands",
        ['0'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 10)<CR>',
          "Send 10th entry of the Harpoon's command list",
        },
        ['1'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 1)<CR>',
          "Send 1st entry of the Harpoon's command list",
        },
        ['2'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 2)<CR>',
          "Send 2nd entry of the Harpoon's command list",
        },
        ['3'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 3)<CR>',
          "Send 3rd entry of the Harpoon's command list",
        },
        ['4'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 4)<CR>',
          "Send 4th entry of the Harpoon's command list",
        },
        ['5'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 5)<CR>',
          "Send 5th entry of the Harpoon's command list",
        },
        ['6'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 6)<CR>',
          "Send 6th entry of the Harpoon's command list",
        },
        ['7'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 7)<CR>',
          "Send 7th entry of the Harpoon's command list",
        },
        ['8'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 8)<CR>',
          "Send 8th entry of the Harpoon's command list",
        },
        ['9'] = {
          '<Cmd>lua require"harpoon.term".sendCommand(1, 9)<CR>',
          "Send 9th entry of the Harpoon's command list",
        },
        c = {
          '<Cmd>lua require"harpoon.cmd-ui".toggle_quick_menu()<CR>',
          "Toggle Harpoon's command quick menu list",
        }
      },
    },
  }, {prefix = '<Leader>'})
end

return M
