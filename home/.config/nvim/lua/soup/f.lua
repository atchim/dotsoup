local function count_cmd(name)
  local cmd = vim.cmd
  local count = vim.v.count
  if count == 0 then cmd(name)
  else cmd(name..' '..count)
  end
end

local M = {}
M.buf_del = function() count_cmd'bdelete' end
M.buf_goto = function() count_cmd'buffer' end
M.buf_next = function() count_cmd'bnext' end
M.buf_prev = function() count_cmd'bprevious' end
M.tab_close = function() count_cmd'tabclose' end
M.tab_next = function() count_cmd'tabnext' end
M.tab_prev = function() count_cmd'tabprevious' end
return M
