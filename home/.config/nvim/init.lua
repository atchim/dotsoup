local cmd = vim.cmd
cmd'nnoremap <Space> <NOP>'
vim.g.mapleader = ' '
require'soup'.startup()
cmd'colorscheme sopa'
