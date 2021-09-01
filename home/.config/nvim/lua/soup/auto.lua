local M = {}

M.setup = function()
  vim.cmd[[
    augroup soup_gentoo
      autocmd!
      autocmd BufRead,BufNewFile *.e{build,class} setl et sw=2 ts=2
    augroup END
  ]]
end

return M
