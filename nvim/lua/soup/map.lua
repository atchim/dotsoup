local M = {}

M.init = function()
  local wk_reg = require'which-key'.register

  wk_reg({
    ['[b'] = {'<Cmd>SoupBufPrev<CR>', 'Go to previous buffer'},
    [']b'] = {'<Cmd>SoupBufNext<CR>', 'Go to next buffer'},
    gb = {'<Cmd>SoupBufGoto<CR>', 'Go to buffer'},
    ['[t'] = {'<Cmd>SoupTabPrev<CR>', 'Go to previous tab'},
    [']t'] = {'<Cmd>SoupTabNext<CR>', 'Go to next tab'},
    ['<Leader>'] = {
      c = {
        name = 'Quickfix',
        ['<Space>'] = {'<Cmd>cclose<CR>', 'Quickfix close'},
        c = {'<Cmd>copen<CR>', 'Quickfix open'},
        j = {'<Cmd>cbelow<CR>', 'Quickfix go to below'},
        k = {'<Cmd>cabove<CR>', 'Quickfix go to above'},
        n = {'<Cmd>cnext<CR>', 'Quickfix go to next'},
        p = {'<Cmd>cprevious<CR>', 'Quickfix go to previous'},
      },
      [','] = {'<Cmd>setlocal spell!<CR>', 'Toggle local spelling'},
      ['.'] = {'<Cmd>setlocal list!<CR>', 'Toggle local listing'},
      ['/'] = {'<Cmd>nohlsearch<CR>', 'Toggle search highlighting'},
    },
  }, {})

  wk_reg({
    y = {'"+y', 'CTRL-C-like yank to clipboard'},
  }, {mode = 'v', prefix = '<Leader>'})
end

return M
