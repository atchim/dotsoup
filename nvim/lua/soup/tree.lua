local M = {}

M.config = function()
  require'nvim-tree'.setup{}

  require'which-key'.register({
    ['<Space>'] = {
      name = 'Tree',
      c = {'<Cmd>NvimTreeClose<CR>', 'Close Tree'},
      ['<Space>'] = {'<Cmd>NvimTreeToggle<CR>', 'Toggle Tree'},
      ['<CR>'] = {'<Cmd>NvimTreeFocus<CR>', 'Focus Tree'},
    },
  }, {prefix = '<Leader>'})
end

M.setup = function()
  --vim.g.nvim_tree_quit_on_open = 1
end

return M
