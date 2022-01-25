local M = {}

M.setup = function()
  require'packer'.startup{{
    'atchim/sopa.nvim',
    {'akinsho/bufferline.nvim', config = require'soup.bufferline'.config},
    {'baskerville/vim-sxhkdrc', ft = 'sxhkdrc'},
    'editorconfig/editorconfig-vim',
    {'folke/which-key.nvim', config = require'soup.which-key'.config},
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    {'hrsh7th/cmp-nvim-lua', ft = 'lua'},
    'hrsh7th/cmp-path',
    {'hrsh7th/nvim-cmp', config = require'soup.cmp'.config},
    {
      'kyazdani42/nvim-tree.lua',
      config = require'soup.tree'.config,
      setup = require'soup.tree'.setup,
    },
    'kyazdani42/nvim-web-devicons',
    'L3MON4D3/LuaSnip',
    {'neovim/nvim-lspconfig', config = require'soup.lsp'.config},
    'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope.nvim', config = require'soup.telescope'.config},
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    {
      'nvim-treesitter/nvim-treesitter',
      config = require'soup.treesitter'.config,
    },
    'rafamadriz/friendly-snippets',
    {'rebelot/heirline.nvim', config = require'soup.heirline'.config},
    'saadparwaiz1/cmp_luasnip',
    {'terrortylor/nvim-comment', config = require'soup.comment'.config},
    {'ThePrimeagen/harpoon', config = require'soup.harpoon'.config},
    'tpope/vim-surround',
    'wbthomason/packer.nvim',
    'williamboman/nvim-lsp-installer',
  }, config = {}}
end

return M
