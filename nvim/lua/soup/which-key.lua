local M = {}

M.config = function()
  require'which-key'.setup{}
  local map = require'soup.which-key'
  map.vanilla_doc()
  map.hack_doc()
end

M.hack_doc = function()
  require'which-key'.register({
    ['[b'] = 'Go to previous buffer',
    ['[t'] = 'Go to previous tab',
    [']b'] = 'Go to next buffer',
    [']t'] = 'Go to next tab',
    gb = 'Go to buffer',
  }, {})
end

M.vanilla_doc = function()
  local map = require'which-key'.register

  map({
    ['<Leader>'] = {
      [','] = 'Toggle local spelling',
      ['.'] = 'Toggle local listing',
      ['/'] = 'Toggle search highlighting',
      k = 'Diagnostic show from line',
      t = {name = 'Misc tools'},
    },
    ['[d'] = 'Diagnostic go to previous',
    [']d'] = 'Diagnostic go to next',
  }, {})

  map({
    y = 'CTRL-C-like yank to clipboard',
  }, {mode = 'v', prefix = '<Leader>'})
end

return M
