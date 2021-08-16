local function setup()
	require'which-key'.register(
		{
			['.'] = {':setlocal list!<CR>', "Locally toggle 'list'"},
			['/'] = {':noh<CR>', "Disable 'hlsearch'"},
		},
		{prefix = '<Leader>'}
	)
end

return {setup = setup}
