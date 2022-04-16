local M = {}

M.config = function()
  require'nvim-treesitter.configs'.setup{
    highlight = {enable = true},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gn',
        node_incremental = 'gn',
        scope_incremental = 'g,',
        node_decremental = 'gm',
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
          af = '@function.outer',
          ic = '@class.inner',
          ['if'] = '@function.inner',
          n = '@node',
        },
        lookahead = true,
      },
      swap = {
        enable = true,
        swap_next = {['<C-N>'] = '@swappable'},
        swap_previous = {['<C-P>'] = '@swappable'},
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
end

return M
