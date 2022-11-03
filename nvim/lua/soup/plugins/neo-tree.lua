local M = {}
M.config = function()
  vim.g.neo_tree_remove_legacy_commands = 1
  local function _1_()
    vim.wo.cursorlineopt = "line"
    return nil
  end
  do end (require("neo-tree")).setup({filesystem = {use_libuv_file_watcher = true}, event_handlers = {{event = "neo_tree_buffer_enter", handler = _1_}}, window = {mappings = {["."] = "toggle_hidden", ["/"] = "filter_as_you_type", ["<C-C>"] = "clear_filter", ["<C-U>"] = "navigate_up", ["<C-]>"] = "set_root", ["?"] = "show_help", a = "add", d = "delete", f = "filter_on_submit", i = "open_split", I = "split_with_window_picker", m = "move", o = "open", O = "open_with_window_picker", p = "paste_from_clipboard", q = "close_window", r = "rename", R = "refresh", s = "open_vsplit", S = "vsplit_with_window_picker", t = "open_tabnew", x = "cut_to_clipboard", y = "copy_to_clipboard", za = "toggle_node", zc = "close_node", zC = "close_all_nodes"}, width = 32}, use_default_mappings = false})
  return (require("soup.core.maps")).map({name = "Neo Tree", ["<Space>"] = {"<Cmd>Neotree toggle<CR>", "Toggle"}, ["<CR>"] = {"<Cmd>Neotree focus<CR>", "Focus"}}, {prefix = "<Leader><Space>"})
end
return M
