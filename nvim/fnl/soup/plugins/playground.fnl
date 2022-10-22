(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :which-key :register
    {:p [:<Cmd>TSPlaygroundToggle<CR> "Tree-Sitter Playground"]}
    {:prefix :<Leader>t}))

{: config}
