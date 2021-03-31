local M = {}

local on_attach = function(client)
  require'completion'.on_attach(client)
end

M.setup = function()
  local lsp = require'lspconfig'

  lsp.bashls.setup {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh' },
    on_attach = on_attach,
  }

  lsp.clangd.setup {}

  lsp.pyls.setup {
    cmd = { 'pyls' },
    filetypes = { 'python' },
    on_attach = on_attach,
  }

  lsp.rls.setup {
    cmd = { 'rustup', 'run', 'nightly', 'rls' },
    on_attach = on_attach,

    settings = {
      rust = {
        unstable_features = true,
        all_features = true,
      },
    },
  }

  local sys
  local sumneko_lua_dir = vim.fn.expand('$SUMNEKO_LUA_DIR')

  if vim.fn.has('mac') == 1 then
    sys = 'macOS'
  elseif vim.fn.has('unix') == 1 then
    sys = 'Linux'
  elseif vim.fn.has('win32') == 1 then
    sys = 'Windows'
  end

  lsp.sumneko_lua.setup {
    cmd = {
      sumneko_lua_dir .. '/bin/' .. sys .. '/lua-language-server',
      '-E',
      sumneko_lua_dir .. '/main.lua',
    },

    on_attach = on_attach,

    settings = {
      Lua = {
        completion = { keywordSnippet = 'Disable' },

        diagnostics = {
          enable = true,
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
        },

        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';')
        },

        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        }
      }
    }
  }

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,

    {
      underline = true,
      update_in_insert = true,

      signs = function(bufnr, _)
        local ok, res = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
        if not ok then return true end
        return res
      end,

      virtual_text = {
        prefix = '~',
        spacing = 2,
      },
    }
  )

  local kmap = vim.api.nvim_set_keymap
  kmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
  kmap('n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
  kmap('n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true })
  kmap('n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
  kmap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
end

return M
