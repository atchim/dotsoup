local function config()
	require'nvim-treesitter.configs'.setup{highlight = {enable = true}}
	local cmd = vim.cmd
	cmd'set foldexpr=nvim_treesitter#foldexpr()'
	cmd'set foldmethod=expr'
end

return {config = config}
