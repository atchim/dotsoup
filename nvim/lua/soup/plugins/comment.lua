local function config()
  return (require("Comment")).setup({opleader = {block = "gC"}, padding = false, toggler = {block = "gcC"}})
end
return {config = config}
