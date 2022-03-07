local M = {}

M.config = function()
  local cmp = require'cmp'
  local map = cmp.mapping

  cmp.setup{
    formatting = {
      format = function (entry, vimitem)
        vimitem.kind = string.format(
          '%s %s',
          require'soup.cmp'.kinds[vimitem.kind],
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
      ['<C-D>'] = map(map.scroll_docs(-4), {'i', 'c'}),
      ['<C-F>'] = map(map.scroll_docs(4), {'i', 'c'}),
      ['<C-Space>'] = map(map.complete(), {'i', 'c'}),
      ['<CR>'] = map.confirm{select = true},
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

M.kinds = {
  Class = 'ﴯ',
  Color = '',
  Constant = '',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = 'ﰠ',
  File = '',
  Folder = '',
  Function = '',
  Interface = '',
  Keyword = '',
  Method = '',
  Module = '',
  Operator = '',
  Property = 'ﰠ',
  Reference = '',
  Snippet = '',
  Struct = 'פּ',
  Text = '',
  TypeParameter = '',
  Unit = '塞',
  Value = '',
  Variable = '',
}

return M
