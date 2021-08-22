local M = {}

M.config = function()
	require'bufferline'.setup{
		highlights = require'sopa.buf',
		options = {
			diagnostics = 'nvim_lsp',
			diagnostics_indicator = function(count, level)
				local levels = {error = '', info = '', other = '', warning = ''}
				return ' '..levels[level]..' '..count
			end,
			offsets = {{filetype = 'NvimTree', text = '', padding = 1}},
			separator_style = {'', ''},
		},
	}

	require'which-key'.register(
		{
			['gb'] = {':BufferLinePick<CR>', 'Pick a buffer'},
			['gB'] = {':BufferLinePickClose<CR>', 'Close a buffer'},
			['[b'] = {':BufferLineCyclePrev<CR>', 'Switch to previous buffer'},
			[']b'] = {':BufferLineCycleNext<CR>', 'Switch to next buffer'},
		},
		{}
	)
end

return M
