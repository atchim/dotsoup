local M = {}
M.config = function()
  return (require("noice")).setup({cmdline = {enabled = true, view = "cmdline_popup"}, messages = {enabled = true}, popupmenu = {enabled = true, backend = "nui"}, routes = {{view = "notify", filter = {event = "msg_showmode"}}}, views = {cmdline_popup = {border = {padding = {1, 1}, style = "none"}, filter_options = {}}}})
end
return M
