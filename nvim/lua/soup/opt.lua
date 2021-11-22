local M = {}

M.init = function()
  local o = vim.opt

  -- Case
  o.ignorecase = true
  o.smartcase = true
  o.tagcase = 'followscs'

  -- Chars
  o.fillchars = {fold = ' ', vert = ' '}
  o.listchars = {
    eol = '$',
    conceal = '%',
    extends = '>',
    nbsp = '+',
    precedes = '<',
    space = '.',
    tab = '> ',
    trail = '~',
  }

  -- FX
  o.inccommand = 'nosplit'
  o.showmatch = true
  o.visualbell = true

  -- Indentation
  o.breakindent = true
  o.copyindent = true
  o.expandtab = true
  o.preserveindent = true
  o.shiftround = true
  o.shiftwidth = 0
  o.smartindent = true
  o.tabstop = 2

  -- Misc
  o.clipboard = 'unnamed'
  o.completeopt = {'menuone', 'noselect'}
  o.conceallevel = 2
  o.foldlevelstart = 99
  o.hidden = true
  o.mouse = 'a'
  o.shortmess:append'c'
  o.spelllang = 'en_us'
  o.undofile = true

  -- Performance
  o.lazyredraw = true
  o.timeoutlen = 500
  o.ttimeoutlen = 0
  o.updatetime = 250

  -- UI
  o.cursorline = true
  o.cursorlineopt = {'number'}
  o.number = true
  o.pumblend = 15
  o.relativenumber = true
  o.termguicolors = true
  o.title = true

  -- Wrap
  o.colorcolumn = '+1'
  o.textwidth = 79
end

return M
