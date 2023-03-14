(import-macros {: modcall} :soupmacs.soupmacs)

[ { 1 :atchim/sopa.nvim
    :event :UIEnter
    :opts {:custom_groups {:MiniStarterHeader {:link :Constant}}}
    :config
    (fn [_ opts]
      (modcall :sopa :setup opts)
      (vim.api.nvim_exec_autocmds
        :User
        {:pattern :SoupHasColors :modeline false}))}
  { 1 :folke/which-key.nvim
    :event :UIEnter
    :opts {}
    :config
    (fn [_ opts]
      (set vim.opt.timeoutlen 500)
      (let [{: register : setup} (require :which-key)]
        (setup opts)
        ; Registers groups.
        (register
          { :<Space> {:name :Neo-Tree}
            :c {:name :Quickfix}
            :f {:name :Find}
            :l {:name :LSP}
            :t {:name :Toggle}}
          {:prefix :<Leader>})))}
  {1 :lewis6991/gitsigns.nvim :event "User SoupHasColors" :config true}
  { 1 :lukas-reineke/indent-blankline.nvim
    :event :BufRead
    :keys
    [ { 1 :<Leader>ti
        2 :<Cmd>IndentBlanklineToggle<CR>
        :desc "Indent Blankline"}]
    :opts
    { :enabled false
      :show_current_context true
      :show_current_context_start true}
    :config true}]
