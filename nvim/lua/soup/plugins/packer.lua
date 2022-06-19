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
    return true
  end
  local _8_
  do
    local t_7_ = require("soup.plugins.cmp")
    if (nil ~= t_7_) then
      t_7_ = (t_7_).config
    else
    end
    _8_ = t_7_
  end
  local _11_
  do
    local t_10_ = require("soup.plugins.lspconfig")
    if (nil ~= t_10_) then
      t_10_ = (t_10_).config
    else
    end
    _11_ = t_10_
  end
  local _14_
  do
    local t_13_ = require("soup.plugins.luasnip")
    if (nil ~= t_13_) then
      t_13_ = (t_13_).config
    else
    end
    _14_ = t_13_
  end
  local _17_
  do
    local t_16_ = require("soup.plugins.copilot")
    if (nil ~= t_16_) then
      t_16_ = (t_16_).config
    else
    end
    _17_ = t_16_
  end
  use({cond = _6_, config = _8_, requires = {{after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", requires = {{config = _11_, opt = true, requires = {{opt = true, "williamboman/nvim-lsp-installer"}}, wants = "nvim-lsp-installer", "neovim/nvim-lspconfig"}}, wants = "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", requires = {{config = _14_, opt = true, requires = {{opt = true, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, "saadparwaiz1/cmp_luasnip"}, {after = "nvim-cmp", requires = {{config = _17_, opt = true, "zbirenbaum/copilot.lua"}}, wants = "copilot.lua", "zbirenbaum/copilot-cmp"}}, wants = "LuaSnip", "hrsh7th/nvim-cmp"})
  use({ft = "sxhkdrc", "baskerville/vim-sxhkdrc"})
  use("elihunter173/dirbuf.nvim")
  local _20_
  do
    local t_19_ = require("soup.plugins.leap")
    if (nil ~= t_19_) then
      t_19_ = (t_19_).config
    else
    end
    _20_ = t_19_
  end
  use({config = _20_, "ggandor/leap.nvim"})
  local function _22_()
    return true
  end
  local _24_
  do
    local t_23_ = require("soup.plugins.telescope")
    if (nil ~= t_23_) then
      t_23_ = (t_23_).config
    else
    end
    _24_ = t_23_
  end
  use({cond = _22_, config = _24_, requires = {{opt = true, "nvim-lua/plenary.nvim"}, {opt = true, run = "make", "nvim-telescope/telescope-fzf-native.nvim"}}, wants = {"plenary.nvim", "telescope-fzf-native.nvim"}, "nvim-telescope/telescope.nvim"})
  local function _26_()
    return true
  end
  local _28_
  do
    local t_27_ = require("soup.plugins.harpoon")
    if (nil ~= t_27_) then
      t_27_ = (t_27_).config
    else
    end
    _28_ = t_27_
  end
  use({cond = _26_, config = _28_, requires = {{opt = true, "nvim-lua/plenary.nvim"}}, wants = "plenary.nvim", "ThePrimeagen/harpoon"})
  use("editorconfig/editorconfig-vim")
  local _31_
  do
    local t_30_ = require("soup.plugins.comment")
    if (nil ~= t_30_) then
      t_30_ = (t_30_).config
    else
    end
    _31_ = t_30_
  end
  use({config = _31_, "numToStr/Comment.nvim"})
  use("tpope/vim-surround")
  local function _33_()
    return true
  end
  local _35_
  do
    local t_34_ = require("soup.plugins.treesitter")
    if (nil ~= t_34_) then
      t_34_ = (t_34_).config
    else
    end
    _35_ = t_34_
  end
  use({cond = _33_, config = _35_, requires = {{after = "nvim-treesitter", "nvim-treesitter/playground"}, {after = "nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects"}}, "nvim-treesitter/nvim-treesitter"})
  local _38_
  do
    local t_37_ = require("soup.plugins.bufferline")
    if (nil ~= t_37_) then
      t_37_ = (t_37_).config
    else
    end
    _38_ = t_37_
  end
  use({config = _38_, "akinsho/bufferline.nvim"})
  local _41_
  do
    local t_40_ = require("soup.plugins.which-key")
    if (nil ~= t_40_) then
      t_40_ = (t_40_).config
    else
    end
    _41_ = t_40_
  end
  use({config = _41_, "folke/which-key.nvim"})
  local _44_
  do
    local t_43_ = require("soup.plugins.indent-blankline")
    if (nil ~= t_43_) then
      t_43_ = (t_43_).config
    else
    end
    _44_ = t_43_
  end
  use({config = _44_, "lukas-reineke/indent-blankline.nvim"})
  local _47_
  do
    local t_46_ = require("soup.plugins.neo-tree")
    if (nil ~= t_46_) then
      t_46_ = (t_46_).config
    else
    end
    _47_ = t_46_
  end
  use({after = "plenary.nvim", branch = "v2.x", config = _47_, requires = {{opt = true, "MunifTanjim/nui.nvim"}, {opt = true, "nvim-lua/plenary.nvim"}}, wants = "nui.nvim", "nvim-neo-tree/neo-tree.nvim"})
  local _50_
  do
    local t_49_ = require("soup.plugins.heirline")
    if (nil ~= t_49_) then
      t_49_ = (t_49_).config
    else
    end
    _50_ = t_49_
  end
  return use({config = _50_, event = "VimEnter", requires = {{opt = true, "kyazdani42/nvim-web-devicons"}}, wants = "nvim-web-devicons", "rebelot/heirline.nvim"})
end
local function init()
  local err = vim.api.nvim_err_writeln
  if (bootstrap() == 0) then
    vim.cmd("packadd packer.nvim")
    return (require("packer")).startup(user)
  else
    return err("unable to install `packer.nvim`")
  end
end
return {init = init}
