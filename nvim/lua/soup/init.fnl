(import-macros {: modcall} :soupmacs.soupmacs)

(local lazy-spec [])
(local lazy-opts {:defaults {:lazy true}})

(fn push-lazy-spec [spec]
  "Pushes `lazy.nvim` plugin specification."
  (table.insert lazy-spec spec))

(fn setup-lazy []
  "Sets up the `lazy.nvim` plugin manager."
  ; Bootstraps `lazy.nvim` if needed.
  (let [vfn vim.fn lazy-path (.. (vfn.stdpath :data) :/lazy/lazy.nvim)]
    (when (not (vim.loop.fs_stat lazy-path))
      (vfn.system
        [ :git
          :clone
          :--filter=blob:none
          :https://github.com/folke/lazy.nvim.git
          :--branch=stable
          lazy-path]))
    (vim.opt.rtp:prepend lazy-path))
  (modcall :lazy :setup [lazy-spec lazy-opts]))

(fn setup []
  "Sets up the Soup configurations."

  ; Sets `mapleader` to `<Space>`.
  (vim.keymap.set :n :<Space> :<NOP>)
  (set vim.g.mapleader " ")

  (let [o vim.opt]
    ; Performance
    (set o.lazyredraw true)
    (set o.ttimeoutlen 0)
    (set o.updatetime 250)

    ; Misc
    (set o.clipboard :unnamed)
    (set o.undofile true))

  (let [map! (require :soup.map)]
    (map!
      {:<Leader>y ["\"+y" "CTRL-C-like yank to clipboard"]}
      {:mode [:n :v]})
    (map! {:<Leader>p ["\"_dP" "Register-safe paste"]} {:mode :x}))

  (modcall :soup.syn :setup [])
  (modcall :soup.cmp :setup [])
  (modcall :soup.lsp :setup [])
  (modcall :soup.nav :setup [])
  (modcall :soup.ui :setup [])

  (setup-lazy))

{:push_lazy_spec push-lazy-spec : setup}
