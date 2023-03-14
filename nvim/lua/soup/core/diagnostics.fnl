(fn setup []
  "Sets up diagnostic-related stuff."
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
      {:desc "Diagnostic show from line"})))

{: setup}
