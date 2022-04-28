local function config()
  do end (require("indent_blankline")).setup({show_current_context = true, show_current_context_start = true})
  return (require("which-key")).register({["|"] = {"<Cmd>IndentBlanklineToggle<CR>", "Toggle Indent Blankline"}}, {prefix = "<Leader>"})
end
return {config = config}
