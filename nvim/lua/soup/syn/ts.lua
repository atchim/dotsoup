local opts = {highlight = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "gn", node_decremental = "N", node_incremental = "n", scope_incremental = "s"}}, indent = {enable = true}, textobjects = {move = {enable = true, set_jumps = true, goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"}, goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"}, goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"}, goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}}, select = {enable = true, lookahead = true, keymaps = {ac = "@class.outer", ic = "@class.inner", af = "@function.outer", ["if"] = "@function.inner", n = "@node"}}, swap = {enable = true, swap_next = {["<C-N>"] = "@swappable"}, swap_previous = {["<C-P>"] = "@swappable"}}}}
local function config(_, opts0)
  do end (require("nvim-treesitter.configs")).setup(opts0)
  local o = vim.opt
  o.foldexpr = "nvim_treesitter#foldexpr()"
  o.foldmethod = "expr"
  return nil
end
local lazy_spec
local function _1_()
  return require("soup.map")({p = {"<Cmd>TSPlaygroundToggle<CR>", "Tree-Sitter Playground"}}, {prefix = "<Leader>t"})
end
lazy_spec = {{cmd = {"TSInstall", "TSInstallSync", "TSInstallInfo", "TSUpdate", "TSUpdateSync", "TSUninstall", "TSModuleInfo", "TSEditQuery", "TSEditQueryUserAfter"}, event = "BufRead", opts = opts, config = config, "nvim-treesitter/nvim-treesitter"}, {event = "BufRead", dependencies = {"nvim-treesitter/nvim-treesitter"}, "nvim-treesitter/nvim-treesitter-textobjects"}, {keys = "<Leader>tp", config = _1_, dependencies = {"nvim-treesitter/nvim-treesitter"}, "nvim-treesitter/playground"}}
local function setup()
  vim.g.vimsyn_embed = 1
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {setup = setup}
