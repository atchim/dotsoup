local M = {}

M.config = function()
  local cmp = require'cmp'
  local fk = vim.fn.feedkeys
  local map = cmp.mapping
  local pv = vim.fn.pumvisible
  local rep = vim.api.nvim_replace_termcodes
  local snip = require'luasnip'

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
    mapping = {
      ['<C-Space>'] = map.complete(),
      ['<C-d>'] = map.scroll_docs(-4),
      ['<C-e>'] = map.close(),
      ['<C-f>'] = map.scroll_docs(4),
      ['<C-n>'] = map.select_next_item(),
      ['<C-p>'] = map.select_prev_item(),
      ['<CR>'] = map.confirm{
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      ['<S-Tab>'] = function(fb)
        if pv() == 1 then fk(rep('<C-p>', true, true, true), 'n')
        elseif snip.jumpable(-1) then
          fk(rep('<Plug>luasnip-jump-prev', true, true, true), '')
        else fb()
        end
      end,
      ['<Tab>'] = function(fb)
        if pv() == 1 then fk(rep('<C-n>', true, true, true), 'n')
        elseif snip.expand_or_jumpable() then
          fk(rep('<Plug>luasnip-expand-or-jump', true, true, true), '')
        else fb()
        end
      end,
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
