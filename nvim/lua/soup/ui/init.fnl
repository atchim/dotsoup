(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ { 1 :atchim/sopa.nvim
      :event :UIEnter
      :config
      #(let [config (require :sopa.config)]
        (set config.enabled_integrations
          [:cmp :indent-blankline :leap :neo-tree :treesitter])
        (set vim.opt.termguicolors true)
        (modcall :sopa :init []))}
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
    { 1 :lewis6991/gitsigns.nvim
      :event :BufRead
      :config true
      :dependencies :atchim/sopa.nvim}
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
      :config true}])

(fn setup []
  "Sets up UI."

  ; Options
  (let [o vim.opt]
    (set o.cmdheight 0)
    (set o.colorcolumn :+1)
    (set o.conceallevel 2)
    (set o.cursorline true)
    (set o.cursorlineopt [:number])
    (set o.fillchars
      { :fold " "
        :horiz " "
        :horizdown " "
        :horizup " "
        :vert " "
        :verthoriz " "
        :vertleft " "
        :vertright " "})
    (set o.foldlevelstart 99)
    (set o.laststatus 3)
    (set o.listchars
      { :eol :$
        :conceal :%
        :extends :>
        :nbsp :+
        :precedes :<
        :space :.
        :tab "> "
        :trail "~"})
    (set o.mouse :a)
    (set o.number true)
    (set o.relativenumber true)
    (set o.showmatch true)
    (set o.title true)
    (set o.visualbell true))

  ; Yank Highlight
  (let [api vim.api group (api.nvim_create_augroup :soup.ui.yank_hl {})]
    (api.nvim_create_autocmd :TextYankPost
      { :desc "Highlights selection on yank."
        : group
        :callback #(vim.highlight.on_yank {})}))

  (let [map vim.keymap.set]
    (map :n :<Leader>tl "<Cmd>setlocal list!<CR>" {:desc "Local listing"})
    (map :n :<Leader>ts "<Cmd>setlocal spell!<CR>" {:desc "Local spelling"}))

  (modcall :soup :push_lazy_spec lazy-spec)
  (modcall :soup.ui.heirline :setup []))

{: setup}
