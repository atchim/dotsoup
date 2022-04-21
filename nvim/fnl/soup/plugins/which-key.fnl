(import-macros {: call} :fnl.soup.macros)

(fn config []
  (set vim.opt.timeoutlen 500)
  (call :which-key :setup))

{: config}
