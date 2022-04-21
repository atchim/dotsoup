local function config()
  vim.opt.timeoutlen = 500
  return (require("which-key")).setup()
end
return {config = config}
