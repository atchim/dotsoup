--
-- Globals
--

--- A wrapper for executing a command which demands attention with count.
--- @param cmd string The command to execute.
_G.soup_count_wrapper = function(cmd)
  local count = vim.v.count
  if count == 0 then vim.api.nvim_exec(cmd, false)
  else vim.api.nvim_exec(cmd..' '..count, false)
  end
end

--
-- Locals
--

--- A wrapper for defining a command which relies on count.
--- @param cmd string The name of the command.
--- @param repl string The replacement for the command.
local function count_cmd(cmd, repl)
  vim.api.nvim_exec(
    'command! -count '..cmd..' lua soup_count_wrapper"'..repl..'"',
    false
  )
end

--
-- Module
--

local M = {}

--- Define commands.
M.init = function()
  count_cmd('SoupBufNext', 'bnext')
  count_cmd('SoupBufPrev', 'bprevious')
  count_cmd('SoupTabNext', 'tabnext')
  count_cmd('SoupTabPrev', 'tabprevious')
end

return M
