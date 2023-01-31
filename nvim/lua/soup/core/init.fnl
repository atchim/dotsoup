(import-macros {: modcall} :soupmacs.soupmacs)
(local M {})

(fn M.init []
  "Sets configurations for raw editor."
  (modcall :soup.core.g :init [])
  (modcall :soup.core.opts :init [])
  (modcall :soup.core.maps :init [])
  (modcall :soup.core.cmds :init [])
  (modcall :soup.core.au :init [])
  (modcall :soup.core.diagnostics :init []))

M
