(fn setup []
  ; Yank Highlight
  (let
    [ api vim.api
      group (api.nvim_create_augroup :soup.core.autocommands.yank_hl {})]
    (api.nvim_create_autocmd :TextYankPost
      { :desc "Highlights selection on yank."
        : group
        :callback #(vim.highlight.on_yank {})})))

{: setup}
