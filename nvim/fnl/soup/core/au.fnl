(fn init []
  "Set auto commands."

  (local api vim.api)
  (local group (api.nvim_create_augroup :soup_core_au {}))

  (api.nvim_create_autocmd [:BufEnter :BufWinEnter]
    { : group
      :pattern "*.e{build,class}"
      :desc "don't tell me or my son how to write ebuild files ever again!"
      :callback
        #(let [bo vim.bo]
          (set bo.expandtab true)
          (set bo.shiftwidth 0)
          (set bo.tabstop 2))})
    
  (api.nvim_create_autocmd :TextYankPost
    { : group
      :desc "Highlight selection on yank."
      :callback #(vim.highlight.on_yank {})}))

{: init}
