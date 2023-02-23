(import-macros {: modcall} :soupmacs.soupmacs)

(fn config []
  "Post-load configuration hook."

  (fn on_attach [client bufnr]
    (let
      [ api vim.api
        group (api.nvim_create_augroup (.. :soup.lsp.on_attach. bufnr) {})
        ns-name (.. :vim.lsp. client.name :. bufnr)
        diagn vim.diagnostic
        ns
        (do
          (var found false)
          (var ns nil)
          (each [i data (pairs (diagn.get_namespaces)) &until found]
            (set ns i)
            (set found (= ns-name data.name)))
          ns)
        map vim.keymap.set
        mapn (fn [lhs rhs desc] (map :n lhs rhs {:buffer bufnr : desc}))]

      (when (client.supports_method :textDocument/formatting)
        (api.nvim_create_autocmd
          :BufWritePre
          { :desc "Auto format on write"
            : group
            :callback #(vim.lsp.buf.format {: bufnr})
            :buffer bufnr}))

      (var old-vt (. (diagn.config) :virtual_text))
      (map
        :n
        :<Leader>tv
        #(let
          [ ns-config (diagn.config nil ns)
            vt ns-config.virtual_text
            vt (if (= nil vt) old-vt vt)]
          (set ns-config.virtual_text
            (if vt (do (set old-vt vt) false) old-vt))
          (diagn.config ns-config ns))
        {:buffer bufnr :desc "Virtual text"})

      (map
        :v
        :<Leader>lf
        "<Cmd>lua vim.lsp.buf.format()<CR>"
        {:buffer bufnr :desc :Format})
      (mapn
        :<C-H>
        "<Cmd>lua vim.lsp.buf.signature_help()<CR>"
        "LSP signature help")
      (mapn
        "<C-]>"
        "<Cmd>lua vim.lsp.buf.definition()<CR>"
        "LSP go to symbol definition")
      (mapn :<Leader>lf "<Cmd>lua vim.lsp.buf.format()<CR>" "Format")
      (mapn
        :<Leader>ls
        "<Cmd>lua vim.lsp.buf.document_symbol()<CR>"
        "Document symbols")
      (mapn
        :<Leader>lS
        "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"
        "Workspace symbols")
      (mapn :cr "<Cmd>lua vim.lsp.buf.rename()<CR>" "LSP symbol rename")
      (mapn
        :gd
        "<Cmd>lua vim.lsp.buf.declaration()<CR>"
        "LSP symbol declaration")
      (mapn
        :gD
        "<Cmd>lua vim.lsp.buf.type_definition()<CR>"
        "LSP type definition")
      (mapn
        :gm
        "<Cmd>lua vim.lsp.buf.implementation()<CR>"
        "LSP implementations")
      (mapn :go "<Cmd>lua vim.lsp.buf.code_action()<CR>" "LSP code action")
      (mapn :gr "<Cmd>lua vim.lsp.buf.references()<CR>" "LSP references")
      (mapn :K "<Cmd>lua vim.lsp.buf.hover()<CR>" "LSP hover information")))

  (let
    [ api vim.api
      capabilities
      (modcall :cmp_nvim_lsp :default_capabilities
        (vim.lsp.protocol.make_client_capabilities))]
    (modcall :mason-lspconfig :setup_handlers
      { 1
        (fn [server]
          (modcall :lspconfig server :setup {: capabilities : on_attach}))
        :fennel_language_server
        #(modcall :lspconfig :fennel_language_server :setup
          { : capabilities
            : on_attach
            :settings
            { :fennel
              { :diagnostics {:globals [:vim]}
                :workspace {:library (api.nvim_list_runtime_paths)}}}})
        :lua_ls
        #(modcall :lspconfig :lua_ls :setup
          { : capabilities
            : on_attach
            :settings
            { :Lua
              { :diagnostics {:globals [:vim]}
                :workspace
                { :library (api.nvim_get_runtime_file "" true)
                  :checkThirdParty false}}}})})))

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
  (let
    [ signs
      { :DiagnosticSignError :
        :DiagnosticSignWarn :
        :DiagnosticSignHint :
        :DiagnosticSignInfo :}]
    (each [sign symbol (pairs signs)]
      (vim.fn.sign_define sign {:numhl "" :text symbol :texthl sign})))
  (vim.diagnostic.config
    {:update_in_insert true :virtual_text {:spacing 1}})
  (let [map vim.keymap.set]
    (map
      :n
      "[d"
      "<Cmd>lua vim.diagnostic.goto_prev()<CR>"
      {:desc "Diagnostic go to previous"})
    (map
      :n
      "]d"
      "<Cmd>lua vim.diagnostic.goto_next()<CR>"
      {:desc "Diagnostic go to next"})
    (map
      :n
      :<Leader>k
      "<Cmd>lua vim.diagnostic.open_float()<CR>"
      {:desc "Diagnostic show from line"}))
  (modcall :soup :push_lazy_spec lazy-spec))

{: setup}
