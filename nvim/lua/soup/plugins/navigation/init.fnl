(import-macros {: modcall} :soupmacs.soupmacs)

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
      :nvim-lua/plenary.nvim]}]
