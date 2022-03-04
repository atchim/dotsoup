local M = {}

M.config = function()
  require'which-key'.setup{}
  local soup_whichkey = require'soup.which-key'
  soup_whichkey.vanilla_doc()
  soup_whichkey.hack_doc()
end

M.hack_doc = function()
  require'which-key'.register({
    ['[b'] = 'Go to previous buffer',
    [']b'] = 'Go to next buffer',
    gb = 'Go to buffer',
    ['[t'] = 'Go to previous tab',
    [']t'] = 'Go to next tab',
  }, {})
end

M.vanilla_doc = function()
  local map = require'which-key'.register

  map({
    ['[d'] = 'Diagnostic go to previous',
    [']d'] = 'Diagnostic go to next',
    ['<Leader>'] = {
      k = 'Diagnostic show from line',
      [','] = 'Toggle local spelling',
      ['.'] = 'Toggle local listing',
      ['/'] = 'Toggle search highlighting',
    },
  }, {})

  map({
    y = 'CTRL-C-like yank to clipboard',
  }, {mode = 'v', prefix = '<Leader>'})
end

return M
