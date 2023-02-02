(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ { 1 :atchim/sopa.nvim
      :event :UIEnter
      :config
      (fn []
        (let [config (require :sopa.config)]
          (set config.enabled_integrations
            [:cmp :indent-blankline :leap :neo-tree :treesitter])
          (set vim.opt.termguicolors true)
          (modcall :sopa :init [])))}
    { 1 :folke/which-key.nvim
      :name :which-key
      :event :UIEnter
      :opts {}
      :config
      (fn [_ opts]
        (set vim.opt.timeoutlen 500)
        (modcall :which-key :setup opts)
        (let [{: labels} (require :soup.map) {: register} (require :which-key)]
          (each [_ [maps ?opts] (ipairs labels)] (register maps ?opts))))}
    { 1 :lewis6991/gitsigns.nvim
      :event :BufRead
      :config true
      :dependencies :atchim/sopa.nvim}
    { 1 :lukas-reineke/indent-blankline.nvim
      :event :BufRead
      :opts
      { :enabled false
        :show_current_context true
        :show_current_context_start true}
      :config
      (fn [_ opts]
        (modcall :indent_blankline :setup opts)
        (modcall :soup.map
          [ {:i [:<Cmd>IndentBlanklineToggle<CR> "Indent Blankline"]}
            {:prefix :<Leader>t}]))}])

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
  (let [api vim.api group (api.nvim_create_augroup :soup_ui_yank_hl_au {})]
    (api.nvim_create_autocmd :TextYankPost
      { :desc "Highlights selection on yank."
        : group
        :callback #(vim.highlight.on_yank {})}))

  (modcall :soup.map
    [ { :name :Toggle
        :l ["<Cmd>setlocal list!<CR>" "Local listing"]
        :s ["<Cmd>setlocal spell!<CR>" "Local spelling"]}
      {:prefix :<Leader>t}])

  (modcall :soup :push_lazy_spec lazy-spec)
  (modcall :soup.ui.heirline :setup []))

{: setup}
