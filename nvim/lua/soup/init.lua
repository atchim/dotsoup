local M = {}

M.setup = function()
  require'soup.opts'.setup()
  require'soup.vars'.setup()
  require'soup.pack'.setup()
  require'soup.auto'.setup()
  require'soup.maps'.setup()
end

return M
