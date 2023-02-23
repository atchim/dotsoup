(import-macros {: ordef} :soupmacs.soupmacs)

(macro vcount-or-1 []
  "Returns non-zero `v:count` or 1."
  `(let [n# vim.v.count] (if (= 0 n#) 1 n#)))

(local cmds
  { :buf
    { :del #(pcall vim.api.nvim_buf_delete vim.v.count {})
      :goto #(pcall vim.api.nvim_set_current_buf vim.v.count)
      :next #(vim.cmd (.. "bnext " (vcount-or-1)))
      :prev #(vim.cmd (.. "bprevious " (vcount-or-1)))}})

(fn split [s ?sep ?i]
  "Returns an iterator for splitting text according with arbitrary separator.

  `s` must be a string that the iterator will try to split. The splitted
  string will be returned as two values, which are the indexes of the start
  and the end of the split respectively.

  `?sep` is an optional Lua pattern string denoting the separator. It defaults
  to `:%s+`, which means that any sequence of spaces will be interpreted as a
  separator. `?i` is an optional index number that denotes where to start to
  split. It defaults to the beginning of `s`."

  (local len (length s))
  (local sep (ordef ?sep "%s+"))
  (var offset (ordef ?i 1))
  (var exhausted? false)

  #(do
    ; Strip off leading separators.
    (local (start end)
      (let [(start end) (s:find sep offset)]
        (if (= 1 start)
          (do (set offset (+ 1 end)) (s:find sep offset))
          (values start end))))

    (if
      exhausted? nil
      (not= nil start)
      (let [old-offset offset]
        (set exhausted? (= len end))
        (set offset (+ 1 end))
        (values old-offset (- start 1)))
      ; Pick remaining range.
      (do (set exhausted? true) (values offset len)))))

(fn comp [lead line pos]
  "Complete function for the `Soup` command."

  (local args
    (let [[_ start _] (vim.fn.matchstrpos line "S\\%[oup] *\\zs.*")]
      (icollect [start end (split line :%s+ (+ 1 start))]
        (when (and (< start pos) (< end pos)) (line:sub start end)))))

  (local (subcmd broken?)
    (do
      (var subcmd cmds)
      (var broken? false)
      (each [_ arg* (ipairs args) &until broken?]
        (local item (. subcmd arg*))
        (if
          (= :table (type item)) (set subcmd item)
          (set broken? true)))
      (values subcmd broken?)))

  (if broken?
    []
    (let [lead (lead:sub 1 pos)]
      (vim.fn.sort (icollect [arg* _ (pairs subcmd)]
        (let [(start _) (arg*:find lead 1 true)]
          (when (not= nil start) arg*)))))))

(fn setup []
  "Sets up Soup navigation commands."

  (vim.api.nvim_create_user_command :Soup
    (fn [repl]
      (local cmd
        (do
          (var cmd cmds)
          (each [_ farg (ipairs repl.fargs)]
            (local subcmd (. cmd farg))
            (if
              (not= nil subcmd) (set cmd subcmd)
              (error (.. "invalid subcommand: " farg))))
          cmd))
      (if
        (= :function (type cmd)) (cmd repl)
        (error "missing subcommand")))
    {:complete comp :count 0 :desc "Soup commands." :nargs :+})

  (let [map vim.keymap.set]
    (map :n "[b" "<Cmd>Soup buf prev<CR>" {:desc "Buffer previous"})
    (map :n "]b" "<Cmd>Soup buf next<CR>" {:desc "Buffer next"})
    (map :n :gb "<Cmd>Soup buf goto<CR>" {:desc "Buffer goto"})
    (map :n :gB "<Cmd>Soup buf del<CR>" {:desc "Buffer delete"})))

{: setup}
