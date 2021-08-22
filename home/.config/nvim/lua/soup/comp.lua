local M = {}

M.config = function()
	require'compe'.setup{
		source = {
			buffer = {true, kind = '﬘'},
			luasnip = {true, kind = '﬌'},
			nvim_lsp = true,
			path = {true, kind = ''},
		},
	}

	local map = vim.api.nvim_set_keymap
	local opts = {expr = true, noremap = true, silent = true}

	map('i', '<C-Space>', 'compe#complete()', opts)
	map('i', '<CR>', 'compe#confirm("<CR>")', opts)
	map('i', '<C-c>', 'compe#close("<C-c>")', opts)
	map('i', '<C-d>', 'compe#scroll({"delta": 4})', opts)
	map('i', '<C-u>', 'compe#scroll({"delta": -4})', opts)
end

return M
