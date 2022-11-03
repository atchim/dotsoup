(local M {})

(fn bufnr [opts? self?]
  "Expands to accessing `self?.bufnr` if `opts?.bufnr?`, otherwise `0`."
  (if (?. opts? :bufnr?) `(. ,self? :bufnr) `0))

(fn M.bo [opt opts? self?]
  "Expands to getting buffer `opt`."
  `(?. _G.vim.bo ,(bufnr opts? self?) ,opt))

(fn M.termstatus [opts?]
  "Expands to a built terminal buffer status line.

  `opts?` is an optional table containing the following optional fields:
    - `bufnr?`: Whether the built status line uses the `self.bufnr` field.
    - `cwd?`: Whether the built status line shows the CWD.
    - `shortcmd?`: Whether the built status line shortens the command name."

  `(let
    [ proto#
      { :init
        (fn [self#]
          (let
            [ name# (api.nvim_buf_get_name ,(bufnr opts? `self#))
              (_# _# cwd# pid# cmd#) (name#:find "term://(.+)//(.+):(.+)")]
            ,(when (?. opts? :cwd?) `(set self#.cwd cwd#))
            (set self#.pid pid#)
            (set self#.cmd cmd#)))}
      pid#
      {:provider (fn [self#] (.. " " self#.pid)) :hl {:fg hl.num.fg}}
      cmd#
      { :provider
        (fn [self#]
          (let
            [ cmd#
              ,(if (?. opts? :shortcmd?)
                `(_G.vim.fn.fnamemodify self#.cmd ::t)
                `self#.cmd)]
            (.. " " cmd#)))
        :hl {:fg hl.ty.fg}}]
    ,(if (?. opts? :cwd?)
      `(let
        [ cwd#
          { :condition
            (fn [self#]
              (not= (_G.vim.fn.expand self#.cwd) (_G.vim.fn.getcwd 0 0)))
            :provider
            (fn [self#] (.. " " (_G.vim.fn.fnamemodify self#.cwd ::.) " "))
            :hl {:fg hl.dir.fg}}]
        (insert proto# space cwd# pid# space cmd#))
      `(insert proto# space pid# space cmd#))))

(fn M.buf [opts?]
  "Expands to a buffer status line.

  `opts?` is an optional table containing the following optional fields:
    - `bufnr?`: Whether the built status line uses the `self.bufnr` field.
    - `termcwd?`: Whether the built terminal buffer status line shows the CWD.
    - `short?`: Whether the built status line is short."

  `(let
    [ proto#
      { :init
          (fn [self#]
            (set self#.type ,(M.bo :buftype opts? `self#))
            (set self#.name (api.nvim_buf_get_name ,(bufnr opts? `self#))))}
      flags#
      (tbldx
        :force
        [ { :provider " "
            :condition
            (fn [self#]
              (let [bo# (. _G.vim.bo ,(bufnr opts? `self#))]
                (or (not bo#.modifiable) bo#.readonly)))
            :hl {:fg hl.err.fg}}
          { :provider "➕ "
            :condition (fn [self#] ,(M.bo :modified opts? `self#))
            :hl {:fg hl.string.fg}}]
        {:condition (fn [self#] (not= self#.type :terminal))})
      name#
      (tbldx
        :force
        [ { :condition (fn [self#] (not= self#.type :terminal))
            :provider
            (fn [self#]
              (let
                [ name# (_G.vim.fn.fnamemodify self#.name ::.)
                  noname# (= name# "")]
                (set self#.noname noname#)
                (if noname#
                  "[No Name]"
                  ,(if (?. opts? :short?)
                    `(_G.vim.fn.fnamemodify name# ::t)
                    `(if (w%<? (length name#) 0.25)
                      name#
                      (_G.vim.fn.pathshorten name#))))))
            :hl
            (fn [self#] {:fg (?. hl (if self#.noname :comment :ty) :fg)})}
          ,(M.termstatus
            { :bufnr? (?. opts? :bufnr?)
              :cwd? (?. opts? :termcwd?)
              :shortcmd? (?. opts? :short?)})]
        {:fallthrough false})
      icon#
      { :init
        (fn [self#]
          (let
            [ ft#
              (if (= self#.type :terminal)
                :terminal
                ,(M.bo :filetype opts? `self#))]
            (set
              (self#.icon self#.icon_color)
              (values
                (modcall
                  :nvim-web-devicons
                  :get_icon_color_by_filetype
                  (ft# {:default true}))))))
        :provider (fn [self#] self#.icon)
        :hl (fn [self#] {:fg self#.icon_color})}]
    (insert proto# icon# space flags# name#)))

M
