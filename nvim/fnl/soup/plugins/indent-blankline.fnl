(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :indent_blankline :setup
    { :enabled false
      :show_current_context true
      :show_current_context_start true})

  (call :which-key :register
    {:i [:<Cmd>IndentBlanklineToggle<CR> "Indent Blankline"]}
    {:prefix :<Leader>t}))

{: config}
