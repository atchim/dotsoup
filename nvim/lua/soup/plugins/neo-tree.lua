local function config()
  do end (require("neo-tree")).setup({filesystem = {use_libuv_file_watcher = true}, window = {mappings = {o = "open"}, width = 32}})
  return (require("soup.core.maps")).map({name = "Neo Tree", ["<Space>"] = {"<Cmd>Neotree toggle<CR>", "Toggle"}, ["<CR>"] = {"<Cmd>Neotree focus<CR>", "Focus"}}, {prefix = "<Leader><Space>"})
end
local function setup()
  vim.g.neo_tree_remove_legacy_commands = 1
  return nil
end
return {config = config, setup = setup}
