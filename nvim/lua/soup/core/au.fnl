(local M {})

(fn M.init []
  "Sets auto commands."
  (local api vim.api)
  (local group (api.nvim_create_augroup :soup_core_au {}))
  (api.nvim_create_autocmd :TextYankPost
    { :desc "Highlights selection on yank."
      : group
      :callback #(vim.highlight.on_yank {})}))

M
