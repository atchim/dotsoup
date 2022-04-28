(_) @node

; Function
(fn . name: (_)? . (parameters) . docstring: (_)? (_) @swappable)
(parameters (_) @swappable)
; Let Binding
(let . (let_clause) (_) @swappable)
( (let_clause . ((_) . (_))* . (_) @_start . (_) @_end)
  (#make-range! "swappable" @_start @_end))
; List
( (list . (symbol) @_symbol (_) @swappable)
  (#not-eq? @_symbol "macro"))
( (list . (symbol) @_symbol . (symbol) . (sequential_table) (_) @swappable)
  (#eq? @_symbol "macro"))
; Match
( (match . (_) . ((_) . (_))* . (_) @_start . (_) @_end)
  (#make-range! "swappable" @_start @_end))
; Sequential Table
(sequential_table (_) @swappable)
(quoted_sequential_table (_) @swappable)
(sequential_table_binding (_) @swappable)
; Table
( (table . ([":" (_)] . (_))* . [":" (_)] @_start . (_) @_end)
  (#make-range! "swappable" @_start @_end))
( (quoted_table . ((_) . (_))* . (_) @_start . (_) @_end)
  (#make-range! "swappable" @_start @_end))
( (table_binding . ([":" (_)] . (_))* . [":" @_start (_) @_start] . (_) @_end)
  (#make-range! "swappable" @_start @_end))
