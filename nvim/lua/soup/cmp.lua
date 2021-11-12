local M = {}

--- Configure `nvim-cmp`.
M.config = function()
  local cmp = require'cmp'
  local map = cmp.mapping

  cmp.setup{
    formatting = {
      format = function (entry, vimitem)
        vimitem.kind = string.format(
          '%s %s',
          require'soup.kind'[vimitem.kind],
          vimitem.kind
        )

        vimitem.menu = ({
          buffer = '[BUF]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[Lua]',
        })[entry.source.name]

        return vimitem
      end
    },

    -- TODO: Add mappings for snippet completions.
    mapping = {
      ['<C-d>'] = map.scroll_docs(-4),
      ['<C-f>'] = map.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm{select = true},
      ['<C-Space>'] = map.complete(),
    },

    snippet = {
      expand = function(args) require'luasnip'.lsp_expand(args.body) end,
    },

    sources = {
      {name = 'nvim_lua'},
      {name = 'nvim_lsp'},
      {name = 'luasnip'},
      {name = 'path'},
      {name = 'buffer'},
    },
  }
end

return M
