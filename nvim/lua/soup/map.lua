--- Configurations for the key mappings.
local M = {}

--- Return a wrapper function for defining key mappings to commands.
--- @param mode string The mode.
--- @param opts table The options passed to `vim.api.nvim_set_keymap`.
--- @return function wrapper The wrapper function.
M.cmd_wrapper = function(mode, opts)
  --- Define a key mapping to a command.
  --- @param seq string The key sequence.
  --- @param cmd string The command string.
  return function(seq, cmd)
    vim.api.nvim_set_keymap(mode, seq, '<Cmd>'..cmd..'<CR>', opts)
  end
end

--- Define generic key mappings.
M.init = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true, silent = true}
  local cmd = M.cmd_wrapper('n', opts)

  -- Buffer
  cmd('gb', 'SoupBufGoto')
  cmd('[b', 'SoupBufPrev')
  cmd(']b', 'SoupBufNext')

  -- Misc
  cmd('<Leader>,', 'setl spell!')
  cmd('<Leader>.', 'setl list!')
  cmd('<Leader>/', 'noh')

  -- Tab
  cmd('[t', 'SoupTabPrev')
  cmd(']t', 'SoupTabNext')

  -- Quickfix
  cmd('<Leader>ca', 'cabove')
  cmd('<Leader>cb', 'cbelow')
  cmd('<Leader>cc', 'copen')
  cmd('<Leader>cn', 'cnext')
  cmd('<Leader>cp', 'cprevious')
  cmd('<Leader>cq', 'cclose')

  -- Yank
  map('v', '<Leader>y', '"+y', opts)
end

--- Return a wrapper function for defining key mappings for lua functions.
--- @param mode string The mapping mode.
--- @param opts table The mapping options.
M.lua_wrapper = function(mode, opts)
  --- Define a key mapping to a lua function.
  --- @param seq string The key sequence,
  --- @param mod string The module name.
  --- @param f string The function call string.
  return function(seq, mod, f)
    local repl = '<Cmd>lua require"'..mod..'".'..f..'<CR>'
    vim.api.nvim_set_keymap(mode, seq, repl, opts)
  end
end

return M
