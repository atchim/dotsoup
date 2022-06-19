(fn call [mod sub ...]
  "Expands to a call of function `sub` from `mod` with arguments `...`."
  (local sub (if (= :string (type sub)) [sub] sub))
  `((->
      (require ,mod)
      ,(unpack (icollect [_ sub# (ipairs sub)] `(. ,sub#))))
    ,...))

(fn calls [func mod ...]
  "Expands to a sequence of function calls to `func` for all submodules of
  `mod` specified in `[...]`."
  `(do
    ,(unpack
      (icollect [_ sub (ipairs [...])]
        `((-> ,(.. mod :. sub) (require) (. ,func)))))))

(fn get [mod ...]
  "Expands to an access of a module and, optionally its nested items."
  `(-> (require ,mod) (?. ,...)))

(fn oneof? [x ...]
  "Expands to an `or` form, like `(or (= x y) (= x z) ...)`."
  `(or ,(unpack (icollect [_ y (ipairs [...])] `(= ,x ,y)))))

(fn ordef [val def]
  "Expands to an `if` expression that returns a non-nil value `val` or its
  default `def`."
  `(if (not= nil ,val) ,val ,def))

(fn ty= [val ...]
  "Expands to an assertion that type of `val` is one of the given ones."
  (local msg (.. "`" (tostring val) "`is not " (table.concat [...] " or ")))
  `(let [ty# (type ,val)]
    (assert ,(oneof? `ty# ...) ,msg)))

{ : call
  : calls
  : get
  : oneof?
  : ordef
  : ty=}
