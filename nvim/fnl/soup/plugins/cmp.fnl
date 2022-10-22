(import-macros {: call} :fnl.soup.macros)

(local M {})

(fn M.has-word-before []
  "Returns `true` whether there is a non-space character before the cursor."
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and
      (not= 0 col)
      (=
        nil
        (->
          (vim.api.nvim_buf_get_lines 0 (- line 1) line true)
          (. 1)
          (: :sub col col)
          (: :match "%s"))))))

(fn M.config []
  (local cmp (require :cmp))
  (local luasnip (require :luasnip))
  (local icons
    { :Class :
      :Color :
      :Constant :
      :Constructor :
      :Enum :
      :EnumMember :
      :Event :
      :Field :ﰠ
      :File :
      :Folder :
      :Function :
      :Interface :
      :Keyword :
      :Method :
      :Module :
      :Operator :
      :Property :
      :Reference :
      :Snippet :
      :Struct :פּ
      :Text :
      :TypeParameter :
      :Unit :
      :Value :
      :Variable :})

  (cmp.setup
    { :formatting
        { :fields [:kind :abbr]
          :format
            (fn [_ vimitem]
              (set vimitem.kind (. icons vimitem.kind))
              vimitem)}
      :mapping
        { :<C-C> (cmp.mapping.abort)
          :<C-E> (cmp.mapping (cmp.mapping.scroll_docs 1) [:i :c])
          :<C-N> (cmp.mapping.select_next_item)
          :<C-P> (cmp.mapping.select_prev_item)
          :<C-Y> (cmp.mapping (cmp.mapping.scroll_docs -1) [:i :c])
          :<CR> (cmp.mapping.confirm)
          :<Down> (cmp.mapping.select_next_item)
          :<S-Tab>
            (cmp.mapping
              (fn [fallback]
                (if
                  (cmp.visible) (cmp.select_prev_item)
                  (luasnip.jumpable -1) (luasnip.jump -1)
                  (fallback)))
              [:i :s])
          :<Tab>
            (cmp.mapping
              (fn [fallback]
                (if
                  (cmp.visible) (cmp.select_next_item)
                  (luasnip.expandable) (luasnip.expand)
                  (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                  (call :soup.plugins.cmp :has-word-before) (cmp.complete)
                  (fallback)))
              [:i :s])
          :<Up> (cmp.mapping.select_prev_item)}
      :snippet {:expand #(call :luasnip :lsp_expand $1.body)}
      :sources
        (cmp.config.sources
          [ {:name :nvim_lua}
            {:name :nvim_lsp}
            {:name :luasnip}]
          [ {:name :path}
            {:name :buffer}])
      :view {:entries {:name :custom :selection_order :near_cursor}}}))

M
