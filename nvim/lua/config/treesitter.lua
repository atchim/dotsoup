local M = {}

M.setup = function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_decremental = "grm",
        node_incremental = "grn",
        scope_incremental = "grc",
      },
    },
  }

  local a = vim.api
  a.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  a.nvim_command('set foldmethod=expr')
end

return M
