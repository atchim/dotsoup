local function _1_(_, opts)
  return opts
end
local function _2_(_, opts)
  do end (require("sopa")).setup(opts)
  return vim.api.nvim_exec_autocmds("User", {pattern = "SoupHasColors", modeline = false})
end
local function _3_(_, opts)
  vim.opt.timeoutlen = 500
  local _let_4_ = require("which-key")
  local register = _let_4_["register"]
  local setup = _let_4_["setup"]
  setup(opts)
  return register({["<Space>"] = {name = "Neo-Tree"}, c = {name = "Quickfix"}, f = {name = "Find"}, l = {name = "LSP"}, t = {name = "Toggle"}}, {prefix = "<Leader>"})
end
return {{"atchim/sopa.nvim", event = "UIEnter", opts = _1_, config = _2_}, {"folke/which-key.nvim", event = "UIEnter", opts = {}, config = _3_}, {"lewis6991/gitsigns.nvim", event = "User SoupHasColors", config = true}, {"lukas-reineke/indent-blankline.nvim", event = "BufRead", keys = {{"<Leader>ti", "<Cmd>IndentBlanklineToggle<CR>", desc = "Indent Blankline"}}, opts = {show_current_context = true, show_current_context_start = true, enabled = false}}}