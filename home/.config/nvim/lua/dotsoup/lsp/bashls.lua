local function setup(lsp)
  lsp.bashls.setup({on_attach = require('dotsoup.lsp').on_attach})
end

return {setup = setup}
