(fn config []
  (let [config (require :sopa.config)]
    (set config.enabled_plugins [:bufferline :leap :neo-tree :treesitter])))

{: config}
