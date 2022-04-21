(import-macros {: call} :fnl.soup.macros)

(fn config []
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
        { :format
            (fn [_ vimitem]
              (set vimitem.kind (. icons vimitem.kind))
              vimitem)}
      :mapping
        { :<C-D> (cmp.mapping (cmp.mapping.scroll_docs -1) [:i :c])
          :<C-E> (cmp.mapping.abort)
          :<C-F> (cmp.mapping (cmp.mapping.scroll_docs 1) [:i :c])
          :<C-N> (cmp.mapping.select_next_item)
          :<C-P> (cmp.mapping.select_prev_item)
          :<C-Space> (cmp.mapping (cmp.mapping.complete) [:i :c])
          :<CR> (cmp.mapping.confirm {:select true})
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
                  (fallback)))
              [:i :s])
          :<Up> (cmp.mapping.select_prev_item)}
      :snippet {:expand #(call :luasnip :lsp_expand $1.body)}
      :sources
        (cmp.config.sources
          [ {:name :copilot}
            {:name :nvim_lua}
            {:name :nvim_lsp}
            {:name :luasnip}]
          [ {:name :path}
            {:name :buffer}])}))

{: config}
