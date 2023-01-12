local M = {}
M.on_attach = function(client, bufnr)
  local _let_1_ = require("soup.core.maps")
  local map = _let_1_["map"]
  map({["<C-H>"] = {"<Cmd>lua vim.lsp.buf.signature_help()<CR>", "LSP signature help"}, ["<C-]>"] = {"<Cmd>lua vim.lsp.buf.definition()<CR>", "LSP go to symbol definition"}, ["<Leader>l"] = {name = "LSP", f = {"<Cmd>lua vim.lsp.buf.format()<CR>", "Format"}, s = {"<Cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbols"}, S = {"<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace symbols"}}, cr = {"<Cmd>lua vim.lsp.buf.rename()<CR>", "LSP symbol rename"}, gd = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "LSP symbol declaration"}, gD = {"<Cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP type definition"}, gm = {"<Cmd>lua vim.lsp.buf.implementation()<CR>", "LSP implementations"}, go = {"<Cmd>lua vim.lsp.buf.code_action()<CR>", "LSP code action"}, gr = {"<Cmd>lua vim.lsp.buf.references()<CR>", "LSP references"}, K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "LSP hover information"}}, {buffer = bufnr})
  return map({name = "LSP", f = {"<Cmd>lua vim.lsp.buf.format()<CR>", "Format"}}, {buffer = bufnr, mode = "v", prefix = "<Leader>l"})
end
M.config = function()
  local function on_server_ready(server)
    local opts
    local _2_
    do
      local caps = vim.lsp.protocol.make_client_capabilities()
      _2_ = (require("cmp_nvim_lsp")).default_capabilities(caps)
    end
    opts = {capabilities = _2_, on_attach = (require("soup.plugins.lspconfig")).on_attach}
    do
      local _3_ = server.name
      if (_3_ == "rust-analyzer") then
        opts.settings = {["rust-analyzer"] = {assist = {importGranurality = "module", importPrefix = "by_self"}, cargo = {loadOutDirsFromCheck = true}, procMacro = {enable = true}}}
      elseif (_3_ == "sumneko_lua") then
        opts.root_dir = vim.loop.cwd
        opts.settings = {Lua = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true)}}}
      else
      end
    end
    return server:setup(opts)
  end
  return (require("nvim-lsp-installer")).on_server_ready(on_server_ready)
end
return M
