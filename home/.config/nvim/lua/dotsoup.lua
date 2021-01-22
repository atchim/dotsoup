local M = {}

M.setup = function()
  require'dotsoup.lsp'.setup()
  require'dotsoup.nerdtree'.setup()
  require'dotsoup.packer'.setup()
  require'dotsoup.telescope'.setup()
  require'dotsoup.treesitter'.setup()
end

return M
