local opts
local function _1_()
  vim.wo.cursorlineopt = "line"
  return nil
end
opts = {filesystem = {use_libuv_file_watcher = true}, event_handlers = {{event = "neo_tree_buffer_enter", handler = _1_}}, window = {mappings = {["."] = "toggle_hidden", ["/"] = "filter_as_you_type", ["<C-C>"] = "clear_filter", ["<C-U>"] = "navigate_up", ["<C-]>"] = "set_root", ["?"] = "show_help", a = "add", d = "delete", f = "filter_on_submit", i = "open_split", I = "split_with_window_picker", m = "move", o = "open", O = "open_with_window_picker", p = "paste_from_clipboard", q = "close_window", r = "rename", R = "refresh", s = "open_vsplit", S = "vsplit_with_window_picker", t = "open_tabnew", x = "cut_to_clipboard", y = "copy_to_clipboard", za = "toggle_node", zc = "close_node", zC = "close_all_nodes"}, width = 32}, use_default_mappings = false}
local function config(_, opts0)
  vim.g.neo_tree_remove_legacy_commands = 1
  do end (require("neo-tree")).setup(opts0)
  return require("soup.map")({name = "Neo Tree", ["<Space>"] = {"<Cmd>Neotree toggle<CR>", "Toggle"}, ["<CR>"] = {"<Cmd>Neotree focus<CR>", "Focus"}}, {prefix = "<Leader><Space>"})
end
local lazy_spec
local function _2_(_, opts0)
  return (require("window-picker")).setup(vim.tbl_deep_extend("force", opts0, (require("sopa.integrations.window-picker")).colors))
end
lazy_spec = {branch = "v2.x", cmd = "Neotree", keys = {"<Leader><Space><CR>", "<Leader><Space><Space>"}, opts = opts, config = config, dependencies = {"MunifTanjim/nui.nvim", "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim", {opts = {use_winbar = "smart", selection_chars = "JKFLAHDSG"}, config = _2_, dependencies = "atchim/sopa.nvim", "s1n7ax/nvim-window-picker"}}, "nvim-neo-tree/neo-tree.nvim"}
local function setup()
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {setup = setup}
