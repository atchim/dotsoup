(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :telescope :setup)
  (call :telescope :load_extension :fzf)
  (call :soup.core.maps :map
    { :name :Telescope
      :b
        [ "<Cmd>lua require'telescope.builtin'.buffers()<CR>"
          "Buffers"]
      :f
        [ "<Cmd>lua require'telescope.builtin'.find_files()<CR>"
          "Files"]
      :g
				[ "<Cmd>lua require'telescope.builtin'.live_grep()<CR>"
          "Live grep"]
      :h
				[ "<Cmd>lua require'telescope.builtin'.help_tags()<CR>"
          "Help tags"]
      :o
        [ "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>"
          "Old files"]}
    {:prefix :<Leader>f}))

{: config}
