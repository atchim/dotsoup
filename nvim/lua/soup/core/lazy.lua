local function setup()
  do
    local vfn = vim.fn
    local lazy_path = (vfn.stdpath("data") .. "/lazy/lazy.nvim")
    if not vim.loop.fs_stat(lazy_path) then
      vfn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path})
    else
    end
    do end (vim.opt.rtp):prepend(lazy_path)
  end
  return (require("lazy")).setup({defaults = {lazy = true}, spec = {{import = "soup.plugins"}, {import = "soup.plugins.navigation"}, {import = "soup.plugins.ui"}}})
end
return {setup = setup}
