(local M {})

(fn M.init []
  "Initializes the color scheme."
  (let [(ok? sopa) (pcall require :sopa)]
    (when ok?
      (local api vim.api)
      (local group (api.nvim_create_augroup :soup_core_colors {}))
      (api.nvim_create_autocmd :VimEnter
        { : group
          :desc "Sets the Sopa de Mamaco color scheme."
          :callback #(do (set vim.opt.termguicolors true) (sopa.init))}))))

M
