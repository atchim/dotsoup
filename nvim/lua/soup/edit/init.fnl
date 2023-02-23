(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ {1 :editorconfig/editorconfig-vim :event :BufRead}
    {1 :kylechui/nvim-surround :event :BufRead :config true}
    { 1 :atchim/minicomm.nvim
      :event :BufRead
      :opts {:padding {:start false :end false}}
      :config true}])

(fn setup []
  "Sets up editing-related configurations."

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
    (set o.clipboard :unnamed)
    (set o.spelllang :en_us)
    (set o.textwidth 79)
    (set o.undofile true))

  ; No Recommended Styles
  (let [g vim.g]
    (set g.python_recommended_style 0)
    (set g.rust_recommended_style 0))

  (let [map vim.keymap.set]
    (map [:n :v] :<Leader>y "\"+y" {:desc "CTRL-C-like yank to clipboard"})
    (map :x :<Leader>p "\"_dP" {:desc "Register-safe paste"}))

  (modcall :soup :push_lazy_spec lazy-spec)
  (modcall :soup.edit.autopairs :setup []))

{: setup}
