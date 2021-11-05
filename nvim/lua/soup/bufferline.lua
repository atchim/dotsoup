local M = {}

--- Configure `bufferline.nvim`.
M.config = function()
  require'bufferline'.setup{
    highlights = require'sopa.buf',
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local levels = {error = '', info = '', other = '', warning = ''}
        return ' '..levels[level]..' '..count
      end,
      numbers = function(opts) return string.format('%s ', opts.id) end,
      separator_style = {'', ''},
    },
  }

  vim.api.nvim_set_keymap(
    'n',
    'gb',
    ':BufferLinePick<CR>',
    {noremap = true, silent = true}
  )
end

return M
