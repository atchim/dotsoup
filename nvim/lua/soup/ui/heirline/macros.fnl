; TODO: Context status line using both LSP and Tree-Sitter.
; <https://github.com/SmiteshP/nvim-navic>

(local (bind! symbol)
  (let
    [ symbols {}
      names
      { :devicons true
        :heirline-conditions true
        :heirline-utils true
        :L*-normal true
        :L*-comment true
        :L*-linenr true
        :nonnil true
        :statusline-space true
        :vim-api true}]
    (values
      (fn [symbols*]
        "Binds symbols."
        (each [name sym (pairs symbols*)]
          (assert-compile (. names name) "invalid symbol" name)
          (tset symbols name (assert-compile (sym? sym) "not a symbol" sym))))
      (fn [name]
        "Returns the value for symbol with `name`."
        (assert (. names name) (-> "invalid symbol \"%s\"" (: :format name)))
        (assert
          (. symbols name)
          (-> "symbol \"%s\" not bound" (: :format name)))))))

(fn vimode []
  "Shorthand for mode status line."
  (let [api (symbol :vim-api)]
    `{:static {:aliases {"no\22" :no^V "\22" :^V "\22s" :^Vs "\19" :^S}}
      :init
      (fn [self#]
        (set self#.mode (vim.fn.mode 1))
        (when (not self#.init?)
          (let
            [ group#
              ( (-> ,api (. :nvim_create_augroup))
                :soup_plugin_heirline_statusln_init
                {})]
            ( (-> ,api (. :nvim_create_autocmd))
              :ModeChanged
              {:group group# :pattern :*:*o :command :redrawstatus}))
          (set self#.init? true)))
      :provider
      (fn [self#]
        (..
          "  %-4.4("
          (or (?. self#.aliases self#.mode) self#.mode)
          "%) ▒"))
      :hl (fn [self#] {:fg self#.mode :reverse true})
      :update :ModeChanged}))

(fn githead []
  "Shorthand for Git `HEAD` status line."
  (let [utils (symbol :heirline-utils) space (symbol :statusline-space)]
    `(let
      [ proto#
        { :condition
          (fn [self#]
            (let [head# (or vim.b.gitsigns_head vim.g.gitsigns_head)]
              (when head# (set self#.head head#) true)))}
        head#
        { :provider (fn [self#] (.. "  " self#.head " ▒"))
          :hl {:fg :githead :reverse true}}
        {:insert insert#} ,utils]
      (insert# proto# head# ,space))))

(fn term [kind]
  "Shorthand for terminal buffer status line."

  (let
    [ api (symbol :vim-api)
      buf? (= kind :buf)
      bufnr (if buf? (fn [self] `(-> ,self (. :bufnr))) (fn [_self] 0))
      nonnil (symbol :nonnil)
      status? (= kind :status)
      utils (symbol :heirline-utils)]
    `(let
      [ {:insert insert#} ,utils
        proto#
        { :condition (fn [self#] (= self#.bufty :terminal))
          :init
          (fn [self#]
            (let
              [ name# ((-> ,api (. :nvim_buf_get_name)) ,(bufnr `self#))
                (_# _# cwd# pid# cmd#) (name#:find "term://(.+)//(.+):(.+)")]
              ,(when status?
                `(do
                  (set self#.cwd cwd#)
                  (set self#.showcwd?
                    (not= (vim.fn.expand cwd#) (vim.fn.getcwd 0 0)))
                  (set self#.pid pid#)))
              (set self#.cmd cmd#)))}
        icon-space#
        { :provider " "
          :hl (fn [self#] {:fg self#.icon-color :reverse ,status?})}
        cmd#
        { :provider
          (fn [self#]
            (let
              [cmd# ,(if buf? `(vim.fn.fnamemodify self#.cmd ::t) `self#.cmd)]
              ,(if status? `(.. " " cmd# " ▒") `cmd#)))
          :hl
          (fn [self#]
            {:fg ,(if status? :termcmd `self#.icon-color) :reverse ,status?})}]

      (var cwd?# nil)
      (var |pid?# nil)
      (var pid?# nil)
      (var |cmd# space)

      ,(when status?
        `(let
          [ cwdproto# {:condition (fn [self#] self#.showcwd?)}
            icon|cwd#
            {:provider :▒ :hl (fn [self#] {:bg self#.icon-color :fg :termcwd})}
            cwd#
            { :provider
              ; TODO: Use two dots instead of printing "whole" path.
              (fn [self#] (.. " " (vim.fn.fnamemodify self#.cwd ::.)))
              :hl {:fg :termcwd :reverse ,status?}}]
          (set cwd?# (insert# cwdproto# icon|cwd# cwd#))
          (set |pid?#
            { :provider :▒
              :hl
              (fn [self#]
                { :bg (if self#.showcwd? :termcwd self#.icon-color)
                  :fg :termpid})})
          (set pid?#
            { :provider (fn [self#] (.. " " self#.pid))
              :hl {:fg :termpid :reverse ,status?}})
          (set |cmd# {:provider :▒ :hl {:bg :termpid :fg :termcmd}})))
      (insert#
        (unpack (,nonnil proto# icon-space# cwd?# |pid?# pid?# |cmd# cmd#))))))

(fn buf [kind]
  "Shorthand for buffer status line.

  `kind` must be a string denoting which kind of status bar to build. Its
  possible values are `\"buf\"`, `\"status\"` and `\"win\"`."

  (let
    [ api (symbol :vim-api)
      buf? (= :buf kind)
      bufnr (if buf? (fn [self] `(-> ,self (. :bufnr))) (fn [_self] 0))
      bo
      (if buf?
        (fn [self opt] `(-> vim.bo (. ,(bufnr self)) (. ,opt)))
        (fn [_self opt] `(. vim.bo ,opt)))
      conditions (symbol :heirline-conditions)
      devicons (symbol :devicons)
      utils (symbol :heirline-utils)
      L*-normal (symbol :L*-normal)
      L*-comment (symbol :L*-comment)
      L*-linenr (symbol :L*-linenr)
      nonnil (symbol :nonnil)
      status? (= :status kind)
      win? (= :win kind)]
    `(let
      [ {:width_percent_below w%<?#} ,conditions
        {:clone clone# :insert insert# } ,utils
        proto#
        { :init
          (fn [self#]
            (let
              [ bufty# ,(bo `self# :buftype)
                ft# (if (= bufty# term#) term# ,(bo `self# :filetype))
                locked?#
                (let [bo# (. vim.bo ,(bufnr `self#))]
                  (or (not bo#.modifiable) bo#.readonly))
                mod?# ,(bo `self# :modified)
                term# :terminal
                {:get_icon_color_by_filetype icon-color-by-ft#} ,devicons
                (icon# color#) (icon-color-by-ft# ft# {:default true})
                active?# ,(if win? `(. ,conditions :is_active) `nil)
                name# ((-> ,api (. :nvim_buf_get_name)) ,(bufnr `self#))]
              (set self#.locked? locked?#)
              (set self#.mod? mod?#)
              (set self#.bufty bufty#)
              (set self#.icon icon#)
              (set self#.icon-color
                ,(if
                  buf?
                  `(if
                    self#.is_active (,L*-normal color#)
                    self#.is_visible (,L*-comment color#)
                    (,L*-linenr color#))
                  win?
                  `(if (active?#)
                    (,L*-normal color#)
                    (,L*-comment color#))
                  `(,L*-normal color#)))
              (set self#.name name#)))}
        flags#
        (clone#
          (let
            [ locked#
              { :condition (fn [self#] self#.locked?)
                :provider ,(let [icon# :] (if status? (.. " " icon#) icon#))
                :hl {:fg :buflocked :reverse ,status?}}
              mod#
              { :condition (fn [self#] self#.mod?)
                :provider :➕
                :hl {:fg :bufmod :reverse ,status?}}]
            [ locked#
              { :condition (fn [self#] self#.mod?)
                :provider
                ,(if status? `(fn [self#] (if self#.locked? :▒ " ")) " ")
                :hl
                ,(when status?
                  `(fn [self#]
                    (if self#.locked?
                      {:bg :buflocked :fg :bufmod}
                      {:bg :bufmod})))}
              mod#])
          {:condition (fn [self#] (not= self#.bufty :terminal))})
        icon#
        { :provider (fn [self#] self#.icon)
          :hl (fn [self#] {:fg self#.icon-color :reverse ,status?})}
        ty#
        (clone#
          [,(term kind)
            { :provider
              (fn [self#]
                (let
                  [name# (vim.fn.fnamemodify self#.name ::.)]
                  (..
                    " "
                    ,(if buf?
                      `(vim.fn.fnamemodify name# ::t)
                      ; TODO: Add shorten threshold.
                      `(if (w%<?# (length name#) 0.25)
                        name#
                        (vim.fn.pathshorten name#)))
                    ,(when status? " ▒"))))
              :hl (fn [self#] {:fg self#.icon-color :reverse ,status?})}]
          {:fallthrough false})]
      (var flags|icon?# nil)
      ,(if status?
        `(set flags|icon?#
          {:provider
            (fn [self#]
              (if
                (and
                  (not= self#.bufty :terminal)
                  (or self#.locked? self#.mod?))
                :▒
                " "))
            :hl
            (fn [self#]
              (if
                (and (not= self#.bufty :terminal) self#.mod?)
                {:bg :bufmod :fg self#.icon-color}
                (and (not= self#.bufty :terminal) self#.locked?)
                {:bg :buflocked :fg self#.icon-color}
                {:bg self#.icon-color}))}))
      (insert# (unpack (,nonnil proto# flags# flags|icon?# icon# ty#))))))

(fn diagn []
  "Shorthand for diagnostics status line; designed only for buffer line."
  (let [utils (symbol :heirline-utils)]
    `(let
      [ proto#
        { :condition (fn [self#] (vim.diagnostic.get self#.bufnr))
          :static 
          { :has
            (fn [self# severity#]
              (->>
                {:severity (. vim.diagnostic.severity severity#)}
                (vim.diagnostic.get self#.bufnr)
                (length)
                (< 0)))}}
        sign#
        (fn [severity#]
          (->
            (vim.fn.sign_getdefined (.. :DiagnosticSign severity#))
            (. 1)
            (. :text)))
        mksign#
        (fn [key# signsufx# hl#]
          { :condition (fn [self#] (self#:has key#))
            :static {:sign (sign# signsufx#)}
            :provider (fn [self#] self#.sign)
            :hl {:fg hl#}})
        err# (mksign# :ERROR :Error :diagnerr)
        warn# (mksign# :WARN :Warn :diagnwarn)
        info# (mksign# :INFO :Info :diagninfo)
        hint# (mksign# :HINT :Hint :diagnhint)]
      ((-> ,utils (. :insert)) proto# err# warn# info# hint#))))

(fn file []
  "Shorthand for file status line; designed for status line."
  (let [api (symbol :vim-api) utils (symbol :heirline-utils)]
    `[{ :init
        (fn [self#]
          (set self#.enc
            (or (when (not= vim.bo.fenc "") vim.bo.fenc) vim.o.enc)))
        :provider (fn [self#] (.. " " (self#.enc:upper)))
        :hl {:fg :fileenc :reverse true}}
      {:provider :▒ :hl {:bg :fileenc :fg :filefmt}}
      { :init (fn [self#] (set self#.fmt vim.bo.fileformat))
        :provider (fn [self#] (match self#.fmt :dos : :mac : :unix :))
        :hl {:fg :filefmt :reverse true}}
      {:provider :▒ :hl {:bg :filefmt :fg :fileln}}
      (let
        [ proto#
          { :init
            (fn [self#]
              (when (not self#.once)
                ( (-> ,api (. :nvim_create_autocmd))
                  :CursorMoved
                  {:pattern :*:*o :command :redrawstatus})
                (set self#.once true)))}
          ln# {:provider " %l" :hl {:fg :fileln :reverse true}}
          ln|col# {:provider :▒ :hl {:bg :fileln :fg :filecn}}
          col# {:provider "%c ▒" :hl {:fg :filecn :reverse true}}]
        ((-> ,utils (. :insert)) proto# ln# ln|col# col#))]))

(fn scroll []
  "Shorthand for status line showing the scroll."
  (let [api (symbol :vim-api)]
    `{:static {:bar [:█ :▇ :▆ :▅ :▄ :▃ :▂ :▁]}
      :provider
      (fn [self#]
        (let
          [ line# (. ((-> ,api (. :nvim_win_get_cursor)) 0) 1)
            lines# ((-> ,api (. :nvim_buf_line_count)) 0)
            i#
            (-> (/ line# lines#)
              (* (- (length self#.bar) 1))
              (+ 1)
              (math.floor))]
          (. self#.bar i#)))
      :hl {:fg :scroll}}))

(fn bufln []
  "Shorthand for buffer line."
  (let
    [ api (symbol :vim-api)
      space (symbol :statusline-space)
      utils (symbol :heirline-utils)
      insert #`((-> ,utils (. :insert)) ,$...)]
    `(let
      [ proto#
        { :init
          (fn [self#]
            (set self#.name ((-> ,api (. :nvim_buf_get_name)) self#.bufnr))
            (set self#.type (-> vim.bo (. self#.bufnr) (. :buftype))))
          :hl
          (fn [self#]
            (if self#.is_active
              {:bg :tablineselbg :fg :tablineselfg :bold true}
              {:bg :tablinebg :fg :tablinefg :bold true}))
          :on_click
          { :minwid (fn [self#] self#.bufnr)
            :callback
            (fn [_# minwid# _# button#]
              (match button#
                :l ((-> ,api (. :nvim_win_set_buf)) 0 minwid#)
                :r ((-> ,api (. :nvim_buf_delete)) minwid# {:force false})))
            :name :bufln_click_cb}}
        nr# {:provider (fn [self#] self#.bufnr)}]
      ,(insert `proto# space `nr# space (diagn) (buf :buf) space))))

(fn statusln3 []
  "Shorthand for assembling a status line designed for `laststatus=3`."
  (let [space (symbol :statusline-space) utils (symbol :heirline-utils)]
    `((-> ,utils (. :insert))
      {:hl {:bg :statuslinebg :fg :statuslinefg :bold true}}
      ,(vimode)
      ,space
      ,(githead)
      ,(buf :status)
      {:provider :%=}
      ,(file)
      ,space
      ,(scroll))))

(fn winbar []
  "Shorthand for window bar."
  (let
    [ conditions (symbol :heirline-conditions)
      space (symbol :statusline-space)
      utils (symbol :heirline-utils)]
    `(let
      [ {:is_active active?#} ,conditions
        {:clone clone#} ,utils]
      (clone#
        [,space ,(buf :win)]
        { :hl
          (fn [_self#]
            (if (active?#)
              {:bg :winbarbg :fg :winbarfg :bold true}
              {:bg :winbarncbg :fg :winbarncfg :bold true}))}))))

{: bind! : bufln : statusln3 : winbar}
