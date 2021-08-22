local M = {}

M.startup = function()
	require'soup.opts'.setup()
	require'soup.vars'.setup()
	require'soup.pack'.setup()
	require'soup.maps'.setup()
end

return M
