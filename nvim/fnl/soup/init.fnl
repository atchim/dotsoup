(import-macros {: modcall} :soupmacs.soupmacs)
(local M {})

(fn M.init []
  "Initializes the Soup configurations."
  (modcall :soup.core :init [])
  (modcall :soup.plugins :init []))

M
