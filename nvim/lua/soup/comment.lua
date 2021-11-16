--- Configurations for the `nvim-comment` plugin.
local M = {}

--- Configure `nvim-comment`.
M.config = function()
  require'nvim_comment'.setup{
    marker_padding = false,
  }
end

return M
