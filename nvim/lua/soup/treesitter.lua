local M = {}

M.config = function()
  require'nvim-treesitter.configs'.setup{
    highlight = {enable = true},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'gnn',
        scope_incremental = 'gng',
        node_decremental = 'gnm',
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      select = {
        enable = true,
        keymaps = {
          ac = '@class.outer',
          ic = '@class.inner',
          af = '@function.outer',
          ['if'] = '@function.inner',
        },
        lookahead = true,
      },
      swap = {
        enable = true,
        swap_next = {['<C-N>'] = '@parameter.inner'},
        swap_previous = {['<C-M>'] = '@parameter.inner'},
      },
    },
    playground = {enable = true},
  }

  -- Now, map again to set descriptions.
  require'which-key'.register({
    [']m'] = 'Go to next function start',
    [']]'] = 'Go to next class start',
    [']M'] = 'Go to next function end',
    [']['] = 'Go to next class end',
    ['[m'] = 'Go to previous function start',
    ['[]'] = 'Go to previous class start',
    ['[M'] = 'Go to previous function end',
    ['[['] = 'Go to previous class end',
    ['<C-M>'] = 'Swap previous parameter',
    ['<C-N>'] = 'Swap next parameter',
  }, {})

  -- TODO: Set description for new motions.

  -- Fold with `nvim-treesitter`.
  local cmd = vim.cmd
  cmd'set foldexpr=nvim_treesitter#foldexpr()'
  cmd'set foldmethod=expr'

  -- Set highlight groups from `sopa.nvim`.
  require'sopa.treesitter'.hi()
end

return M
