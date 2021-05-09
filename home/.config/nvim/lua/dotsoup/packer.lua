local function setup()
  vim.cmd 'packadd packer.nvim'

  require 'packer'.startup(function()
    use '~/repo/underworld.vim'
    use 'baskerville/vim-sxhkdrc'

    use {
      'folke/which-key.nvim',
      commit = '167661151204ea7da2d365113a76ab223b3dc880',
    }

    use { '/hrsh7th/nvim-compe', config = require 'dotsoup.compe'.config }
    use { 'neovim/nvim-lspconfig', config = require 'dotsoup.lsp'.config }

    use {
      'nvim-telescope/telescope.nvim',
      config = require 'dotsoup.telescope'.config,
      requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } },
    }

    use {
      'nvim-treesitter/nvim-treesitter',
       config = require 'dotsoup.tree-sitter'.config,
       run = ':TSUpdate',
    }

    use {
      'preservim/nerdcommenter',
       config = require 'dotsoup.nerdcommenter'.config,
       setup = require 'dotsoup.nerdcommenter'.setup,
    }

    use { 'preservim/nerdtree', config = require 'dotsoup.nerdtree'.config }
    use { 'wbthomason/packer.nvim', opt = true }
  end)
end

return { setup = setup }
