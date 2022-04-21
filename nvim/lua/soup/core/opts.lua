local function init()
  local o = vim.opt
  o.ignorecase = true
  o.smartcase = true
  o.tagcase = "followscs"
  o.fillchars = {fold = " ", vert = " "}
  o.listchars = {eol = "$", conceal = "%", extends = ">", nbsp = "+", precedes = "<", space = ".", tab = "> ", trail = "~"}
  o.conceallevel = 2
  o.showmatch = true
  o.visualbell = true
  o.breakindent = true
  o.copyindent = true
  o.expandtab = true
  o.preserveindent = true
  o.shiftround = true
  o.shiftwidth = 0
  o.smartindent = true
  o.tabstop = 2
  o.clipboard = "unnamed"
  o.foldlevelstart = 99
  o.mouse = "a"
  o.spelllang = "en_us"
  o.undofile = true
  o.lazyredraw = true
  o.ttimeoutlen = 0
  o.updatetime = 250
  o.cursorline = true
  o.cursorlineopt = {"number"}
  o.number = true
  o.pumblend = 15
  o.relativenumber = true
  o.title = true
  o.colorcolumn = "+1"
  o.textwidth = 79
  return nil
end
return {init = init}
