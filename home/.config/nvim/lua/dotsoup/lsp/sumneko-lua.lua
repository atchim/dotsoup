local function setup(lsp)
  local fn = vim.fn
  local dir = fn.expand '$SUMNEKO_LUA_DIR'

  lsp.sumneko_lua.setup {
    cmd = {
      fn.glob(dir .. '/bin/*/lua-language-server'),
      '-E',
      dir .. '/main.lua',
    },

    on_attach = require 'dotsoup.lsp'.on_attach,

    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'after_each',
            'before_each',
            'describe',
            'it',
            'vim',
          },
        },

        runtime = { path = vim.split(package.path, ';'), version = 'LuaJIT' },

        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
          },
        },
      }
    },
  }
end

return { setup = setup }
