(import-macros {: call} :fnl.soup.macros)

(fn init []
  "Set the color scheme."
  (when (pcall require :sopa)
    (local api vim.api)
    (local group (api.nvim_create_augroup :soup_core_colors {}))
    (api.nvim_create_autocmd :VimEnter
      { : group
        :desc "Set the Sopa de Mamaco color scheme."
        :callback
          #(do
            (set vim.opt.termguicolors true)
            (call :sopa :init))})))

{: init}
