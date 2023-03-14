(import-macros {: modcall} :soupmacs.soupmacs)

(fn setup []
  "Sets up core functionalities."

  ; Sets `mapleader` to `<Space>`.
  (vim.keymap.set :n :<Space> :<NOP>)
  (set vim.g.mapleader " ")

  ; Loads submodules.
  (let
    [ mods
      [ :options
        :globals
        :autocommands
        :commands
        :key-mappings
        :diagnostics
        :lazy]]
    (each [_ mod (ipairs mods)]
      (modcall (.. :soup.core. mod) :setup []))))

{: setup}
