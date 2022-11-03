(import-macros {: modcall} :soupmacs.soupmacs)
(local M {})

(fn M.config []
  "Post-load configuration hook."
  (modcall :ccc :setup {})
  (modcall
    :soup.core.maps
    :map
    ( {:c [:<Cmd>CccHighlighterToggle<CR> "Color Highlighter"]}
      {:prefix :<Leader>t})))

M
