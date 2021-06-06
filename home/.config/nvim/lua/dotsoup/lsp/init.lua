local function caps()
  local caps_ = vim.lsp.protocol.make_client_capabilities()
  caps_.textDocument.completion.completionItem.snippetSupport = true
  caps_.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionlTextEdits'},
  }
  return caps_
end

local function config()
  local lsp = require('lspconfig')
  require('dotsoup.lsp.bashls').setup(lsp)
  require('dotsoup.lsp.clangd').setup(lsp)
  require('dotsoup.lsp.hls').setup(lsp)
  require('dotsoup.lsp.pyls').setup(lsp)
  require('dotsoup.lsp.rls').setup(lsp)
  require('dotsoup.lsp.sumneko-lua').setup(lsp)
end

local function on_attach(_, bufnr)
  require('which-key').register(
    {
      ['<C-k>'] = {
        '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
        'Display LSP signature help',
      },
      ['[d'] = {
        '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
        'Move to previous LSP diagnostic',
      },
      [']d'] = {
        '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
        'Move to next LSP diagnostic',
      },
      gd = {'<Cmd>lua vim.lsp.buf.definition()<CR>', 'Jump to LSP definition'},
      gD = {
        '<Cmd>lua vim.lsp.buf.declaration()<CR>',
        'Jump to LSP declaration',
      },
      gI = {
        '<Cmd>lua vim.lsp.buf.implementation()<CR>',
        'List LSP implementations',
      },
      gr = {'<Cmd>lua vim.lsp.buf.references()<CR>', 'List LSP references'},
      K = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'Display LSP hover help'},
    },
    {buffer = bufnr}
  )
end

return {caps = caps, config = config, on_attach = on_attach}
