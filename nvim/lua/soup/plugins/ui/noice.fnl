(fn sopa-opts [_ opts]
  (let
    [ x (require :sopa.palette)
      custom_groups
      { :NoiceCmdlinePopup {:bg (x 2) :bold true}
        :NoiceCmdlinePopupBorder {:bg (x 2) :fg (x 1)}
        :NoiceCmdlinePopupBorderSearch {:link :NoiceCmdlinePopupBorder}}
      opts* {: custom_groups}]
    (vim.tbl_deep_extend :force opts opts*)))

{ 1 :folke/noice.nvim
  :event :VeryLazy
  :opts
  { :cmdline
    { :format
      { :cmdline {:title ""}
        :filter {:title ""}
        :help {:title ""}
        :lua {:title ""}
        :search_down {:title ""}
        :search_up {:title ""}}}
    :lsp
    { :override
      [ :vim.lsp.util.convert_input_to_markdown_lines true
        :vim.lsp.util.stylize_markdown true]}
    :presets {:long_message_to_split true}
    :views
    {:cmdline_popup {:border {:style [" " " " " " " " :▓ :▓ :▓ " "]}}}}
  :dependencies [:MunifTanjim/nui.nvim {1 :sopa.nvim :opts sopa-opts}]}
