local M = {}
M.config = function()
  do end (require("ccc")).setup({})
  return (require("soup.core.maps")).map({c = {"<Cmd>CccHighlighterToggle<CR>", "Color Highlighter"}}, {prefix = "<Leader>t"})
end
return M
