local M = {}

M.setup = function()
  vim.cmd 'packadd packer.nvim'

  require'packer'.startup(
    function()
      use 'atchim/underworld.vim'
      use 'dag/vim-fish'
      use 'kovetskiy/sxhkd-vim'
      use 'neovim/nvim-lspconfig'
      use 'norcalli/nvim-colorizer.lua'
      use 'nvim-lua/completion-nvim'

      use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
      }

      use 'nvim-treesitter/nvim-treesitter'
      use 'scrooloose/nerdcommenter'
      use 'scrooloose/nerdtree'
      use 'tpope/vim-surround'
      use { 'wbthomason/packer.nvim', opt = true }
    end
  )
end

return M
