(local M {})

(fn M.init []
  "Initializes auto commands."
  (local api vim.api)
  (local group (api.nvim_create_augroup :soup_core_au {}))
  (api.nvim_create_autocmd :TextYankPost
    { : group
      :desc "Highlights selection on yank."
      :callback #(vim.highlight.on_yank {})}))

M
