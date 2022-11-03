(import-macros {: modcall : modget?} :soupmacs.soupmacs)
(local M {})

(fn M.config []
  "Post-load configuration hook."
  (let
    [config {:use_winbar :smart :selection_chars :JKFLAHDSG}]
    (->>
      (modget? :sopa.integrations.window-picker :colors)
      (vim.tbl_deep_extend :force config)
      ()
      (modcall :window-picker :setup))))

M
