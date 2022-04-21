local function init()
  if pcall(require, "sopa") then
    local api = vim.api
    local group = api.nvim_create_augroup("soup_core_colors", {})
    local function _1_()
      vim.opt.termguicolors = true
      return (require("sopa")).init()
    end
    return api.nvim_create_autocmd("VimEnter", {group = group, desc = "Set the Sopa de Mamaco color scheme.", callback = _1_})
  else
    return nil
  end
end
return {init = init}
