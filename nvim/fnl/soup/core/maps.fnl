(import-macros {: ordef : ty=} :soupmacs.soupmacs)
(local M {})

(set M.labels [])

(fn M.map_args [maps ?opts ?descf ?desc ?keys]
  "Returns an iterator over mappings, and labels for `which-key.nvim` plugin.
  
  This function returns two values; the first being the iterator, and the
  second being label mappings to be registered later by Which Key.

  Each iteration returns a list and a buffer number which may be `nil`. The
  list contains arguments for the `vim.api.nvim_set_keymap`. The buffer number
  may be used for the `vim.api.nvim_buf_set_keymap` variant.

  `maps` is a table structured in the same way as the first argument for the
  `register` function from the `which-key.nvim` plugin.

  `?opts` is an optional table with options for the mappings defined in `maps`,
  and it follows the same structure as the second argument for the `register`
  function from the `which-key.nvim` plugin. It defaults exactly as the plugin.
  See more in https://github.com/folke/which-key.nvim.

  `?descf` is an optional callback function for defining the description of a
  mapping based on an \"accumulated\" string formed from names of ancestors
  groups, and the current description of the mapping.

  `?descf` takes two arguments in which the first one is the accumulated string
  and the second one is the current group name or mapping description. It
  returns a string.

  `?descf` defaults for a function that checks if the accumulated string is not
  empty. Case it's true, the function turns lowercase the first letter of the
  current description, joins both strings with a space, and then returns it.
  Otherwise, it returns the current description as is.

  `?desc` and `?keys` are parameters intended for internal use."

  (local descf
    (ordef
      ?descf
      (fn [acc desc]
        (if (= "" acc) desc (.. acc " " (desc:gsub "^%u" string.lower))))))
  (var desc (ordef ?desc ""))
  (local keys (ordef ?keys ""))

  (fn mkargs [keys cmd desc]
    "Returns built arguments for the Neovim's keymap functions.

    This function mixes the information provided by its arguments with the
    information from the `?opts` table in order to generate arguments with
    inherited options.

    This function returns two values; the first being the argument list, and
    the second being the buffer number, which may be nil.

    `keys` is the key sequence to bind the command to. The command defined by
    the `cmd` argument may be a string or function. `desc` is the description
    for the mapping."

    (local mode (ordef (?. ?opts :mode) :n))
    (local keys (.. (ordef (?. ?opts :prefix) "") keys))
    (local buf (?. ?opts :buffer))
    (local noremap (ordef (?. ?opts :noremap) true))
    (local nowait (?. ?opts :nowait))
    (local silent (ordef (?. ?opts :silent) true))
    (values [mode keys cmd {: desc : noremap : nowait : silent}] buf))

  (let [gname (?. maps :name) labels {}]
    (when gname (set desc (descf desc gname)))
    (values
      (coroutine.wrap
        #(each [key val (pairs maps)]
          (local keys (.. keys key))
          (match [key val]
            [:name name] (set labels.name name)
            [_ [cmd desc*]]
            (let [desc (descf desc desc*)]
              (tset labels key desc*)
              (coroutine.yield (mkargs keys cmd desc)))
            (where [_ [s]] (ty= s :string)) (tset labels key s)
            (where [_ s] (ty= s :string)) (tset labels key s)
            (where [_ t] (ty= t :table))
            (let [(iter labels*) (M.map_args val ?opts descf desc keys)]
              (tset labels key labels*)
              (each [args buf iter] (coroutine.yield args buf))))))
      labels)))

(fn M.map [maps ?opts ?descf]
  "Creates key mappings.

  Primarily, this function attempts to create mappings using the `register`
  function from `which-key`. If not able to do that, it fallbacks to
  `nvim_set_keymap` or `nvim_buf_set_keymap` function from Neovim's API.

  The arguments required by this functions and their descriptions are the same
  as in the `map_args` function."

  (let
    [ api vim.api
      bkmap api.nvim_buf_set_keymap
      kmap api.nvim_set_keymap
      (ok? which-key) (pcall require :which-key)]
    (if ok?
      (which-key.register maps ?opts)
      (let [(iter labels) (M.map_args maps ?opts ?descf)]
        (table.insert M.labels [labels ?opts])
        (each [args buf iter]
          (if (= nil buf) (kmap (unpack args)) (bkmap buf (unpack args))))))))

(fn M.init []
  "Sets key mappings."
  (M.map
    { ; Diagnostics
      :<Leader>k
      ["<Cmd>lua vim.diagnostic.open_float()<CR>" "Diagnostic show from line"]
      "[d"
      ["<Cmd>lua vim.diagnostic.goto_prev()<CR>" "Diagnostic go to previous"]
      "]d"
      ["<Cmd>lua vim.diagnostic.goto_next()<CR>" "Diagnostic go to next"]

      ; Togglers
      :<Leader>t
      { :name :Toggle
        :l ["<Cmd>setlocal list!<CR>" "Local listing"]
        :s ["<Cmd>setlocal spell!<CR>" "Local spelling"]}

      :<Leader>y ["\"+yy" "CTRL-C-like yank to clipboard"]})
  (M.map {:<Leader>y ["\"+y" "CTRL-C-like yank to clipboard"]} {:mode :v})
  (M.map {:<Leader>p ["\"_dP" "Register-safe paste"]} {:mode :x}))

M
