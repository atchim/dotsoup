local lazy_spec = {}
local function push_lazy_spec(spec)
  return table.insert(lazy_spec, spec)
end
local function setup_lazy()
  do
    local vfn = vim.fn
    local lazy_path = (vfn.stdpath("data") .. "/lazy/lazy.nvim")
    if not vim.loop.fs_stat(lazy_path) then
      vfn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path})
    else
    end
    do end (vim.opt.rtp):prepend(lazy_path)
  end
  return (require("lazy")).setup(lazy_spec, {defaults = {lazy = true}})
end
local function setup()
  vim.keymap.set("n", "<Space>", "<NOP>")
  vim.g.mapleader = " "
  do
    local o = vim.opt
    o.lazyredraw = true
    o.ttimeoutlen = 0
    o.updatetime = 250
  end
  do end (require("soup.edit")).setup()
  do end (require("soup.cmd")).setup()
  do end (require("soup.ts")).setup()
  do end (require("soup.cmp")).setup()
  do end (require("soup.lsp")).setup()
  do end (require("soup.nav")).setup()
  do end (require("soup.ui")).setup()
  return setup_lazy()
end
return {push_lazy_spec = push_lazy_spec, setup = setup}
