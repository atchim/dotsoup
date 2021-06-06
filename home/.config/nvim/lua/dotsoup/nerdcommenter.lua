local function config()
  local reg = require('which-key').register

  reg(
    {
      ['c'] = {
        name = 'Comment',
        ['<Space>'] = {'<Plug>NERDCommenterToggle<CR>', 'Toggle'},
        ['c'] = {'<Plug>NERDCommenterComment<CR>', 'Comment'},
      },
    },
    {prefix = '<Leader>'}
  )

  reg(
    {
      ['c'] = {
        name = 'VISUAL comment',
        ['<Space>'] = {'<Plug>NERDCommenterToggle<CR>', 'Toggle'},
        ['c'] = {'<Plug>NERDCommenterComment<CR>', 'Comment'},
      },
    },
    {mode = 'v', prefix = '<Leader>'}
  )
end

local function setup() vim.g.NERDCreateDefaultMappings = 0 end
return {config = config, setup = setup}
