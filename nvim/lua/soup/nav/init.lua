local lazy_spec
local function _1_()
  return (require("leap")).set_default_keymaps()
end
local function _2_(_, opts)
  do end (require("ccc")).setup(opts)
  return require("soup.map")({c = {"<Cmd>CccHighlighterToggle<CR>", "Color Highlighter"}}, {prefix = "<Leader>t"})
end
local function _3_()
  do end (require("telescope")).setup()
  do end (require("telescope")).load_extension("fzf")
  return require("soup.map")({name = "Telescope", b = {"<Cmd>lua require'telescope.builtin'.buffers()<CR>", "Buffers"}, f = {"<Cmd>lua require'telescope.builtin'.find_files()<CR>", "Files"}, g = {"<Cmd>lua require'telescope.builtin'.live_grep()<CR>", "Live grep"}, h = {"<Cmd>lua require'telescope.builtin'.help_tags()<CR>", "Help tags"}, o = {"<Cmd>lua require'telescope.builtin'.oldfiles()<CR>", "Old files"}}, {prefix = "<Leader>f"})
end
lazy_spec = {{event = "BufRead", config = _1_, "ggandor/leap.nvim"}, {keys = "<Leader>tc", opts = {}, config = _2_, "uga-rosa/ccc.nvim"}, {cmd = "Telescope", keys = {"<Leader>fb", "<Leader>ff", "<Leader>fg", "<Leader>fh", "<Leader>fo"}, config = _3_, dependencies = {{build = "make", "nvim-telescope/telescope-fzf-native.nvim"}, "nvim-lua/plenary.nvim"}, "nvim-telescope/telescope.nvim"}}
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
  local function _4_()
    local f = vim.fn
    local _5_
    if (f.empty(f.filter(f.getwininfo(), "v:val.quickfix")) == 1) then
      _5_ = "copen"
    else
      _5_ = "cclose"
    end
    return vim.cmd[_5_]()
  end
  require("soup.map")({["<Leader>"] = {c = {name = "Quickfix", ["<CR>"] = {"<Cmd>copen<CR>", "Open"}, c = {_4_, "Toggle"}, j = {"<Cmd>cbelow<CR>", "Go to next below"}, k = {"<Cmd>cabove<CR>", "Go to next above"}, n = {"<Cmd>cnext<CR>", "Go to next"}, p = {"<Cmd>cprevious<CR>", "Go to previous"}}}})
  do end (require("soup")).push_lazy_spec(lazy_spec)
  do end (require("soup.nav.cmd")).setup()
  return (require("soup.nav.neo-tree")).setup()
end
return {setup = setup}
