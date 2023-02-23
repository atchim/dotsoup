local lazy_spec
local function _1_()
  return (require("leap")).set_default_keymaps()
end
local function _2_()
  do end (require("telescope")).setup()
  return (require("telescope")).load_extension("fzf")
end
local function _3_()
  return (require("todo-comments")).jump_prev()
end
local function _4_()
  return (require("todo-comments")).jump_next()
end
lazy_spec = {{event = "BufRead", config = _1_, "ggandor/leap.nvim"}, {cmd = "Telescope", keys = {{desc = "Buffers", "<Leader>fb", "<Cmd>lua require'telescope.builtin'.buffers()<CR>"}, {desc = "Files", "<Leader>ff", "<Cmd>lua require'telescope.builtin'.find_files()<CR>"}, {desc = "Live grep", "<Leader>fg", "<Cmd>lua require'telescope.builtin'.live_grep()<CR>"}, {desc = "Help tags", "<Leader>fh", "<Cmd>lua require'telescope.builtin'.help_tags()<CR>"}, {desc = "Old files", "<Leader>fo", "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>"}}, config = _2_, dependencies = {{build = "make", "nvim-telescope/telescope-fzf-native.nvim"}, "nvim-lua/plenary.nvim"}, "nvim-telescope/telescope.nvim"}, {cmd = {"TodoQuickFix", "TodoLocList", "TodoTelescope"}, event = "BufRead", keys = {{desc = "Todo telescope", "<Leader>ft", "<Cmd>TodoTelescope<CR>"}, {desc = "Todo previous", "[t", _3_}, {desc = "Todo next", "]t", _4_}}, opts = {colors = {info = {"Todo"}}, highlight = {after = "", keyword = ""}}, config = true, dependencies = "nvim-telescope/telescope.nvim", "folke/todo-comments.nvim"}, {keys = {{desc = "Color Highlighter", "<Leader>tc", "<Cmd>CccHighlighterToggle<CR>"}}, opts = {}, config = true, "uga-rosa/ccc.nvim"}}
local function setup()
  do
    local o = vim.opt
    o.ignorecase = true
    o.smartcase = true
    o.tagcase = "followscs"
  end
  do
    local g = vim.g
    g.loaded_netrw = 1
    g.loaded_netrwPlugin = 1
  end
  do
    local map = vim.keymap.set
    map("n", "<Leader>c<CR>", "<Cmd>copen<CR>", {desc = "Open"})
    local function _5_()
      local f = vim.fn
      local _6_
      if (f.empty(f.filter(f.getwininfo(), "v:val.quickfix")) == 1) then
        _6_ = "copen"
      else
        _6_ = "cclose"
      end
      return vim.cmd[_6_]()
    end
    map("n", "<Leader>cc", _5_, {desc = "Toggle"})
    map("n", "<Leader>cj", "<Cmd>cbelow<CR>", {desc = "Go to next below"})
    map("n", "<Leader>ck", "<Cmd>cabove<CR>", {desc = "Go to next above"})
    map("n", "<Leader>cn", "<Cmd>cnext<CR>", {desc = "Go to next"})
    map("n", "<Leader>cp", "<Cmd>cprevious<CR>", {desc = "Go to previous"})
  end
  do end (require("soup")).push_lazy_spec(lazy_spec)
  return (require("soup.nav.neo-tree")).setup()
end
return {setup = setup}
