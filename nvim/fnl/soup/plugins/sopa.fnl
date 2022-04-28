(fn config []
  (let [config (require :sopa.config)]
    (set config.enabled_plugins
      [:bufferline :indent-blankline :leap :neo-tree :treesitter])))

{: config}
