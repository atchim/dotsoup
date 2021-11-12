local M = {}

--- Initiate Soup.
M.init = function()
  -- Set the leader key.
  vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true})
  vim.g.mapleader = ' '

  -- Initiate submodules.
  require'soup.opt'.init()
  require'soup.global'.init()
  require'soup.packer'.init()
  require'soup.autocmd'.init()
  require'soup.cmd'.init()
  require'soup.map'.init()
  require'soup.color'.init()
end

return M
