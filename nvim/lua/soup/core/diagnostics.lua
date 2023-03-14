local function setup()
  do
    local signs = {DiagnosticSignError = "\239\129\151", DiagnosticSignWarn = "\239\129\177", DiagnosticSignHint = "\239\160\180", DiagnosticSignInfo = "\239\159\187"}
    for sign, symbol in pairs(signs) do
      vim.fn.sign_define(sign, {numhl = "", text = symbol, texthl = sign})
    end
  end
  vim.diagnostic.config({update_in_insert = true, virtual_text = {spacing = 1}})
  local map = vim.keymap.set
  map("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", {desc = "Diagnostic go to previous"})
  map("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", {desc = "Diagnostic go to next"})
  return map("n", "<Leader>k", "<Cmd>lua vim.diagnostic.open_float()<CR>", {desc = "Diagnostic show from line"})
end
return {setup = setup}
