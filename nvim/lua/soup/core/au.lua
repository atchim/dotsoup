local function init()
  local api = vim.api
  local group = api.nvim_create_augroup("soup_core_au", {})
  local function _1_()
    local bo = vim.bo
    bo.expandtab = true
    bo.shiftwidth = 0
    bo.tabstop = 2
    return nil
  end
  api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {group = group, pattern = "*.e{build,class}", desc = "don't tell me or my son how to write ebuild files ever again!", callback = _1_})
  local function _2_()
    return vim.highlight.on_yank({})
  end
  return api.nvim_create_autocmd("TextYankPost", {group = group, desc = "Highlight selection on yank.", callback = _2_})
end
return {init = init}
