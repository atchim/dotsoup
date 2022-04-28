(import-macros {: call} :fnl.soup.macros)

(fn config []
  ; TODO: Set `cursorlineopt` to `'both'` for the Neo-Tree window.

  (set vim.g.neo_tree_remove_legacy_commands 1)

  (call :neo-tree :setup
    { :filesystem {:use_libuv_file_watcher true}
      :window
        { :mappings
            {:o :open}
          :width 32}})

  (call :soup.core.maps :map
    { :name "Neo Tree"
      :<Space> ["<Cmd>Neotree toggle<CR>" :Toggle]
      :<CR> ["<Cmd>Neotree focus<CR>" :Focus]}
    {:prefix :<Leader><Space>}))

{: config}
