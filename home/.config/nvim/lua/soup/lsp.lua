local M = {}

M.config = function()
	do
		local lsp = vim.lsp
		lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
			lsp.diagnostic.on_publish_diagnostics,
			{underline = false, virtual_text = false}
		)
	end

	local caps = vim.lsp.protocol.make_client_capabilities()
	caps.textDocument.completion.completionItem.snippetSupport = true
	caps.textDocument.completion.completionItem.resolveSupport = {
		properties = {'documentation', 'detail', 'additionlTextEdits'}
	}

	local function sym(name, icon)
		vim.fn.sign_define(
			'LspDiagnosticsSign'..name,
			{text = icon, numhl = 'LspDiagnosticsDefaul'..name}
		)
	end

	sym('Error', '')
	sym('Hint', '')
	sym('Information', '')
	sym('Warning', '')

	local function oat(cli, bufnr)
		local map = require'which-key'.register

		map(
			{
				['[d'] = {
					'<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
					'Move to previous LSP diagnostic',
				},
				['[D'] = {
					'<Cmd>lua vim.lsp.buf.document_symbol()<CR>',
					'List LSP symbols',
				},
				[']d'] = {
					'<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
					'Move to next LSP diagnostic',
				},
				[']D'] = {
					'<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
					'List LSP symbols'},
				['<C-]>'] = {
					'<Cmd>lua vim.lsp.buf.definition()<CR>',
					'Jump to LSP definition',
				},
				cr = {'<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename LSP symbol'},
				gD = {
					'<Cmd>lua vim.lsp.buf.type_definition()<CR>',
					'Jump to LSP type definition',
				},
				gI = {
					'<Cmd>lua vim.lsp.buf.implementation()<CR>',
					'List LSP implementations',
				},
				ga = {
					'<Cmd>lua vim.lsp.buf.code_action()<CR>',
					'Select LSP code action',
				},
				gd = {
					'<Cmd>lua vim.lsp.buf.declaration()<CR>',
					'Jump to LSP declaration',
				},
				gr = {'<Cmd>lua vim.lsp.buf.references()<CR>', 'List LSP references'},
				['<C-h>'] = {
					'<Cmd>lua vim.lsp.buf.signature_help()<CR>',
					'Display LSP signature help',
				},
				K = {'<Cmd>lua vim.lsp.buf.hover()<CR>', 'Display LSP hover help'},
				['<C-k>'] = {
					'<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
					'Display LSP line diagnostics',
				},
			},
			{buffer = bufnr}
		)

		if cli.resolved_capabilities.document_formatting then
			map(
				{gF = {'<Cmd>lua vim.lsp.buf.formatting()<CR>', 'LSP formatting'}},
				{buffer = bufnr}
			)
		elseif cli.resolved_capabilities.document_range_formatting then
			map(
				{
					gF = {
						'<Cmd>lua vim.lsp.buf.range_formatting()<CR>',
						'LSP range formatting',
					}
				},
				{buffer = bufnr}
			)
		end
	end

	require'lspinstall'.setup()
	local cfg = require'lspconfig'

	for _, lang in pairs(require'lspinstall'.installed_servers()) do
		if lang == 'lua' then
			local xp = vim.fn.expand
			cfg[lang].setup{
				capabilities = caps,
				on_attach = oat,
				root_dir = vim.loop.cwd,
				settings = {
					Lua = {
						diagnostics = {globals = {'vim'}},
						workspace = {
							library = {
								[xp'$VIMRUNTIME/lua'] = true,
								[xp'$VIMRUNTIME/lua/vim/lsp'] = true,
							}
						},
					},
				},
			}
		elseif lang == 'rust' then
			cfg[lang].setup{
				capabilities = caps,
				on_attach = oat,
				settings = {
					['rust-analyzer'] = {
						assist = {importGranurality = 'module', importPrefix = 'by_self'},
						cargo = {loadOutDirsFromCheck = true},
						procMacro = {enable = true},
					},
				},
			}
		else
			cfg[lang].setup{capabilities = caps, on_attach = oat}
		end
	end
end

return M
