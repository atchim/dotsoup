(import-macros {: ordef} :fnl.soup.macros)

(fn map_args [maps ?opts ?descf ?desc ?keys]
  "Iterator over mappings for the `which-key.nvim` plugin.
  
  Each iteration will return a list and a buffer number which may be `nil`. The
  list contains arguments for the `vim.api.nvim_set_keymap`. The buffer
  number may be used for the `vim.api.nvim_buf_set_keymap` variant.

  `maps` must be a table structured in the same way as the first argument for
  the `register` function from the `which-key.nvim` plugin.

  `?opts` must be an optional table with options for the mappings defined in
  `maps`, and it follows the same structure as the second argument for the
  `register` function from the `which-key.nvim` plugin. It defaults the same
  way as for the plugin. See more in https://github.com/folke/which-key.nvim.

  `?descf` must be an optional callback function for defining the description
  of a mapping based on an \"accumulated\" string formed from names of
  ancestors groups, and the current description of the mapping.

  `?descf` takes two arguments in which the first one is the accumulated string
  and the second one is the current group name or mapping description. It must
  return a string.

  `?descf` defaults for a function which will check if the accumulated string
  is not empty. Case it's true, the function will turn lowercase the first
  letter of the current description and will join and return the accumulated
  string with it separated by a space. Otherwise, it will return the current
  description as is.

  `?desc` and `?keys` are parameters intended for internal use."

  (local descf
    (if (= nil ?descf)
      (fn [acc desc]
        (if (= "" acc) desc (.. acc " " (desc:gsub "^%u" string.lower))))
      ?descf))
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
    (local buffer (?. ?opts :buffer))
    (local noremap (ordef (?. ?opts :noremap) true))
    (local nowait (?. ?opts :nowait))
    (local silent (ordef (?. ?opts :silent) true))
    (values [mode keys cmd {: desc : noremap : nowait : silent}] buffer))

  (let [gname (?. maps :name)]
    (when gname
      (set desc (descf desc gname))))

  (coroutine.wrap
    #(each [key val (pairs maps)]
      (local keys (.. keys key))
      (match [key val]
        [:name _] nil
        [_ [cmd desc+]]
          (let [desc (descf desc desc+)]
            (coroutine.yield (mkargs keys cmd desc)))
        _ (each [args buffer (map_args val ?opts descf desc keys)]
            (coroutine.yield args buffer))))))

(fn map [maps ?opts ?descf]
  "Creates key mappings.

  Primarily, this function attempts to create mappings using the `register`
  function from `which-key`. If not able to do that, it fallbacks to
  `nvim_set_keymap` or `nvim_buf_set_keymap` function from Neovim's API.

  The arguments required by this functions and their descriptions are the same
  as in the `map_args` function."

  (local bkmap vim.api.nvim_buf_set_keymap)
  (local kmap vim.api.nvim_set_keymap)
  (local (ok? which-key) (pcall require :which-key))
  (if ok?
    (which-key.register maps ?opts)
    (each [args buf (map_args maps ?opts ?descf)]
      (if (= nil buf) (kmap (unpack args)) (bkmap buf (unpack args))))))

(fn init []
  "Set key mappings."
  (map
    { ; Diagnostics
      :<Leader>k
        [ "<Cmd>lua vim.diagnostic.open_float()<CR>"
          "Diagnostic show from line"]
      "[d"
        [ "<Cmd>lua vim.diagnostic.goto_prev()<CR>"
          "Diagnostic go to previous"]
      "]d"
        [ "<Cmd>lua vim.diagnostic.goto_next()<CR>"
          "Diagnostic go to next"]

      ; Togglers
      :<Leader>t
        { :name :Toggle
          :l ["<Cmd>setlocal list!<CR>" "Local listing"]
          :L ["<Cmd>set list!<CR>" "Global listing"]
          :s ["<Cmd>setlocal spell!<CR>" "Local spelling"]
          :S ["<Cmd>set spell!<CR>" "Global spelling"]}})
  (map {:<Leader>y ["\"+y" "CTRL-C-like yank to clipboard"]} {:mode :v})
  (map {:<Leader>p ["\"_dP" "Register-safe paste"]} {:mode :x}))

{ : init
  : map_args
  : map}
