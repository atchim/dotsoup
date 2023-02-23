(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ { 1 :ggandor/leap.nvim
      :event :BufRead
      :config #(modcall :leap :set_default_keymaps [])}
    { 1 :nvim-telescope/telescope.nvim
      :cmd :Telescope
      :keys
      [ { 1 :<Leader>fb
          2 "<Cmd>lua require'telescope.builtin'.buffers()<CR>"
          :desc :Buffers}
        { 1 :<Leader>ff
          2 "<Cmd>lua require'telescope.builtin'.find_files()<CR>"
          :desc :Files}
        { 1 :<Leader>fg
          2 "<Cmd>lua require'telescope.builtin'.live_grep()<CR>"
          :desc "Live grep"}
        { 1 :<Leader>fh
          2 "<Cmd>lua require'telescope.builtin'.help_tags()<CR>"
          :desc "Help tags"}
        { 1 :<Leader>fo
          2 "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>"
          :desc "Old files"}]
      :config
      (fn []
        (modcall :telescope :setup [])
        (modcall :telescope :load_extension :fzf))
      :dependencies
      [ {1 :nvim-telescope/telescope-fzf-native.nvim :build :make}
        :nvim-lua/plenary.nvim]}
    { 1 :folke/todo-comments.nvim
      :cmd [:TodoQuickFix :TodoLocList :TodoTelescope]
      :event :BufRead
      :keys
      [ { 1 :<Leader>ft
          2 :<Cmd>TodoTelescope<CR>
          :desc "Todo telescope"}
        { 1 "[t"
          2 #(modcall :todo-comments :jump_prev [])
          :desc "Todo previous"}
        { 1 "]t"
          2 #(modcall :todo-comments :jump_next [])
          :desc "Todo next"}]
      :opts {:colors {:info [:Todo]} :highlight {:after "" :keyword ""}}
      :config true
      :dependencies :nvim-telescope/telescope.nvim}
    { 1 :uga-rosa/ccc.nvim
      :keys
      [ { 1 :<Leader>tc
          2 :<Cmd>CccHighlighterToggle<CR>
          :desc "Color Highlighter"}]
      :opts {}
      :config true}])

(fn setup []
  "Sets up navigation-related stuff."

  ; Case
  (let [o vim.opt]
    (set o.ignorecase true)
    (set o.smartcase true)
    (set o.tagcase :followscs))

  ; Disable Netrw.
  (let [g vim.g]
	  (set g.loaded_netrw 1)
	  (set g.loaded_netrwPlugin 1))

	(let [map vim.keymap.set]
	  (map :n :<Leader>c<CR> :<Cmd>copen<CR> {:desc :Open})
	  (map
	    :n
	    :<Leader>cc
	    #(let [f vim.fn]
        (->>
          (->
            (f.getwininfo)
            (f.filter :v:val.quickfix)
            (f.empty)
            (= 1)
            (if :copen :cclose))
          (. vim.cmd)
          ()))
	    {:desc :Toggle})
    (map :n :<Leader>cj :<Cmd>cbelow<CR> {:desc "Go to next below"})
    (map :n :<Leader>ck :<Cmd>cabove<CR> {:desc "Go to next above"})
    (map :n :<Leader>cn :<Cmd>cnext<CR> {:desc "Go to next"})
    (map :n :<Leader>cp :<Cmd>cprevious<CR> {:desc "Go to previous"}))

  (modcall :soup :push_lazy_spec lazy-spec)
  (modcall :soup.nav.neo-tree :setup []))

{: setup}
