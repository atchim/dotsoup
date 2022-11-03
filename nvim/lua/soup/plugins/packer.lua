local function bootstrap()
  local path = (vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim")
  if (vim.fn.empty(vim.fn.glob(path)) > 0) then
    local url = "https://github.com/wbthomason/packer.nvim"
    vim.fn.system({"git", "clone", "--depth", "1", url, path})
    return vim.v.shell_error
  else
    return 0
  end
end
local function user()
  local _local_2_ = require("packer")
  local use = _local_2_["use"]
  use({opt = true, "wbthomason/packer.nvim"})
  use({event = "UIEnter", "editorconfig/editorconfig-vim"})
  local _4_
  do
    local t_3_ = require("soup.plugins.sopa")
    if (nil ~= t_3_) then
      t_3_ = (t_3_).config
    else
    end
    _4_ = t_3_
  end
  use({config = _4_, "atchim/sopa.nvim"})
  local function _6_()
    vim.opt.timeoutlen = 500
    return (require("which-key")).setup()
  end
  use({event = "UIEnter", config = _6_, "folke/which-key.nvim"})
  local _8_
  do
    local t_7_ = require("soup.plugins.treesitter")
    if (nil ~= t_7_) then
      t_7_ = (t_7_).config
    else
    end
    _8_ = t_7_
  end
  use({event = "UIEnter", config = _8_, "nvim-treesitter/nvim-treesitter"})
  use({after = "nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects"})
  local function _10_()
    return (require("soup.core.maps")).map({p = {"<Cmd>TSPlaygroundToggle<CR>", "Tree-Sitter Playground"}}, {prefix = "<Leader>t"})
  end
  use({after = "nvim-treesitter", config = _10_, "nvim-treesitter/playground"})
  local _12_
  do
    local t_11_ = require("soup.plugins.cmp")
    if (nil ~= t_11_) then
      t_11_ = (t_11_).config
    else
    end
    _12_ = t_11_
  end
  local _15_
  do
    local t_14_ = require("soup.plugins.lspconfig")
    if (nil ~= t_14_) then
      t_14_ = (t_14_).config
    else
    end
    _15_ = t_14_
  end
  local function _17_()
    return (require("luasnip.loaders.from_vscode")).lazy_load()
  end
  use({event = "UIEnter", config = _12_, requires = {{after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", requires = {{config = _15_, opt = true, requires = {{opt = true, "williamboman/nvim-lsp-installer"}}, wants = "nvim-lsp-installer", "neovim/nvim-lspconfig"}}, wants = "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", requires = {{config = _17_, opt = true, requires = {{opt = true, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, "saadparwaiz1/cmp_luasnip"}}, wants = "LuaSnip", "hrsh7th/nvim-cmp"})
  local _19_
  do
    local t_18_ = require("soup.plugins.telescope")
    if (nil ~= t_18_) then
      t_18_ = (t_18_).config
    else
    end
    _19_ = t_18_
  end
  use({event = "UIEnter", config = _19_, requires = {{opt = true, "nvim-lua/plenary.nvim"}, {opt = true, run = "make", "nvim-telescope/telescope-fzf-native.nvim"}}, wants = {"plenary.nvim", "telescope-fzf-native.nvim"}, "nvim-telescope/telescope.nvim"})
  local _22_
  do
    local t_21_ = require("soup.plugins.neo-tree")
    if (nil ~= t_21_) then
      t_21_ = (t_21_).config
    else
    end
    _22_ = t_21_
  end
  local _25_
  do
    local t_24_ = require("soup.plugins.window-picker")
    if (nil ~= t_24_) then
      t_24_ = (t_24_).config
    else
    end
    _25_ = t_24_
  end
  use({branch = "v2.x", config = _22_, event = "UIEnter", requires = {{opt = true, "kyazdani42/nvim-web-devicons"}, {opt = true, "MunifTanjim/nui.nvim"}, {opt = true, "nvim-lua/plenary.nvim"}, {config = _25_, opt = true, "s1n7ax/nvim-window-picker"}}, wants = {"nui.nvim", "nvim-web-devicons", "nvim-window-picker", "plenary.nvim"}, "nvim-neo-tree/neo-tree.nvim"})
  local _28_
  do
    local t_27_ = require("soup.plugins.heirline")
    if (nil ~= t_27_) then
      t_27_ = (t_27_).config
    else
    end
    _28_ = t_27_
  end
  use({event = "UIEnter", config = _28_, requires = {{opt = true, "kyazdani42/nvim-web-devicons"}}, wants = "nvim-web-devicons", "rebelot/heirline.nvim"})
  local function _30_()
    return (require("leap")).set_default_keymaps()
  end
  use({event = "InsertCharPre", config = _30_, "ggandor/leap.nvim"})
  local function _31_()
    return (require("Comment")).setup({opleader = {block = "gC"}, toggler = {block = "gcC"}, padding = false})
  end
  use({config = _31_, "numToStr/Comment.nvim"})
  local function _32_()
    return (require("nvim-surround")).setup({})
  end
  use({event = "InsertCharPre", config = _32_, "kylechui/nvim-surround"})
  local function _33_()
    return (require("gitsigns")).setup({})
  end
  use({event = "UIEnter", config = _33_, "lewis6991/gitsigns.nvim"})
  local _35_
  do
    local t_34_ = require("soup.plugins.harpoon")
    if (nil ~= t_34_) then
      t_34_ = (t_34_).config
    else
    end
    _35_ = t_34_
  end
  use({event = "UIEnter", config = _35_, requires = {{opt = true, "nvim-lua/plenary.nvim"}}, wants = "plenary.nvim", "ThePrimeagen/harpoon"})
  local function _37_()
    do end (require("indent_blankline")).setup({show_current_context = true, show_current_context_start = true, enabled = false})
    return (require("soup.core.maps")).map({i = {"<Cmd>IndentBlanklineToggle<CR>", "Indent Blankline"}}, {prefix = "<Leader>t"})
  end
  use({config = _37_, "lukas-reineke/indent-blankline.nvim"})
  local _39_
  do
    local t_38_ = require("soup.plugins.ccc")
    if (nil ~= t_38_) then
      t_38_ = (t_38_).config
    else
    end
    _39_ = t_38_
  end
  use({event = "UIEnter", config = _39_, "uga-rosa/ccc.nvim"})
  local _42_
  do
    local t_41_ = require("soup.plugins.noice")
    if (nil ~= t_41_) then
      t_41_ = (t_41_).config
    else
    end
    _42_ = t_41_
  end
  use({event = "UIEnter", config = _42_, "folke/noice.nvim"})
  local function _44_()
    return (require("fidget")).setup({text = {spinner = "dots"}})
  end
  return use({config = _44_, "j-hui/fidget.nvim"})
end
local M = {}
M.init = function()
  local err = vim.api.nvim_err_writeln
  if (bootstrap() == 0) then
    vim.cmd("packadd packer.nvim")
    return (require("packer")).startup(user)
  else
    return err("unable to install `packer.nvim`")
  end
end
return M
