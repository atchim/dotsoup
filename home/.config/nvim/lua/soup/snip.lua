local check_bs = function()
	local col = vim.fn.col'.' - 1
	return col == 0 or vim.fn.getline'.':sub(col, col):match'%s'
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.soup_s_tab_comp = function()
	if vim.fn.pumvisible() == 1 then return t'<C-p>'
	elseif require'luasnip'.jumpable(-1) then return t'<Plug>luasnip-jump-prev'
	else return t'<S-Tab>'
	end
end

_G.soup_tab_comp = function()
	if vim.fn.pumvisible() == 1 then return t'<C-n>'
	elseif require'luasnip'.expand_or_jumpable() then
		return t'<Plug>luasnip-expand-or-jump'
	elseif check_bs() then return t'<Tab>'
	else return vim.fn['compe#complete']()
	end
end

local M = {}

M.config = function()
	local map = vim.api.nvim_set_keymap
	map('i', '<Tab>', 'v:lua.soup_tab_comp()', {expr = true})
	map('s', '<Tab>', 'v:lua.soup_tab_comp()', {expr = true})
	map('i', '<S-Tab>', 'v:lua.soup_s_tab_comp()', {expr = true})
	map('s', '<S-Tab>', 'v:lua.soup_s_tab_comp()', {expr = true})
	map('i', '<C-E>', '<Plug>luasnip-next-choice', {})
	map('s', '<C-E>', '<Plug>luasnip-next-choice', {})
end

return M
