local M = {}

--- Define autocommands.
M.init = function()
  -- Don't tell me or my son how to write ebuild files ever again!
  vim.cmd[[
    augroup soup_gentoo
      autocmd!
      autocmd BufRead,BufNewFile *.e{build,class} setl et sw=2 ts=2
    augroup END
  ]]
end

return M
