local M = {}

M.call_count_cmd = function(cmd)
  local count = vim.v.count
  if count == 0 then vim.api.nvim_exec(cmd, false)
  else vim.api.nvim_exec(cmd..' '..count, false)
  end
end

M.count_cmd = function(name, cmd)
  vim.api.nvim_exec(
    'command! -count '
      ..name
      ..' lua require"soup.cmd".call_count_cmd"'
      ..cmd
      ..'"',
    false
  )
end

M.init = function()
  M.count_cmd('SoupBufGoto', 'buffer')
  M.count_cmd('SoupBufNext', 'bnext')
  M.count_cmd('SoupBufPrev', 'bprevious')
  M.count_cmd('SoupTabNext', 'tabnext')
  M.count_cmd('SoupTabPrev', 'tabprevious')
end

return M
