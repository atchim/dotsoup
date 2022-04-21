(import-macros {: call} :fnl.soup.macros)

(fn config []
  "Post load configuration hook."

  (call :nvim-treesitter.configs :setup
    { :highlight {:enable true}
      :incremental_selection
        { :enable true
          :keymaps
            { :init_selection :gn
              :node_decremental :N
              :node_incremental :n
              :scope_incremental :s}}
      :indent {:enable true}
      :textobjects
        { :move
          { :enable true
            :set_jumps true
            :goto_next_start
              { "]m" "@function.outer"
                "]]" "@class.outer"}
            :goto_previous_start
              { "[m" "@function.outer"
                "[[" "@class.outer"}
            :goto_next_end
              { "]M" "@function.outer"
                "][" "@class.outer"}
            :goto_previous_end
              { "[M" "@function.outer"
                "[]" "@class.outer"}}
        :select
          { :enable true
            :lookahead true
            :keymaps
              { :ac "@class.outer"
                :ic "@class.inner"
                :af "@function.outer"
                :if "@function.inner"
                :n "@node"}}
        :swap
          { :enable true
            :swap_next {:<C-N> "@swappable"}
            :swap_previous {:<C-P> "@swappable"}}}})

  ; XXX: May be possible to dynamically set this in the future.
  (let [o vim.opt]
    (set o.foldexpr "nvim_treesitter#foldexpr()")
    (set o.foldmethod :expr)))

{: config}
