(fn setup []
  "Sets up key mappings."

  (let [map vim.keymap.set]
    ; Quickfix
	  (map :n :<Leader>c<CR> :<Cmd>copen<CR> {:desc :Open})
	  (map
	    :n
	    :<Leader>cc
	    #(let [f vim.fn]
        ((->>
          (->
            (f.getwininfo)
            (f.filter :v:val.quickfix)
            (f.empty)
            (= 1)
            (if :copen :cclose))
          (. vim.cmd))))
	    {:desc :Toggle})
    (map :n :<Leader>cj :<Cmd>cbelow<CR> {:desc "Go to next below"})
    (map :n :<Leader>ck :<Cmd>cabove<CR> {:desc "Go to next above"})
    (map :n :<Leader>cn :<Cmd>cnext<CR> {:desc "Go to next"})
    (map :n :<Leader>cp :<Cmd>cprevious<CR> {:desc "Go to previous"})

    ; Paste/Yank
    (map [:n :v] :<Leader>y "\"+y" {:desc "CTRL-C-like yank to clipboard"})
    (map :x :<Leader>p "\"_dP" {:desc "Register-safe paste"})))

{: setup}
