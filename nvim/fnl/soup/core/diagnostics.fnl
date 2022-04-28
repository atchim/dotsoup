(fn init []
  "Set diagnostics configurations."
  (let
    [ signs
        { :DiagnosticSignError :
          :DiagnosticSignWarn :
          :DiagnosticSignHint :
          :DiagnosticSignInfo :}]
    (each [sign symbol (pairs signs)]
      (vim.fn.sign_define sign {:numhl "" :text symbol :texthl sign})))
  (vim.diagnostic.config
    { :update_in_insert true
      :virtual_text {:spacing 1}}))

{: init}
