local M = {}

M.config = function()
  -- TODO: Specify better mappings.
  require'nvim-tree'.setup{
    diagnostics = {enable = true},
  }

  require'sopa.tree'.hi()

  -- TODO: Maybe register default mappings.
  require'which-key'.register({
    ['<Space>'] = {
      name = 'Tree',
      ['<Space>'] = {'<Cmd>NvimTreeToggle<CR>', 'Toggle Tree'},
      ['<CR>'] = {'<Cmd>NvimTreeFocus<CR>', 'Focus Tree'},
    },
  }, {prefix = '<Leader>'})
end

return M
