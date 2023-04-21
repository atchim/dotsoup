(import-macros {: modcall} :soupmacs.soupmacs)

{ 1 :nvim-neo-tree/neo-tree.nvim
  :branch :v2.x
  :cmd :Neotree
  :keys
  [ {1 :<Leader><Space><CR> 2 "<Cmd>Neotree focus<CR>" :desc :Focus}
    {1 :<Leader><Space><Space> 2 "<Cmd>Neotree toggle<CR>" :desc :Toggle}]
  :opts
  { :filesystem {:use_libuv_file_watcher true}
    :event_handlers
    [ { :event :neo_tree_buffer_enter
        :handler #(set vim.wo.cursorlineopt :line)}]
    :use_default_mappings false
    :window
    { :mappings
      { :. :toggle_hidden
        :/ :filter_as_you_type
        :<C-C> :clear_filter
        "<C-U>" :navigate_up
        "<C-]>" :set_root
        :? :show_help
        :a :add
        :d :delete
        :f :filter_on_submit
        :i :open_split
        :I :split_with_window_picker
        :m :move
        :o :open
        :O :open_with_window_picker
        :p :paste_from_clipboard
        :q :close_window
        :r :rename
        :R :refresh
        :s :open_vsplit
        :S :vsplit_with_window_picker
        :t :open_tabnew
        :x :cut_to_clipboard
        :y :copy_to_clipboard
        :za :toggle_node
        :zc :close_node
        :zC :close_all_nodes}
      :width 32}}
  :config
  (fn [_ opts]
    (set vim.g.neo_tree_remove_legacy_commands 1)
    (modcall :neo-tree :setup opts))
  :dependencies
  [ :MunifTanjim/nui.nvim
    :kyazdani42/nvim-web-devicons
    :nvim-lua/plenary.nvim
    { 1 :s1n7ax/nvim-window-picker
      :opts {:use_winbar :smart :selection_chars :JKFLAHDSG}}]}
