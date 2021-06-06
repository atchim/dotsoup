local function config()
  local g = vim.g

  g.NERDTreeDirArrowCollapsible = '-'
  g.NERDTreeDirArrowExpandable = '+'
  g.NERDTreeMininalMenu = 1
  g.NERDTreeMinimalUI = 1
  g.NERDTreeQuitOnOpen = 1

  require('which-key').register(
    {
      ['<Space>'] = {
        name = 'NERDTree',
        ['<Space>'] = {'<Cmd>NERDTreeToggle<CR>', 'Toggle'},
        ['<CR>'] = {'<Cmd>NERDTreeFocus<CR>', 'Focus'},
        c = {'<Cmd>NERDTreeClose<CR>', 'Close'},
      },
    },
    {prefix = '<Leader>'}
  )
end

return {config = config}
