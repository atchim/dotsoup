local M = {}

M.setup = function()
  require'soup.vanilla'.setup()
  vim.cmd'colorscheme sopa'
  require'soup.hack'.setup()
  require'soup.packer'.init()
end

return M
