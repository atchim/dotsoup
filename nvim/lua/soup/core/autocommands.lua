local function setup()
  local api = vim.api
  local group = api.nvim_create_augroup("soup.core.autocommands.yank_hl", {})
  local function _1_()
    return vim.highlight.on_yank({})
  end
  return api.nvim_create_autocmd("TextYankPost", {desc = "Highlights selection on yank.", group = group, callback = _1_})
end
return {setup = setup}
