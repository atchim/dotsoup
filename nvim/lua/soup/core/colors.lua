local M = {}
M.init = function()
  local ok_3f, sopa = pcall(require, "sopa")
  if ok_3f then
    local api = vim.api
    local group = api.nvim_create_augroup("soup_core_colors", {})
    local function _1_()
      vim.opt.termguicolors = true
      return sopa.init()
    end
    return api.nvim_create_autocmd("VimEnter", {group = group, desc = "Sets the Sopa de Mamaco color scheme.", callback = _1_})
  else
    return nil
  end
end
return M
