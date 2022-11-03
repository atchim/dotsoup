(import-macros {: subcalls} :soupmacs.soupmacs)
(local M {})

(fn M.init []
  "Initializes the Soup configurations."
  (subcalls :init :soup :core :plugins))

M
