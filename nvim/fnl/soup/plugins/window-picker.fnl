(import-macros {: call : get} :fnl.soup.macros)

(fn config []
  (local config {:selection_chars :JKFLAHDSG})
  (->>
    (get :sopa.plugins.window-picker :colors)
    (vim.tbl_deep_extend :force config)
    (call :window-picker :setup)))

{: config}
