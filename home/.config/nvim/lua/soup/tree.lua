local function config()
	local g = vim.g
	g.NERDTreeQuitOnOpen = 1
	g.NERDTreeMinimalUI = 1
	g.NERDTreeMinimalMenu = 1

	require'which-key'.register(
		{
			['<Space>'] = {
				name = 'tree',
				['<CR>'] = {'<Cmd>NERDTreeFocus<CR>', 'Focus'},
				['<Space>'] = {'<Cmd>NERDTreeToggle<CR>', 'Toggle'},
				c = {'<Cmd>NERDTreeClose<CR>', 'Close'},
			}
		},
		{prefix = '<Leader>'}
	)
end

return {config = config}
