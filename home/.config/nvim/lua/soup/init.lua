local function startup()
	require'soup.opts'.setup()
	require'soup.vars'.setup()
	require'soup.maps'.setup()
	require'soup.pack'.setup()
end

return {startup = startup}
