local M = {}

M.setup = function()
  vim.cmd 'packadd packer.nvim'

  require'packer'.startup(function()
    use '~/repo/underworld.vim'
    use 'baskerville/bubblegum'
    use 'baskerville/vim-sxhkdrc'
    use 'neovim/nvim-lspconfig'
    use 'norcalli/nvim-colorizer.lua'
    use 'nvim-lua/completion-nvim'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } },
    }

    use 'nvim-treesitter/nvim-treesitter'
    use 'scrooloose/nerdcommenter'
    use 'scrooloose/nerdtree'
    use 'tpope/vim-surround'
    use { 'wbthomason/packer.nvim', opt = true }
  end)
end

return M
