(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ {1 :editorconfig/editorconfig-vim :event :BufRead}
    {1 :kylechui/nvim-surround :event :BufRead :config true}
    { 1 :numToStr/Comment.nvim
      :event :BufRead
      :opts {:opleader {:block :gC} :padding false :toggler {:block :gcC}}
      :config true}
    { 1 :windwp/nvim-autopairs
      :event :InsertCharPre
      :opts {:check_ts true}
      :config
      (fn [_ opts]
        (modcall :nvim-autopairs :setup opts)
        (let
          [ cmp-autop (require :nvim-autopairs.completion.cmp)
            cmp (require :cmp)]
          (cmp.event:on :confirm_done (cmp-autop.on_confirm_done))))
      :dependencies :hrsh7th/nvim-cmp}])

(fn setup []
  "Sets up syntax-related configurations."

  (let [o vim.opt]
    ; Indentation
    (set o.breakindent true)
    (set o.copyindent true)
    (set o.expandtab true)
    (set o.preserveindent true)
    (set o.shiftround true)
    (set o.shiftwidth 0)
    (set o.smartindent true)
    (set o.tabstop 2)

    ; Misc
    (set o.spelllang :en_us)
    (set o.textwidth 79))

  (modcall :soup.syn.ts :setup [])
  (modcall :soup :push_lazy_spec lazy-spec))

{: setup}
