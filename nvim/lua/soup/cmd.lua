local M = {}

--- If `v:count` is 0, calls `cmd` with no arguments, otherwise calls `cmd`
--- with the count itself.
--- @param cmd string The command to be called.
M.count_or_none = function(cmd)
  local count = vim.v.count
  if count == 0 then vim.api.nvim_exec(cmd, false)
  else vim.api.nvim_exec(cmd..' '..count, false)
  end
end

--- Define commands.
M.init = function()
  M.with_count('SoupBufGoto', 'buffer')
  M.with_count('SoupBufNext', 'bnext')
  M.with_count('SoupBufPrev', 'bprevious')
  M.with_count('SoupTabNext', 'tabnext')
  M.with_count('SoupTabPrev', 'tabprevious')
end

--- Define a wrapper command to the function `count_or_none` with `repl` as
--- argument.
--- @param cmd string The name of the command.
--- @param repl string The replacement for the command.
M.with_count = function(cmd, repl)
  vim.api.nvim_exec(
    'command! -count '
      ..cmd
      ..' lua require"soup.cmd".count_or_none"'
      ..repl
      ..'"',
    false
  )
end

return M
