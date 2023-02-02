(import-macros {: modcall : modget} :soupmacs.soupmacs)

(fn config []
  "Post-load configuration hook."

  (fn on_attach [_ bufnr]
    "On-attach configurations."
    (let [map! (require :soup.map)]
      (map!
        { :<C-H>
          ["<Cmd>lua vim.lsp.buf.signature_help()<CR>" "LSP signature help"]
          "<C-]>"
          [ "<Cmd>lua vim.lsp.buf.definition()<CR>"
            "LSP go to symbol definition"]
          :<Leader>l
          { :name :LSP
            :f ["<Cmd>lua vim.lsp.buf.format()<CR>" "Format"]
            :s
            ["<Cmd>lua vim.lsp.buf.document_symbol()<CR>" "Document symbols"]
            :S
            [ "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"
              "Workspace symbols"]}
          :cr ["<Cmd>lua vim.lsp.buf.rename()<CR>" "LSP symbol rename"]
          :gd
          ["<Cmd>lua vim.lsp.buf.declaration()<CR>" "LSP symbol declaration"]
          :gD
          ["<Cmd>lua vim.lsp.buf.type_definition()<CR>" "LSP type definition"]
          :gm
          ["<Cmd>lua vim.lsp.buf.implementation()<CR>" "LSP implementations"]
          :go ["<Cmd>lua vim.lsp.buf.code_action()<CR>" "LSP code action"]
          :gr ["<Cmd>lua vim.lsp.buf.references()<CR>" "LSP references"]
          :K ["<Cmd>lua vim.lsp.buf.hover()<CR>" "LSP hover information"]}
        {:buffer bufnr})
      (map!
        {:name :LSP :f ["<Cmd>lua vim.lsp.buf.format()<CR>" "Format"]}
        {:buffer bufnr :mode :v :prefix :<Leader>l})))

  (let
    [ capabilities
      (modcall :cmp_nvim_lsp :default_capabilities
        (vim.lsp.protocol.make_client_capabilities))]
    (modcall :mason-lspconfig :setup_handlers
      { 1
        (fn [server]
          (modcall :lspconfig server :setup {: capabilities : on_attach}))
        :sumneko_lua
        (fn []
          (modcall :lspconfig :sumneko_lua :setup
            { : capabilities
              : on_attach
              :settings
              { :Lua
                { :diagnostics {:globals [:vim]}
                  :workspace
                  { :library (vim.api.nvim_get_runtime_file "" true)
                    :checkThirdParty false}}}}))})))

(local lazy-spec
  [ { 1 :neovim/nvim-lspconfig
      :event :BufRead
      : config
      :dependencies
      { 1 :williamboman/mason-lspconfig.nvim
        :config true
        :dependencies
        { 1 :williamboman/mason.nvim
          :cmd
          [:Mason :MasonInstall :MasonUninstall :MasonUninstallAll :MasonLog]
          :config true}}}
    { 1 :j-hui/fidget.nvim
      :event :LspAttach
      :opts {:text {:spinner :dots}}
      :config true}])

(fn setup []
  "Sets up LSP-related stuff."

  ; No Recommended Styles
  (let [g vim.g]
    (set g.python_recommended_style 0)
    (set g.rust_recommended_style 0))

  ; Diagnostics
  (let
    [ signs
      { :DiagnosticSignError :
        :DiagnosticSignWarn :
        :DiagnosticSignHint :
        :DiagnosticSignInfo :}]
    (each [sign symbol (pairs signs)]
      (vim.fn.sign_define sign {:numhl "" :text symbol :texthl sign})))
  (vim.diagnostic.config {:update_in_insert true :virtual_text {:spacing 1}})
  (modcall :soup.map
    { "[d"
      ["<Cmd>lua vim.diagnostic.goto_prev()<CR>" "Diagnostic go to previous"]
      "]d"
      ["<Cmd>lua vim.diagnostic.goto_next()<CR>" "Diagnostic go to next"]
      :<Leader>k
      [ "<Cmd>lua vim.diagnostic.open_float()<CR>"
        "Diagnostic show from line"]})

  (modcall :soup :push_lazy_spec lazy-spec))

{: setup}
