(import-macros {: calls} :fnl.soup.macros)

(fn init []
  "Set configurations for raw editor."
  (calls :init :soup.core
    :g
    :opts
    :maps
    :cmds
    :au
    :diagnostics
    :colors))

{: init}
