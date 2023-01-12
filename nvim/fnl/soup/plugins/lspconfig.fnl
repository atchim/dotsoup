(import-macros {: modcall : modget} :soupmacs.soupmacs)
(local M {})

(fn M.on_attach [client bufnr]
  "On-attach configurations."
  (let [{: map} (require :soup.core.maps)]
    (map
      { :<C-H>
        ["<Cmd>lua vim.lsp.buf.signature_help()<CR>" "LSP signature help"]
        "<C-]>"
        ["<Cmd>lua vim.lsp.buf.definition()<CR>" "LSP go to symbol definition"]
        :<Leader>l
        { :name :LSP
          :f ["<Cmd>lua vim.lsp.buf.format()<CR>" "Format"]
          :s ["<Cmd>lua vim.lsp.buf.document_symbol()<CR>" "Document symbols"]
          :S
          ["<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>" "Workspace symbols"]}
        :cr ["<Cmd>lua vim.lsp.buf.rename()<CR>" "LSP symbol rename"]
        :gd ["<Cmd>lua vim.lsp.buf.declaration()<CR>" "LSP symbol declaration"]
        :gD
        ["<Cmd>lua vim.lsp.buf.type_definition()<CR>" "LSP type definition"]
        :gm ["<Cmd>lua vim.lsp.buf.implementation()<CR>" "LSP implementations"]
        :go ["<Cmd>lua vim.lsp.buf.code_action()<CR>" "LSP code action"]
        :gr ["<Cmd>lua vim.lsp.buf.references()<CR>" "LSP references"]
        :K ["<Cmd>lua vim.lsp.buf.hover()<CR>" "LSP hover information"]}
      {:buffer bufnr})
    (map
      {:name :LSP :f ["<Cmd>lua vim.lsp.buf.format()<CR>" "Format"]}
      {:buffer bufnr :mode :v :prefix :<Leader>l})))

(fn M.config []
  "Post-load configuration hook."
  (fn on-server-ready [server]
    (local opts
      { :capabilities
        (let [caps (vim.lsp.protocol.make_client_capabilities)]
          (modcall :cmp_nvim_lsp :default_capabilities caps))
        :on_attach (modget :soup.plugins.lspconfig :on_attach)})
    (match server.name
      :rust-analyzer
      (set opts.settings
        { :rust-analyzer
          { :assist {:importGranurality :module :importPrefix :by_self}
            :cargo {:loadOutDirsFromCheck true}
            :procMacro {:enable true}}})
      :sumneko_lua
      (do
        (set opts.root_dir vim.loop.cwd)
        (set opts.settings
          { :Lua
            { :diagnostics {:globals [:vim]}
              :workspace
              {:library (vim.api.nvim_get_runtime_file "" true)}}})))
    (server:setup opts))
  (modcall :nvim-lsp-installer :on_server_ready on-server-ready))

M
