local general = require'config.general'
local lsp = require'config.lsp'
local nerdtree = require'config.nerdtree'
local packer = require'config.packer'
local telescope = require'config.telescope'
local treesitter = require'config.treesitter'

local M = {}

M.general = general
M.lsp = lsp
M.nerdtree = nerdtree
M.packer = packer
M.telescope = telescope
M.treesitter = treesitter

return M
