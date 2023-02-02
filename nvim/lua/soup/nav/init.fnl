(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec
  [ { 1 :ggandor/leap.nvim
      :event :BufRead
      :config (fn [] (modcall :leap :set_default_keymaps []))}
    { 1 :uga-rosa/ccc.nvim
      :keys :<Leader>tc
      :opts {}
      :config
      (fn [_ opts]
        (modcall :ccc :setup opts)
        (modcall :soup.map
          [ {:c [:<Cmd>CccHighlighterToggle<CR> "Color Highlighter"]}
            {:prefix :<Leader>t}]))}
    { 1 :nvim-telescope/telescope.nvim
      :cmd :Telescope
      :keys [:<Leader>fb :<Leader>ff :<Leader>fg :<Leader>fh :<Leader>fo]
      :config
      (fn []
        (modcall :telescope :setup [])
        (modcall :telescope :load_extension :fzf)
        (modcall
          :soup.map
          [ { :name :Telescope
              :b
              ["<Cmd>lua require'telescope.builtin'.buffers()<CR>" "Buffers"]
              :f
              ["<Cmd>lua require'telescope.builtin'.find_files()<CR>" "Files"]
              :g
              [ "<Cmd>lua require'telescope.builtin'.live_grep()<CR>"
                "Live grep"]
              :h
              [ "<Cmd>lua require'telescope.builtin'.help_tags()<CR>"
                "Help tags"]
              :o
              [ "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>"
                "Old files"]}
            {:prefix :<Leader>f}]))
      :dependencies
      [ {1 :nvim-telescope/telescope-fzf-native.nvim :build :make}
        :nvim-lua/plenary.nvim]}])

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

  (modcall :soup.map
    { :<Leader>
      { :c
        { :name :Quickfix
          :<CR> [:<Cmd>copen<CR> :Open]
          :c
          [ #(let [f vim.fn]
              (->>
                (->
                  (f.getwininfo)
                  (f.filter :v:val.quickfix)
                  (f.empty)
                  (= 1)
                  (if :copen :cclose))
                (. vim.cmd)
                ()))
            :Toggle]
          :j [:<Cmd>cbelow<CR> "Go to next below"]
          :k [:<Cmd>cabove<CR> "Go to next above"]
          :n [:<Cmd>cnext<CR> "Go to next"]
          :p [:<Cmd>cprevious<CR> "Go to previous"]}}})

  (modcall :soup :push_lazy_spec lazy-spec)
  (modcall :soup.nav.cmd :setup [])
  (modcall :soup.nav.neo-tree :setup []))

{: setup}
