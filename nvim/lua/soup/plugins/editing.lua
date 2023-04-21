local function config(_, opts)
  local npairs = require("nvim-autopairs")
  npairs.setup(opts)
  do
    local cmp = require("cmp")
    local cmp_autop = require("nvim-autopairs.completion.cmp")
    do end (cmp.event):on("confirm_done", cmp_autop.on_confirm_done())
  end
  local cond = require("nvim-autopairs.conds")
  local rule = require("nvim-autopairs.rule")
  local lispies = {"fennel", "query"}
  local pairies = {"(", "[", "{"}
  local pairies_2a = {")", "]", "}"}
  for _0, pairy in ipairs(pairies) do
    npairs.get_rule(pairy)["not_filetypes"] = lispies
  end
  for i, pairy in ipairs(pairies) do
    npairs.add_rule(rule(pairy, (pairies_2a)[i], lispies):with_pair(cond.not_after_regex("%w")))
  end
  return nil
end
local function _1_()
  return (require("ts_context_commentstring.internal")).update_commentstring()
end
local function _2_(_, opts)
  return (require("mini.comment")).setup(opts)
end
return {{"echasnovski/mini.comment", event = "BufRead", opts = {hooks = {pre = _1_}, options = {pad_comment_parts = false}}, config = _2_, dependencies = "JoosepAlviste/nvim-ts-context-commentstring"}, {"kylechui/nvim-surround", event = "BufRead", config = true}, {"windwp/nvim-autopairs", event = "InsertCharPre", opts = {check_ts = true, fast_wrap = {map = "<M-e>", chars = {"{", "[", "(", "\"", "'"}, pattern = "[%'%\"%>%]%)%}%,]", end_key = "$", keys = "jkflahdsg", check_comma = true, highlight = "Search", highlight_grey = "Comment"}}, config = config, dependencies = "hrsh7th/nvim-cmp"}}
