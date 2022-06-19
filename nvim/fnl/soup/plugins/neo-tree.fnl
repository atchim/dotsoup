(import-macros {: call} :fnl.soup.macros)

(fn config []
  ; TODO: Set `cursorlineopt` to `'both'` for the Neo-Tree window.

  ; TODO: Add support for `s1n7ax/nvim-window-picker`.
  ; <https://github.com/nvim-neo-tree/neo-tree.nvim#quickstart>

  (set vim.g.neo_tree_remove_legacy_commands 1)

  (call :neo-tree :setup
    { :filesystem {:use_libuv_file_watcher true}
      :use_default_mappings false
      :window
        { :mappings
            { :. :toggle_hidden
              :/ :filter_as_you_type
              :<C-C> :clear_filter
              "<C-[>" :navigate_up
              "<C-]>" :set_root
              :? :show_help
              :a :add
              :d :delete
              :f :filter_on_submit
              :i :open_split
              :m :move
              :o :open
              :p :paste_from_clipboard
              :q :close_window
              :r :rename
              :R :refresh
              :s :open_vsplit
              :t :open_tabnew
              :x :cut_to_clipboard
              :y :copy_to_clipboard
              :za :toggle_node
              :zc :close_node
              :zC :close_all_nodes}
          :width 32}})

  (call :soup.core.maps :map
    { :name "Neo Tree"
      :<Space> ["<Cmd>Neotree toggle<CR>" :Toggle]
      :<CR> ["<Cmd>Neotree focus<CR>" :Focus]}
    {:prefix :<Leader><Space>}))

{: config}
