local function setup()
  local map = vim.keymap.set
  map({"n", "v"}, "<Leader>y", "\"+y", {desc = "CTRL-C-like yank to clipboard"})
  map("x", "<Leader>p", "\"_dP", {desc = "Register-safe paste"})
  map("n", "<Leader>c<CR>", "<Cmd>copen<CR>", {desc = "Open"})
  local function _1_()
    local f = vim.fn
    local _2_
    if (f.empty(f.filter(f.getwininfo(), "v:val.quickfix")) == 1) then
      _2_ = "copen"
    else
      _2_ = "cclose"
    end
    return vim.cmd[_2_]()
  end
  map("n", "<Leader>cc", _1_, {desc = "Toggle"})
  map("n", "<Leader>cj", "<Cmd>cbelow<CR>", {desc = "Go to next below"})
  map("n", "<Leader>ck", "<Cmd>cabove<CR>", {desc = "Go to next above"})
  map("n", "<Leader>cn", "<Cmd>cnext<CR>", {desc = "Go to next"})
  map("n", "<Leader>cp", "<Cmd>cprevious<CR>", {desc = "Go to previous"})
  map("n", "<Leader>tl", "<Cmd>setl list!<CR>", {desc = "Toggle local 'list'"})
  return map("n", "<Leader>ts", "<Cmd>setl spell!<CR>", {desc = "Toggle local 'spell'"})
end
return {setup = setup}
