(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :indent_blankline :setup
    { :show_current_context true
      :show_current_context_start true})

  (call :which-key :register
    {:| [:<Cmd>IndentBlanklineToggle<CR> "Toggle Indent Blankline"]}
    {:prefix :<Leader>}))

{: config}
