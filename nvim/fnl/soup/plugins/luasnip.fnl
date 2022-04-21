(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :luasnip.loaders.from_vscode :lazy_load))

{: config}
