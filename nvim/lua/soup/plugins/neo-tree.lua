local function config()
  vim.g.neo_tree_remove_legacy_commands = 1
  do end (require("neo-tree")).setup({filesystem = {use_libuv_file_watcher = true}, use_default_mappings = false, window = {mappings = {["."] = "toggle_hidden", ["/"] = "filter_as_you_type", ["<C-C>"] = "clear_filter", ["<C-[>"] = "navigate_up", ["<C-]>"] = "set_root", ["?"] = "show_help", a = "add", d = "delete", f = "filter_on_submit", i = "open_split", m = "move", o = "open", p = "paste_from_clipboard", q = "close_window", r = "rename", R = "refresh", s = "open_vsplit", t = "open_tabnew", x = "cut_to_clipboard", y = "copy_to_clipboard", za = "toggle_node", zc = "close_node", zC = "close_all_nodes"}, width = 32}})
  return (require("soup.core.maps")).map({name = "Neo Tree", ["<Space>"] = {"<Cmd>Neotree toggle<CR>", "Toggle"}, ["<CR>"] = {"<Cmd>Neotree focus<CR>", "Focus"}}, {prefix = "<Leader><Space>"})
end
return {config = config}
