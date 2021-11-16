--- Configurations for the LSP.
local M = {}

--- Configure LSP.
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

--- Setup LSP to the buffer on attachment.
--- @param client table The LSP client.
--- @param bufnr number The buffer number.
M.oat = function(client, bufnr)
  --- Define a LSP mapping to a buffer equivalent to `nnoremap <silent> ...`.
  --- @param seq string The key sequence.
  --- @param cmd string The LSP command to call.
  local function map(seq, cmd)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      seq,
      '<Cmd>lua vim.lsp.'..cmd..'()<CR>',
      {noremap = true, silent = true}
    )
  end

  -- General Mappings
  map('cr', 'buf.rename')
  map('ga', 'buf.code_action')
  map('gd', 'buf.declaration')
  map('gD', 'buf.type_definition')
  map('gI', 'buf.implementation')
  map('gr', 'buf.references')
  map('<C-h>', 'buf.signature_help')
  map('<C-k>', 'diagnostic.show_line_diagnostics')
  map('K', 'buf.hover')

  -- Square Brackets Mappings
  map('[d', 'diagnostic.goto_prev')
  map(']d', 'diagnostic.goto_next')
  map(']q', 'buf.document_symbol')
  map(']w', 'buf.workspace_symbol')
  map('<C-]>', 'buf.definition')

  -- Formatting Mappings
  if client.resolved_capabilities.document_formatting then
    map('<Leader>lf', 'buf.formatting')
  elseif client.resolved_capabilities.document_range_formatting then
    map('<Leader>lf', 'buf.range_formatting')
  end
end

return M
