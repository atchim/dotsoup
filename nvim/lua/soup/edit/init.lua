local lazy_spec = {{"editorconfig/editorconfig-vim", event = "BufRead"}, {"kylechui/nvim-surround", event = "BufRead", config = true}, {"atchim/minicomm.nvim", event = "BufRead", opts = {padding = {start = false, ["end"] = false}}, config = true}}
local function setup()
  do
    local o = vim.opt
    o.breakindent = true
    o.copyindent = true
    o.expandtab = true
    o.preserveindent = true
    o.shiftround = true
    o.shiftwidth = 0
    o.smartindent = true
    o.tabstop = 2
    o.clipboard = "unnamed"
    o.spelllang = "en_us"
    o.textwidth = 79
    o.undofile = true
  end
  do
    local g = vim.g
    g.python_recommended_style = 0
    g.rust_recommended_style = 0
  end
  do
    local map = vim.keymap.set
    map({"n", "v"}, "<Leader>y", "\"+y", {desc = "CTRL-C-like yank to clipboard"})
    map("x", "<Leader>p", "\"_dP", {desc = "Register-safe paste"})
  end
  do end (require("soup")).push_lazy_spec(lazy_spec)
  return (require("soup.edit.autopairs")).setup()
end
return {setup = setup}
