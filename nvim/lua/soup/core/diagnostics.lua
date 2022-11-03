local M = {}
M.init = function()
  do
    local signs = {DiagnosticSignError = "\239\129\151", DiagnosticSignWarn = "\239\129\177", DiagnosticSignHint = "\239\160\180", DiagnosticSignInfo = "\239\159\187"}
    for sign, symbol in pairs(signs) do
      vim.fn.sign_define(sign, {numhl = "", text = symbol, texthl = sign})
    end
  end
  return vim.diagnostic.config({update_in_insert = true, virtual_text = {spacing = 1}})
end
return M
