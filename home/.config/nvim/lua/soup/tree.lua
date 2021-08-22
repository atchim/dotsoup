local M = {}

M.config = function()
	local g = vim.g

	g.nvim_tree_hide_dotfiles = 1
	g.nvim_tree_ignore = {'.git', 'node_modules'}

	require'which-key'.register(
		{
			['<Space>'] = {
				name = 'tree',
				c = {'<Cmd>NvimTreeClose<CR>', 'Close'},
				['<CR>'] = {'<Cmd>NvimTreeFocus<CR>', 'Focus'},
				['<Space>'] = {'<Cmd>NvimTreeToggle<CR>', 'Toggle'},
			},
		},
		{prefix = '<Leader>'}
	)
end

return M
