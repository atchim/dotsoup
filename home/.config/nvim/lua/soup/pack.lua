local function setup()
	do
		local fn = vim.fn
		local p = fn.stdpath'data'..'/site/pack/packer/start/packer.nvim'
		if fn.empty(fn.glob(p)) > 0 then
			fn.system{'git', 'clone', 'https://github.com/wbthomason/packer.nvim', p}
		end
	end

	require'packer'.startup{
		{
			'atchim/underworld.vim',
			'baskerville/vim-sxhkdrc',
			'folke/which-key.nvim',
			{'hrsh7th/nvim-compe', config = require'soup.comp'.config},
			{
				'neovim/nvim-lspconfig',
				config = require'soup.lsp'.config,
				requires = 'kabouzeid/nvim-lspinstall',
			},
			{
				'nvim-treesitter/nvim-treesitter',
				config = require'soup.sitter'.config,
				run = ':TSUpdate',
			},
			{'preservim/nerdtree', config = require'soup.tree'.config},
			'ryanoasis/vim-devicons',
			'tpope/vim-commentary',
			'tpope/vim-surround',
			'wbthomason/packer.nvim',
		},
		{},
	}
end

return {setup = setup}
