local lazy_spec
local function _1_()
  local config = require("sopa.config")
  config.enabled_integrations = {"cmp", "indent-blankline", "leap", "neo-tree", "treesitter"}
  vim.opt.termguicolors = true
  return (require("sopa")).init()
end
local function _2_(_, opts)
  vim.opt.timeoutlen = 500
  local _let_3_ = require("which-key")
  local register = _let_3_["register"]
  local setup = _let_3_["setup"]
  setup(opts)
  return register({["<Space>"] = {name = "Neo-Tree"}, c = {name = "Quickfix"}, f = {name = "Find"}, l = {name = "LSP"}, t = {name = "Toggle"}}, {prefix = "<Leader>"})
end
lazy_spec = {{event = "UIEnter", config = _1_, "atchim/sopa.nvim"}, {event = "UIEnter", opts = {}, config = _2_, "folke/which-key.nvim"}, {event = "BufRead", config = true, dependencies = "atchim/sopa.nvim", "lewis6991/gitsigns.nvim"}, {event = "BufRead", keys = {{desc = "Indent Blankline", "<Leader>ti", "<Cmd>IndentBlanklineToggle<CR>"}}, opts = {show_current_context = true, show_current_context_start = true, enabled = false}, config = true, "lukas-reineke/indent-blankline.nvim"}}
local function setup()
  do
    local o = vim.opt
    o.cmdheight = 0
    o.colorcolumn = "+1"
    o.conceallevel = 2
    o.cursorline = true
    o.cursorlineopt = {"number"}
    o.fillchars = {fold = " ", horiz = " ", horizdown = " ", horizup = " ", vert = " ", verthoriz = " ", vertleft = " ", vertright = " "}
    o.foldlevelstart = 99
    o.laststatus = 3
    o.listchars = {eol = "$", conceal = "%", extends = ">", nbsp = "+", precedes = "<", space = ".", tab = "> ", trail = "~"}
    o.mouse = "a"
    o.number = true
    o.relativenumber = true
    o.showmatch = true
    o.title = true
    o.visualbell = true
  end
  do
    local api = vim.api
    local group = api.nvim_create_augroup("soup.ui.yank_hl", {})
    local function _4_()
      return vim.highlight.on_yank({})
    end
    api.nvim_create_autocmd("TextYankPost", {desc = "Highlights selection on yank.", group = group, callback = _4_})
  end
  do
    local map = vim.keymap.set
    map("n", "<Leader>tl", "<Cmd>setlocal list!<CR>", {desc = "Local listing"})
    map("n", "<Leader>ts", "<Cmd>setlocal spell!<CR>", {desc = "Local spelling"})
  end
  do end (require("soup")).push_lazy_spec(lazy_spec)
  return (require("soup.ui.heirline")).setup()
end
return {setup = setup}
