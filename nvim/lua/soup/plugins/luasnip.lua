local function config()
  return (require("luasnip.loaders.from_vscode")).lazy_load()
end
return {config = config}
