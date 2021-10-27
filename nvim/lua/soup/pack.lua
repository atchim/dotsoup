local M = {}

M.setup = function()
  require'packer'.startup{
    {
      '/home/atchim/repo/sopa.nvim',
      {'akinsho/bufferline.nvim', config = require'soup.buf'.config},
      {'baskerville/vim-sxhkdrc', ft = 'sxhkdrc'},
      'dylanaraps/fff.vim',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      {'hrsh7th/cmp-nvim-lua', ft = 'lua'},
      'hrsh7th/cmp-path',
      {'hrsh7th/nvim-cmp', config = require'soup.cmp'.config},
      'kabouzeid/nvim-lspinstall',
      'kyazdani42/nvim-web-devicons',
      'L3MON4D3/LuaSnip',
      {'neovim/nvim-lspconfig', config = require'soup.lsp'.config},
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope.nvim', config = require'soup.fzf'.config},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      {'nvim-treesitter/nvim-treesitter', config = require'soup.ts'.config},
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
      {'terrortylor/nvim-comment', config = require'soup.comm'.config},
      'tpope/vim-surround',
      'wbthomason/packer.nvim',
    },
    {},
  }
end

return M
