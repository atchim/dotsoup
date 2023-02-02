local lazy_spec
local function _1_(_, opts)
  do end (require("nvim-autopairs")).setup(opts)
  local cmp_autop = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  return (cmp.event):on("confirm_done", cmp_autop.on_confirm_done())
end
lazy_spec = {{event = "BufRead", "editorconfig/editorconfig-vim"}, {event = "BufRead", config = true, "kylechui/nvim-surround"}, {event = "BufRead", opts = {opleader = {block = "gC"}, toggler = {block = "gcC"}, padding = false}, config = true, "numToStr/Comment.nvim"}, {event = "InsertCharPre", opts = {check_ts = true}, config = _1_, dependencies = "hrsh7th/nvim-cmp", "windwp/nvim-autopairs"}}
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
    o.spelllang = "en_us"
    o.textwidth = 79
  end
  do end (require("soup.syn.ts")).setup()
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {setup = setup}
