(fn setup []
  "Sets up core global variables."

  (let [g vim.g]
    ; Disable Netrw.
	  (set g.loaded_netrw 1)
	  (set g.loaded_netrwPlugin 1)

    ; Disable Recommended Styles
    (set g.python_recommended_style 0)
    (set g.rust_recommended_style 0)

    ; Misc
    (set g.omni_sql_no_default_maps 1)))

{: setup}
