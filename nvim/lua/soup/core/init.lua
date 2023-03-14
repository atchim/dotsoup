local function setup()
  vim.keymap.set("n", "<Space>", "<NOP>")
  vim.g.mapleader = " "
  local mods = {"options", "globals", "autocommands", "commands", "key-mappings", "diagnostics", "lazy"}
  for _, mod in ipairs(mods) do
    do end (require(("soup.core." .. mod))).setup()
  end
  return nil
end
return {setup = setup}
