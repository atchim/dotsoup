local function setup()
  local o = vim.opt
  o.ignorecase = true
  o.smartcase = true
  o.tagcase = "followscs"
  o.fillchars = {fold = " ", horiz = " ", horizdown = " ", horizup = " ", vert = " ", verthoriz = " ", vertleft = " ", vertright = " "}
  o.listchars = {eol = "$", conceal = "%", extends = ">", nbsp = "+", precedes = "<", space = ".", tab = "> ", trail = "~"}
  o.breakindent = true
  o.copyindent = true
  o.expandtab = true
  o.preserveindent = true
  o.shiftround = true
  o.shiftwidth = 0
  o.smartindent = true
  o.tabstop = 2
  o.lazyredraw = true
  o.ttimeoutlen = 0
  o.updatetime = 250
  o.cmdheight = 0
  o.colorcolumn = "+1"
  o.conceallevel = 2
  o.cursorline = true
  o.cursorlineopt = {"number"}
  o.laststatus = 3
  o.number = true
  o.relativenumber = true
  o.showmatch = true
  o.termguicolors = true
  o.title = true
  o.visualbell = true
  o.clipboard = "unnamed"
  o.foldlevelstart = 99
  o.mouse = "ar"
  o.spelllang = "en_us"
  o.textwidth = 79
  o.undofile = true
  return nil
end
return {setup = setup}
