local M = {}
M.init = function()
  local api = vim.api
  local group = api.nvim_create_augroup("soup_core_au", {})
  local function _1_()
    return vim.highlight.on_yank({})
  end
  return api.nvim_create_autocmd("TextYankPost", {group = group, desc = "Highlights selection on yank.", callback = _1_})
end
return M
