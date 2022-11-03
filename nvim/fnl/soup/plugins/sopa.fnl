(local M {})

(fn M.config []
  "Post-load configuration hook."
  (let [config (require :sopa.config)]
    (set config.enabled_integrations
      [:cmp :indent-blankline :leap :neo-tree :treesitter])))

M
