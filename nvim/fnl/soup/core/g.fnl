(local M {})

(fn M.init []
  "Sets global variables."

  (local g vim.g)

  ; Disable Netrw.
	(set g.loaded_netrw 1)
	(set g.loaded_netrwPlugin 1)

  ; Set `mapleader` to `<Space>`.
  (vim.api.nvim_set_keymap :n :<Space> :<NOP> {:noremap true})
  (set g.mapleader " ")

  ; No Recommended Styles
  (set g.python_recommended_style 0)
  (set g.rust_recommended_style 0)

  ; Misc
  (set g.omni_sql_no_default_maps 1)
  (set g.vimsyn_embed 1))

M
