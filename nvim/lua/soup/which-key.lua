local M = {}

M.config = function()
  require'which-key'.setup{}
  local soup_wk = require'soup.which-key'
  soup_wk.vanilla_doc()
  soup_wk.hack_doc()
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
  local wkreg = require'which-key'.register

  wkreg({
    ['[d'] = 'Diagnostic go to previous',
    [']d'] = 'Diagnostic go to next',
    ['<C-K>'] = 'Diagnostic show from line',
    ['<Leader>'] = {
      [','] = 'Toggle local spelling',
      ['.'] = 'Toggle local listing',
      ['/'] = 'Toggle search highlighting',
    },
  }, {})

  wkreg({
    y = 'CTRL-C-like yank to clipboard',
  }, {mode = 'v', prefix = '<Leader>'})
end

return M
