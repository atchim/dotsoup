(import-macros {: modcall} :soupmacs.soupmacs)
(local M {})

(fn M.init []
  "Initializes plugin configurations."
  (modcall :soup.plugins.packer :init ()))

M
