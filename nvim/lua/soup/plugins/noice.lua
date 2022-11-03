local M = {}
M.config = function()
  return (require("noice")).setup({cmdline = {enabled = true, view = "cmdline_popup"}, messages = {enabled = true}, popupmenu = {enabled = true, backend = "nui"}, views = {cmdline_popup = {border = {padding = {1, 2}, style = "none"}, filter_options = {}}}})
end
return M
