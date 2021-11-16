--- Configurations for the `packer.nvim` plugin.
local M = {}

--- Startup `packer.nvim`.
M.init = function()
  require'packer'.startup{{
    'atchim/sopa.nvim',
    {'akinsho/bufferline.nvim', config = require'soup.bufferline'.config},
    {'baskerville/vim-sxhkdrc', ft = 'sxhkdrc'},
    'editorconfig/editorconfig-vim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    {'hrsh7th/cmp-nvim-lua', ft = 'lua'},
    'hrsh7th/cmp-path',
    {'hrsh7th/nvim-cmp', config = require'soup.cmp'.config},
    'kabouzeid/nvim-lspinstall',
    {'kyazdani42/nvim-tree.lua', config = require'soup.tree'.config},
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
    'saadparwaiz1/cmp_luasnip',
    {'terrortylor/nvim-comment', config = require'soup.comment'.config},
    {'ThePrimeagen/harpoon', config = require'soup.harpoon'.config},
    'tpope/vim-surround',
    'wbthomason/packer.nvim',
  }, {}}
end

return M
