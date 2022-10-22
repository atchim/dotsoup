(import-macros {: ordef} :fnl.soup.macros)

(fn split [s ?sep ?i]
  "Return an iterator for splitting text according with an arbitrary separator.

  `s` must be a string in which the iterator will try to split. The splitted
  string will be returned as two values, which are the indexes of the start
  and the end of the split respectively.

  `?sep` is an optional Lua pattern string denoting the separator. It defaults
  to `:%s+`, which means that any sequence of spaces will be interpreted as a
  separator. `?i` is an optional index number which denotes where to start to
  split. It defaults to the beginning of `s`."

  (local len (length s))
  (local sep (ordef ?sep "%s+"))
  (var offset (ordef ?i 1))
  (var exhausted? false)

  (fn []
    ; Strip off leading separators.
    (local (start end)
      (let [(start end) (s:find sep offset)]
        (if (= 1 start)
          (do
            (set offset (+ 1 end))
            (s:find sep offset))
          (values start end))))

    (if
      exhausted? nil
      (not= nil start)
        (let [old-offset offset]
          (set exhausted? (= len end))
          (set offset (+ 1 end))
          (values old-offset (- start 1)))
      ; Pick remaining range.
      (do
        (set exhausted? true)
        (values offset len)))))

{: split}
