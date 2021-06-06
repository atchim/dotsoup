local function setup()
  vim.cmd('packadd packer.nvim')

  require('packer').startup({
    {
      {'~/repo/underworld.vim'},
      {'baskerville/vim-sxhkdrc'},
      {'folke/which-key.nvim'},
      {'glacambre/firenvim', run = 'firenvim#install(0)'},
      {'hrsh7th/nvim-compe', config = require('dotsoup.compe').config},
      {'neovim/nvim-lspconfig', config = require('dotsoup.lsp').config},
      {'nvim-lua/plenary.nvim', opt = true},
      {'nvim-lua/popup.nvim', opt = true},
      {
        'nvim-telescope/telescope.nvim',
        config = require('dotsoup.telescope').config,
      },
      {
        'nvim-treesitter/nvim-treesitter',
        config = require('dotsoup.tree-sitter').config,
        run = ':TSUpdate',
      },
      {
        'preservim/nerdcommenter',
        config = require('dotsoup.nerdcommenter').config,
        setup = require('dotsoup.nerdcommenter').setup,
      },
      {'preservim/nerdtree', config = require('dotsoup.nerdtree').config},
      {'tpope/vim-surround'},
      {'tzachar/compe-tabnine', opt = true, run = './install.sh'},
      {'wbthomason/packer.nvim', opt = true},
    },
    config = {display = {open_fn = require'packer.util'.float}},
  })
end

return {setup = setup}
