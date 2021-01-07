local M = {}

M.setup = function()
  local a = vim.api
  local g = vim.g
  local o = vim.o

  -- Chars
  o.fillchars = 'fold: ,vert: '
  o.listchars = 'extends:>,precedes:<,tab:> ,trail:~'

  -- Completion
  o.completeopt = 'menuone,noinsert,noselect'
  o.shortmess = o.shortmess .. 'c'

  -- Indentation
  o.breakindent = true
  o.copyindent = true
  o.expandtab = true
  o.shiftround = true
  o.smartindent = true
  local tab = 2
  o.shiftwidth = tab
  o.softtabstop = tab
  o.tabstop = tab

  -- Map Leader
  a.nvim_set_keymap('', '<Space>', 'NOP', { noremap = true })
  g.mapleader = ' '

  -- Match
  o.gdefault = true
  o.ignorecase = true
  o.showmatch = true
  o.smartcase = true

  -- Scroll
  local scroll = 8
  o.scrolloff = scroll
  o.sidescroll = scroll
  o.sidescrolloff = scroll

  -- UI
  a.nvim_command 'colorscheme underworld'
  o.cmdheight = 2
  o.number = true
  o.pumblend = 10
  o.list = true
  o.relativenumber = true
  o.signcolumn = 'yes'
  o.title = true
  o.visualbell = true

  -- Vars
  g.omni_sql_no_default_maps = 1
  g.python_recommended_style = 0
  g.rust_recommended_style = 0

  -- Wrap
  o.colorcolumn = '+1'
  o.textwidth = 79
  o.wrap = false

  -- Misc
  o.clipboard = 'unnamed'
  o.concealcursor = 'i'
  o.conceallevel = 2
  o.hidden = true
  o.inccommand = 'nosplit'
  o.lazyredraw = true
  o.mouse = 'a'
  o.spelllang = 'en_us'
  o.termguicolors = true
  o.ttimeoutlen = 0
  o.undofile = true
  o.updatetime = 250
end

return M
