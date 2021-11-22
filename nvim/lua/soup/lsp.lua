local M = {}

M.config = function()
  -- Set how diagnostics will be shown in the screen.
  local lsp = vim.lsp
  lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics,
    {underline = false, virtual_text = false}
  )

  local function set_sign(name, icon)
    vim.fn.sign_define(
      'LspDiagnosticsSign'..name,
      {text = icon, numhl = 'LspDiagnosticsDefaul'..name}
    )
  end

  -- Set LSP signs.
  set_sign('Error', '')
  set_sign('Hint', '')
  set_sign('Information', '')
  set_sign('Warning', '')

  local caps = vim.lsp.protocol.make_client_capabilities()
  caps = require'cmp_nvim_lsp'.update_capabilities(caps)

  local cfg = {
    {capabilities = caps, on_attach = require'soup.lsp'.oat},

    lua = {
      capabilities = caps,
      on_attach = require'soup.lsp'.oat,
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
      on_attach = require'soup.lsp'.oat,
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

  -- NOTE: Now `lsp` is another thing...
  lsp = require'lspconfig'

  ins.setup()

  for _, lang in pairs(ins.installed_servers()) do
    if cfg[lang] then lsp[lang].setup(cfg[lang])
    else lsp[lang].setup(cfg[1])
    end
  end
end

M.oat = function(client, bufnr)
  local wk_reg = require'which-key'.register

  wk_reg({
    ['<C-]>'] = {
      '<Cmd>lua vim.lsp.buf.definition()<CR>',
      'LSP go to symbol definition',
    },
    cr = {'<Cmd>lua vim.lsp.buf.rename()<CR>', 'LSP symbol rename'},
    ['[d'] = {
      '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
      'LSP go to previous diagnostic',
    },
    [']d'] = {
      '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
      'LSP go to next diagnostic',
    },
    ga = {'<Cmd>lua vim.lsp.buf.code_action()<CR>', 'LSP code action'},
    gd = {'<Cmd>lua vim.lsp.buf.declaration()<CR>', 'LSP symbol declaration'},
    gD = {'<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'LSP type definition'},
    gI = {
      '<Cmd>lua vim.lsp.buf.implementation()<CR>',
      'LSP list implementations',
    },
    gr = {'<Cmd>lua vim.lsp.buf.references()<CR>', 'LSP list references'},
    ['<C-h>'] = {
      '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
      'LSP signature help',
    },
    ['<C-k>'] = {
      '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
      'LSP show line diagnostics',
    },
    K = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'LSP hover information'},
    ['<Leader>l'] = {
      name = 'LSP',
      s = {
        name = 'LSP symbols',
        s = {
          '<Cmd>lua vim.lsp.buf.document_symbol()<CR>',
          'LSP list document symbol',
        },
        w = {
          '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
          'LSP list workspace symbol',
        },
      },
    },
  }, {buffer = bufnr})

  -- Formatting Mappings
  if client.resolved_capabilities.document_formatting then
    wk_reg({
      f = {'<Cmd>lua vim.lsp.buf.formatting()<CR>', 'LSP formatting'},
    }, {buffer = bufnr, prefix = '<Leader>l'})
  elseif client.resolved_capabilities.document_range_formatting then
    wk_reg({
      f = {
        '<Cmd>lua vim.lsp.buf.rage_formatting()<CR>',
        'LSP range formatting',
      },
    }, {buffer = bufnr, mode = 'v', prefix = '<Leader>l'})
  end
end

return M
