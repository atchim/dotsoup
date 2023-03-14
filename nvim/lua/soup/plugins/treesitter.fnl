(import-macros {: modcall} :soupmacs.soupmacs)

(local opts
  { :context_commentstring {:enable true :enable_autocmd false}
    :highlight {:enable true}
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
        {"]m" "@function.outer" "]]" "@class.outer"}
        :goto_previous_start {"[m" "@function.outer" "[[" "@class.outer"}
        :goto_next_end {"]M" "@function.outer" "][" "@class.outer"}
        :goto_previous_end {"[M" "@function.outer" "[]" "@class.outer"}}
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

(fn config [_ opts]
  "Post-load configuration hook."
  (modcall :nvim-treesitter.configs :setup opts)
  (let [o vim.opt]
    (set o.foldexpr "nvim_treesitter#foldexpr()")
    (set o.foldmethod :expr)))

[ { 1 :nvim-treesitter/nvim-treesitter
    :cmd
    [ :TSInstall
      :TSInstallSync
      :TSInstallInfo
      :TSUpdate
      :TSUpdateSync
      :TSUninstall
      :TSModuleInfo
      :TSEditQuery
      :TSEditQueryUserAfter]
    :event :BufRead
    : opts
    : config}
  { 1 :nvim-treesitter/nvim-treesitter-textobjects
    :event :BufRead
    :dependencies :nvim-treesitter}
  { 1 :nvim-treesitter/playground
    :event :BufRead
    :keys
    [ { 1 :<Leader>tp
        2 :<Cmd>TSPlaygroundToggle<CR>
        :desc "Tree-Sitter Playground"}]
    :dependencies :nvim-treesitter}
  { 1 :JoosepAlviste/nvim-ts-context-commentstring
    :event :BufRead
    :dependencies :nvim-treesitter}]
