local M = {}

M.setup = function()
	require'which-key'.register(
		{
			['.'] = {':setlocal list!<CR>', "Locally toggle 'list'"},
			['/'] = {':noh<CR>', "Disable 'hlsearch'"},
		},
		{prefix = '<Leader>'}
	)
end

return M
