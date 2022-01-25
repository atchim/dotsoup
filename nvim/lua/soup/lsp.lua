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

  require'nvim-lsp-installer'.on_server_ready(function(server)
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps = require'cmp_nvim_lsp'.update_capabilities(caps)

    local opts = {
      capabilities = caps,
      on_attach = require'soup.lsp'.oat,
    }

    if server.name == 'rust_analyzer' then
      opts.settings = {
        ['rust-analyzer'] = {
          assist = {importGranurality = 'module', importPrefix = 'by_self'},
          cargo = {loadOutDirsFromCheck = true},
          procMacro = {enable = true},
        },
      }
    elseif server.name == 'sumneko_lua' then
      opts.root_dir = vim.loop.cwd
      opts.settings = {
        Lua = {
          diagnostics = {globals = {'vim'}},
          workspace = {
            library = {
              [vim.fn.expand'$VIMRUNTIME/lua'] = true,
              [vim.fn.expand'$VIMRUNTIME/lua/vim/lsp'] = true,
            }
          },
        },
      }
    end

    server:setup(opts)
  end)
end

M.oat = function(client, bufnr)
  local wk_reg = require'which-key'.register

  wk_reg({
    ['<C-]>'] = {
      '<Cmd>lua vim.lsp.buf.definition()<CR>',
      'LSP go to symbol definition',
    },
    cr = {'<Cmd>lua vim.lsp.buf.rename()<CR>', 'LSP symbol rename'},
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
    K = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'LSP hover information'},
    ['<Leader>l'] = {
      name = 'LSP',
      s = {
        name = 'LSP symbols',
        q = {
          '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
          'LSP list workspace symbol',
        },
        s = {
          '<Cmd>lua vim.lsp.buf.document_symbol()<CR>',
          'LSP list document symbol',
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
