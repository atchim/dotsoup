local M = {}

M.count_cmd = function(name, cmd)
  vim.api.nvim_exec(
    'command! -count '..name
      ..' lua require"soup.hack".count_cmd_exe"'..cmd ..'"',
    false
  )
end

M.count_cmd_exe = function(cmd)
  local count = vim.v.count
  if count == 0 then vim.api.nvim_exec(cmd, false)
  else vim.api.nvim_exec(cmd..' '..count, false)
  end
end

M.set_cmd = function()
  M.count_cmd('SoupBuf', 'buffer')
  M.count_cmd('SoupBufNext', 'bnext')
  M.count_cmd('SoupBufPrev', 'bprevious')
  M.count_cmd('SoupTabNext', 'tabnext')
  M.count_cmd('SoupTabPrev', 'tabprevious')
end

M.set_map = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true}
  map('n', '[b', '<Cmd>SoupBufPrev<CR>', opts)
  map('n', ']b', '<Cmd>SoupBufNext<CR>', opts)
  map('n', 'gb', '<Cmd>SoupBuf<CR>', opts)
  map('n', '[t', '<Cmd>SoupTabPrev<CR>', opts)
  map('n', ']t', '<Cmd>SoupTabNext<CR>', opts)
end

M.setup = function()
  M.set_cmd()
  M.set_map()
end

return M
