local function config()
  require 'compe'.setup {
    source = {
      buffer = true,
      calc = true,
      nvim_lsp = true,
      nvim_lua = true,
      path = true,
    },
  }

  local kmap = vim.api.nvim_set_keymap
  local opts = { expr = true, noremap = true, silent = true }

  kmap('i', '<C-Space>', 'compe#complete()', opts)
  kmap('i', '<CR>', 'compe#confirm("<CR>")', opts)
  kmap('i', '<C-e>', 'compe#close("<C-e>")', opts)
  kmap('i', '<C-f>', 'compe#scroll({ "delta": +4 })', opts)
  kmap('i', '<C-d>', 'compe#scroll({ "delta": -4 })', opts)
end

return { config = config }
