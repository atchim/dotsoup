local M = {}

M.setup = function()
	local devicons = {
		'kyazdani42/nvim-web-devicons',
		as = 'devicons',
		opt = true,
	}

	require'packer'.startup{
		{
			'~/repo/sopa.nvim',
			{
				'akinsho/bufferline.nvim',
				config = require'soup.buf'.config,
				requires = devicons,
				wants = 'devicons',
			},
			'baskerville/bubblegum',
			'baskerville/vim-sxhkdrc',
			'folke/which-key.nvim',
			{
				'hrsh7th/nvim-compe',
				config = require'soup.comp'.config,
				event = "InsertEnter",
				requires = {
					{
						'L3MON4D3/LuaSnip',
						config = require'soup.snip'.config,
						event = 'InsertCharPre',
						wants = 'friendly-snippets',
					},
					{'rafamadriz/friendly-snippets', event = 'InsertCharPre'},
				},
				wants = 'LuaSnip',
			},
			{
				'kyazdani42/nvim-tree.lua',
				config = require'soup.tree'.config,
				requires = devicons,
				wants = 'devicons',
			},
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
			'tpope/vim-surround',
			'wbthomason/packer.nvim',
		},
		{},
	}
end

return M
