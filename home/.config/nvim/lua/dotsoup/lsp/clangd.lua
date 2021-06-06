local function setup(lsp)
  lsp.clangd.setup({on_attach = require('dotsoup.lsp').on_attach})
end

return {setup = setup}
