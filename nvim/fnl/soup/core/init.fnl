(import-macros {: subcalls} :soupmacs.soupmacs)
(local M {})

(fn M.init []
  "Initializes configurations for raw editor."
  (subcalls
    :init
    :soup.core
    :g
    :opts
    :maps
    :cmds
    :au
    :diagnostics
    :colors))

M
