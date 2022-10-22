local function config()
  do end (require("indent_blankline")).setup({enabled = false, show_current_context = true, show_current_context_start = true})
  return (require("which-key")).register({i = {"<Cmd>IndentBlanklineToggle<CR>", "Indent Blankline"}}, {prefix = "<Leader>t"})
end
return {config = config}
