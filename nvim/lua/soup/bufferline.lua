local M = {}

M.config = function()
  require'bufferline'.setup{
    highlights = require'sopa.bufferline'.groups,
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local levels = {error = '', hint = '', info = '', warning = ''}
        return ' '..levels[level]..' '..count
      end,
      numbers = function(opts) return string.format('%s ', opts.id) end,
      separator_style = {'', ''},
    },
  }
end

return M
