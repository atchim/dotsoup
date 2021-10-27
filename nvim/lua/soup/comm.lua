local M = {}

M.config = function()
  require'nvim_comment'.setup{
    marker_padding = false,
  }
end

return M
