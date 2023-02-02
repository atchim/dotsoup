local function config()
  local function on_attach(_, bufnr)
    local map_21 = require("soup.map")
    map_21({["<C-H>"] = {"<Cmd>lua vim.lsp.buf.signature_help()<CR>", "LSP signature help"}, ["<C-]>"] = {"<Cmd>lua vim.lsp.buf.definition()<CR>", "LSP go to symbol definition"}, ["<Leader>l"] = {name = "LSP", f = {"<Cmd>lua vim.lsp.buf.format()<CR>", "Format"}, s = {"<Cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbols"}, S = {"<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace symbols"}}, cr = {"<Cmd>lua vim.lsp.buf.rename()<CR>", "LSP symbol rename"}, gd = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "LSP symbol declaration"}, gD = {"<Cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP type definition"}, gm = {"<Cmd>lua vim.lsp.buf.implementation()<CR>", "LSP implementations"}, go = {"<Cmd>lua vim.lsp.buf.code_action()<CR>", "LSP code action"}, gr = {"<Cmd>lua vim.lsp.buf.references()<CR>", "LSP references"}, K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "LSP hover information"}}, {buffer = bufnr})
    return map_21({name = "LSP", f = {"<Cmd>lua vim.lsp.buf.format()<CR>", "Format"}}, {buffer = bufnr, mode = "v", prefix = "<Leader>l"})
  end
  local capabilities = (require("cmp_nvim_lsp")).default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local function _1_()
    return ((require("lspconfig")).sumneko_lua).setup({capabilities = capabilities, on_attach = on_attach, settings = {Lua = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}}}})
  end
  local function _2_(server)
    return ((require("lspconfig"))[server]).setup({capabilities = capabilities, on_attach = on_attach})
  end
  return (require("mason-lspconfig")).setup_handlers({sumneko_lua = _1_, _2_})
end
local lazy_spec = {{event = "BufRead", config = config, dependencies = {config = true, dependencies = {cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog"}, config = true, "williamboman/mason.nvim"}, "williamboman/mason-lspconfig.nvim"}, "neovim/nvim-lspconfig"}, {event = "LspAttach", opts = {text = {spinner = "dots"}}, config = true, "j-hui/fidget.nvim"}}
local function setup()
  do
    local g = vim.g
    g.python_recommended_style = 0
    g.rust_recommended_style = 0
  end
  do
    local signs = {DiagnosticSignError = "\239\129\151", DiagnosticSignWarn = "\239\129\177", DiagnosticSignHint = "\239\160\180", DiagnosticSignInfo = "\239\159\187"}
    for sign, symbol in pairs(signs) do
      vim.fn.sign_define(sign, {numhl = "", text = symbol, texthl = sign})
    end
  end
  vim.diagnostic.config({update_in_insert = true, virtual_text = {spacing = 1}})
  require("soup.map")({["[d"] = {"<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic go to previous"}, ["]d"] = {"<Cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic go to next"}, ["<Leader>k"] = {"<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic show from line"}})
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {setup = setup}
