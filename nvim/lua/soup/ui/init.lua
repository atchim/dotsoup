local lazy_spec
local function _1_()
  local config = require("sopa.config")
  config.enabled_integrations = {"cmp", "indent-blankline", "leap", "neo-tree", "treesitter"}
  vim.opt.termguicolors = true
  return (require("sopa")).init()
end
local function _2_(_, opts)
  vim.opt.timeoutlen = 500
  do end (require("which-key")).setup(opts)
  local _let_3_ = require("soup.map")
  local labels = _let_3_["labels"]
  local _let_4_ = require("which-key")
  local register = _let_4_["register"]
  for _0, _5_ in ipairs(labels) do
    local _each_6_ = _5_
    local maps = _each_6_[1]
    local _3fopts = _each_6_[2]
    register(maps, _3fopts)
  end
  return nil
end
local function _7_(_, opts)
  do end (require("indent_blankline")).setup(opts)
  return require("soup.map")({i = {"<Cmd>IndentBlanklineToggle<CR>", "Indent Blankline"}}, {prefix = "<Leader>t"})
end
lazy_spec = {{event = "UIEnter", config = _1_, "atchim/sopa.nvim"}, {name = "which-key", event = "UIEnter", opts = {}, config = _2_, "folke/which-key.nvim"}, {event = "BufRead", config = true, dependencies = "atchim/sopa.nvim", "lewis6991/gitsigns.nvim"}, {event = "BufRead", opts = {show_current_context = true, show_current_context_start = true, enabled = false}, config = _7_, "lukas-reineke/indent-blankline.nvim"}}
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
    local group = api.nvim_create_augroup("soup_ui_yank_hl_au", {})
    local function _8_()
      return vim.highlight.on_yank({})
    end
    api.nvim_create_autocmd("TextYankPost", {desc = "Highlights selection on yank.", group = group, callback = _8_})
  end
  require("soup.map")({name = "Toggle", l = {"<Cmd>setlocal list!<CR>", "Local listing"}, s = {"<Cmd>setlocal spell!<CR>", "Local spelling"}}, {prefix = "<Leader>t"})
  do end (require("soup")).push_lazy_spec(lazy_spec)
  return (require("soup.ui.heirline")).setup()
end
return {setup = setup}
