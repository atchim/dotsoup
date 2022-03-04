local M = {}

M.set_autocmd = function()
  local api = vim.api
  local group = 'soup_vanilla'

  api.nvim_create_augroup(group, {})

  api.nvim_create_autocmd('BufRead,BufNewFile', {
    group = group,
    pattern = '*.e{build,class}',
    desc = "Don't tell me or my son how to write ebuild files ever again!",
    callback = function()
      local bo = vim.bo
      bo.expandtab = true
      bo.shiftwidth = 2
      bo.tabstop = 2
    end,
  })

  api.nvim_create_autocmd('TextYankPost', {
    group = group,
    desc = 'Highlight selection on yank',
    callback = function()
      vim.highlight.on_yank{}
    end,
  })
end

M.set_g = function()
  local g = vim.g

  -- Disable Netrw
	g.loaded_netrw = 1
	g.loaded_netrwPlugin = 1

  -- Misc
  g.omni_sql_no_default_maps = 1
  g.vimsyn_embed = 1

  -- No Recommended Styles
  g.python_recommended_style = 0
  g.rust_recommended_style = 0
end

M.set_leader = function()
  vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true})
  vim.g.mapleader = ' '
end

M.set_map = function()
  local map = vim.api.nvim_set_keymap
  local opts = {noremap = true}

  -- Diagnostics
  map('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map('n', '<Leader>k', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- Misc
  map('n', '<Leader>,', '<Cmd>setl spell!<CR>', opts)
  map('n', '<Leader>.', '<Cmd>setl list!<CR>', opts)
  map('n', '<Leader>/', '<Cmd>noh<CR>', opts)
  map('v', '<Leader>y', '"+y', opts)

  -- TODO: Map <C-D> and <C-F> to scroll through popup menus.
end

M.set_opt = function()
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
  o.conceallevel = 2
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
  o.foldlevelstart = 99
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
  o.showmode = false
  o.termguicolors = true
  o.title = true

  -- Wrap
  o.colorcolumn = '+1'
  o.textwidth = 79
end

M.setup = function()
  M.set_leader()
  M.set_opt()
  M.set_g()
  M.set_autocmd()
  M.set_map()
end

return M
