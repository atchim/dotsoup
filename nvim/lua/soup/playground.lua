local M = {}

M.config = function()
  require'which-key'.register({
    tt = {'<Cmd>TSPlaygroundToggle<CR>', 'Tree-sitter playground toggle'},
  }, {prefix = '<Leader>'})
end

return M
