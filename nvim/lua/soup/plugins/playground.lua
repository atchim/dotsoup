local function config()
  return (require("which-key")).register({p = {"<Cmd>TSPlaygroundToggle<CR>", "Tree-Sitter Playground"}}, {prefix = "<Leader>t"})
end
return {config = config}
