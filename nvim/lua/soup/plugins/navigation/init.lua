local function _1_()
  return (require("leap")).set_default_keymaps()
end
local function _2_()
  do end (require("telescope")).setup()
  return (require("telescope")).load_extension("fzf")
end
return {{"ggandor/leap.nvim", event = "BufRead", config = _1_}, {"nvim-telescope/telescope.nvim", cmd = "Telescope", keys = {{"<Leader>fb", "<Cmd>lua require'telescope.builtin'.buffers()<CR>", desc = "Buffers"}, {"<Leader>ff", "<Cmd>lua require'telescope.builtin'.find_files()<CR>", desc = "Files"}, {"<Leader>fg", "<Cmd>lua require'telescope.builtin'.live_grep()<CR>", desc = "Live grep"}, {"<Leader>fh", "<Cmd>lua require'telescope.builtin'.help_tags()<CR>", desc = "Help tags"}, {"<Leader>fo", "<Cmd>lua require'telescope.builtin'.oldfiles()<CR>", desc = "Old files"}}, config = _2_, dependencies = {{"nvim-telescope/telescope-fzf-native.nvim", build = "make"}, "nvim-lua/plenary.nvim"}}}
