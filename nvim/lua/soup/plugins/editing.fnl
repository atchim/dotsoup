(import-macros {: modcall} :soupmacs.soupmacs)

(fn config [_ opts]
  "Post-load configuration hook."

  (local npairs (require :nvim-autopairs))
  (npairs.setup opts)

  (let [cmp (require :cmp) cmp-autop (require :nvim-autopairs.completion.cmp)]
    (cmp.event:on :confirm_done (cmp-autop.on_confirm_done)))

  ; Fixes weird behavior in lisp-like filetypes.
  (let
    [ cond (require :nvim-autopairs.conds)
      rule (require :nvim-autopairs.rule)
      lispies [:fennel :query]
      pairies ["(" "[" "{"]
      pairies* [")" "]" "}"] ]
    (each [_ pairy (ipairs pairies)]
      (-> (npairs.get_rule pairy) (tset :not_filetypes lispies)))
    (each [i pairy (ipairs pairies)]
      (npairs.add_rule
        (-> (rule pairy (. pairies* i) lispies)
          (: :with_pair (cond.not_after_regex :%w)))))))

[ { 1 :echasnovski/mini.comment
    :event :BufRead
    :opts
    { :hooks
      { :pre
        #(modcall
          :ts_context_commentstring.internal
          :update_commentstring
          [])}
      :options {:pad_comment_parts false}}
    :config (fn [_ opts] (modcall :mini.comment :setup opts))
    :dependencies :JoosepAlviste/nvim-ts-context-commentstring}
  {1 :kylechui/nvim-surround :event :BufRead :config true}
  { 1 :windwp/nvim-autopairs
    :event :InsertCharPre
    :opts
    { :check_ts true
      :fast_wrap
      { :map :<M-e>
        :chars ["{" "[" "(" "\"" "'"]
        :pattern "[%'%\"%>%]%)%}%,]"
        :end_key :$
        :keys :jkflahdsg
        :check_comma true
        :highlight :Search
        :highlight_grey :Comment}}
    : config
    :dependencies :hrsh7th/nvim-cmp}]
