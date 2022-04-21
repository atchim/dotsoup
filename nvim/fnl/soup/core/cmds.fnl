(import-macros {: call} :fnl.soup.macros)

(macro vcount-or-1 []
  "Expand to `v:count` if isn't 0, otherwise expands to 1."
  `(let [n# vim.v.count] (if (= 0 n#) 1 n#)))

(local cmds
  { :buf
      { :del #(pcall vim.api.nvim_buf_delete vim.v.count {})
        :goto #(pcall vim.api.nvim_set_current_buf vim.v.count)
        :next #(vim.cmd (.. "bnext " (vcount-or-1)))
        :prev #(vim.cmd (.. "bprevious " (vcount-or-1)))}})

(fn comp [lead line pos]
  "Complete function for the `Soup` command."

  (local args
    (let [[_ start _] (vim.fn.matchstrpos line "S\\%[oup] *\\zs.*")]
      (local {: split} (require :soup.utils))
      (icollect [start end (split line :%s+ (+ 1 start))]
        (if (and (< start pos) (< end pos))
          (line:sub start end)
          nil))))

  (local (subcmd broken?)
    (do
      (var subcmd cmds)
      (var broken? false)
      (each [_ arg* (ipairs args) :until broken?]
        (local item (. subcmd arg*))
        (if (= :table (type item))
          (set subcmd item)
          (set broken? true)))
      (values subcmd broken?)))

  (if broken?
    []
    (let [lead (lead:sub 1 pos)]
      (vim.fn.sort (icollect [arg* _ (pairs subcmd)]
        (let [(start _) (arg*:find lead 1 true)]
          (if (not= nil start) arg* nil)))))))

(fn init []
  "Add user commands."

  (vim.api.nvim_create_user_command :Soup
    (fn [repl]
      (local cmd
        (do
          (var cmd cmds)
          (each [_ farg (ipairs repl.fargs)]
            (local subcmd (. cmd farg))
            (if (not= nil subcmd)
              (set cmd subcmd)
              (error (.. "invalid subcommand: " farg))))
          cmd))
      (if (= :function (type cmd))
        (cmd repl)
        (error "missing subcommand")))
    { :complete comp
      :count 0
      :desc "Soup commands."
      :nargs :+})

  (call :soup.core.maps :map
    { "[b" ["<Cmd>Soup buf prev<CR>" "Buffer previous"]
      "]b" ["<Cmd>Soup buf next<CR>" "Buffer next"]
      :gb ["<Cmd>Soup buf goto<CR>" "Buffer goto"]
      :gB ["<Cmd>Soup buf del<CR>" "Buffer delete"]}))

{: init}
