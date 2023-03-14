(import-macros {: modcall} :soupmacs.soupmacs)

(fn setup []
  "Sets up the `lazy.nvim` plugin manager."
  (let [vfn vim.fn lazy-path (.. (vfn.stdpath :data) :/lazy/lazy.nvim)]
    ; Bootstraps `lazy.nvim` if needed.
    (when (not (vim.loop.fs_stat lazy-path))
      (vfn.system
        [ :git
          :clone
          :--filter=blob:none
          :https://github.com/folke/lazy.nvim.git
          :--branch=stable
          lazy-path]))
    (vim.opt.rtp:prepend lazy-path))
  (modcall
    :lazy
    :setup
    { :defaults {:lazy true}
      :spec
      [ {:import :soup.plugins}
        {:import :soup.plugins.navigation}
        {:import :soup.plugins.ui}]}))

{: setup}
