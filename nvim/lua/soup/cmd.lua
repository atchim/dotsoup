--- Configurations for commands.
local M = {}

--- Call the command `cmd` with no arguments if `v:count` is 0, otherwise call
--- `cmd` with the value of `v:count` as argument.
--- @param cmd string The command to be called.
M.call_cmd_count = function(cmd)
  local count = vim.v.count
  if count == 0 then vim.api.nvim_exec(cmd, false)
  else vim.api.nvim_exec(cmd..' '..count, false)
  end
end

--- Workaround function to define command which calls other command that
--- normally would struggle with count.
--- @param name string The name of the command to create.
--- @param cmd string The command that this should call.
M.count_cmd = function(name, cmd)
  vim.api.nvim_exec(
    'command! -count '
      ..name
      ..' lua require"soup.cmd".call_cmd_count"'
      ..cmd
      ..'"',
    false
  )
end

--- Define generic commands.
M.init = function()
  M.count_cmd('SoupBufGoto', 'buffer')
  M.count_cmd('SoupBufNext', 'bnext')
  M.count_cmd('SoupBufPrev', 'bprevious')
  M.count_cmd('SoupTabNext', 'tabnext')
  M.count_cmd('SoupTabPrev', 'tabprevious')
end

return M
