local M = {}

M.config = function()
  do
    local lsp = vim.lsp
    lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
      lsp.diagnostic.on_publish_diagnostics,
      {underline = false, virtual_text = false}
    )
  end

  do
    local function defsign(name, icon)
      vim.fn.sign_define(
        'LspDiagnosticsSign'..name,
        {text = icon, numhl = 'LspDiagnosticsDefaul'..name}
      )
    end

    defsign('Error', '')
    defsign('Hint', '')
    defsign('Information', '')
    defsign('Warning', '')
  end

  local caps = vim.lsp.protocol.make_client_capabilities()
  caps = require'cmp_nvim_lsp'.update_capabilities(caps)

  local oat = function(cli, bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local opts = {noremap = true, silent = true}

    map(bufnr, 'n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    map(bufnr, 'n', '[D', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    map(bufnr, 'n', ']D', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map(bufnr, 'n', '[D', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    map(bufnr, 'n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map(bufnr, 'n', 'cr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map(bufnr, 'n', 'gI', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map(bufnr, 'n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    map(bufnr, 'n', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map(
      bufnr,
      'n',
      '<C-k>',
      '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
      opts
    )

    if cli.resolved_capabilities.document_formatting then
      map(bufnr, 'n', 'gF', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif cli.resolved_capabilities.document_range_formatting then
      map(
        bufnr,
        'n',
        'gF',
        '<Cmd>lua vim.lsp.buf.range_formatting()<CR>',
        opts
      )
    end
  end

  local cfg = {
    {capabilities = caps, on_attach = oat},
    lua = {
      capabilities = caps,
      on_attach = oat,
      root_dir = vim.loop.cwd,
      settings = {
        Lua = {
          diagnostics = {globals = {'vim'}},
          workspace = {
            library = {
              [vim.fn.expand'$VIMRUNTIME/lua'] = true,
              [vim.fn.expand'$VIMRUNTIME/lua/vim/lsp'] = true,
            }
          },
        },
      },
    },
    rust = {
      capabilities = caps,
      on_attach = oat,
      settings = {
        ['rust-analyzer'] = {
          assist = {importGranurality = 'module', importPrefix = 'by_self'},
          cargo = {loadOutDirsFromCheck = true},
          procMacro = {enable = true},
        },
      },
    },
  }

  local ins = require'lspinstall'
  local lsp = require'lspconfig'
  ins.setup()
  for _, lang in pairs(ins.installed_servers()) do
    if cfg[lang] then lsp[lang].setup(cfg[lang])
    else lsp[lang].setup(cfg[1])
    end
  end
end

return M
