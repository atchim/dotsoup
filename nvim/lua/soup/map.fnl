(import-macros {: ordef : ty=} :soupmacs.soupmacs)

(local labels [])

(fn map-args [maps ?opts descf ?desc ?lhs]
  "Returns an iterator and labels for `which-key.nvim` plugin.
  
  This function returns two values; the first being the iterator, and the
  second being mapping labels to be registered later by Which Key.

  Each iteration returns a sequence containing arguments for the
  `vim.keymap.set` function.

  `maps`, `?opts` and `descf` follow, respectively, the same rules for the
  `maps`, `?opts` and `?descf` arguments for the `map!` function with the
  exception that `descf` is required.

  `?desc` must be the optional mapping description string, and `?lhs` must be
  the optional mapping LHS string."

  (fn mkargs [lhs rhs desc]
    "Returns a sequence with arguments for the `vim.keymap.set` function."
    (let
      [ mode (ordef (?. ?opts :mode) :n)
        pfx (?. ?opts :prefix)
        lhs (if pfx (.. pfx lhs) lhs)
        buffer (?. ?opts :buffer)
        noremap (?. ?opts :noremap)
        nowait (?. ?opts :nowait)
        silent (ordef (?. ?opts :silent) true)]
      [mode lhs rhs {: buffer : desc : noremap : nowait : silent}]))

  (var desc (ordef ?desc ""))
  (let [labels {} lhs (ordef ?lhs "") ?name (?. maps :name)]
    (when ?name (set desc (descf desc ?name)))
    (values
      (coroutine.wrap
        #(each [key val (pairs maps)]
          (local lhs (.. lhs key))
          (match [key val]
            [:name name] (set labels.name name)
            [_ [rhs desc*]]
            (let [desc (descf desc desc*)]
              (tset labels key desc*)
              (coroutine.yield (mkargs lhs rhs desc)))
            (where [_ [s]] (ty= s :string)) (tset labels key s)
            (where [_ s] (ty= s :string)) (tset labels key s)
            (where [_ t] (ty= t :table))
            (let [(iter labels*) (map-args val ?opts descf desc lhs)]
              (tset labels key labels*)
              (each [args iter] (coroutine.yield args))))))
      [labels ?opts])))

(fn map! [maps ?opts ?descf]
  "Creates key mappings.

  Primarily, this function attempts to create mappings using the `register`
  function from the `which-key` module if able. Otherwise, it fallbacks to the
  `vim.keymap.set` function, and it stores the keymap labels to be registered
  later by Which Key.

  `maps` must be a table structured in the same way as the first argument for
  the `register` function from the `which-key` module.

  `?opts` must be an optional table with options for the mappings defined in
  `maps`, and it must follow the same structure as the second argument for the
  `register` function from the `which-key.nvim` plugin. It defaults exactly
  as the plugin. See more in https://github.com/folke/which-key.nvim.

  `?descf` must be an optional callback function for defining the description
  of a mapping based on an \"accumulated\" string formed from names of
  ancestors groups and the current description of the mapping.

  `?descf` takes two arguments; the first one is the accumulated string and
  the second one is the current group name or mapping description. It must
  return a string.

  `?descf` defaults for a function that checks if the accumulated string is
  not empty. Case it's true, the function turns lowercase the first letter of
  the current description, joins both strings with a space, and then returns
  it. Otherwise, it returns the current description as is."

  (let [(ok? which-key) (pcall require :which-key)]
    (if ok?
      (which-key.register maps ?opts)
      (let
        [ descf
          (ordef
            ?descf
            (fn [acc desc]
              (if (= "" acc)
                desc
                (.. acc " " (desc:gsub "^%u" string.lower)))))
          (iter labels*) (map-args maps ?opts descf)
          kmap vim.keymap.set]
        (table.insert labels labels*)
        (each [args iter] (kmap (unpack args)))))))

(setmetatable
  {}
  { :__call (fn [_ maps ?opts ?descf] (map! maps ?opts ?descf))
    :__index {: labels}})
