local function config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local icons = {Class = "\239\160\150", Color = "\239\163\151", Constant = "\239\163\190", Constructor = "\239\144\165", Enum = "\239\133\157", EnumMember = "\239\133\157", Event = "\239\131\167", Field = "\239\176\160", File = "\239\156\152", Folder = "\239\157\138", Function = "\239\158\148", Interface = "\239\131\168", Keyword = "\239\160\138", Method = "\239\154\166", Module = "\239\146\135", Operator = "\239\154\148", Property = "\239\130\173", Reference = "\239\146\129", Snippet = "\239\131\132", Struct = "\239\173\132", Text = "\239\157\190", TypeParameter = "\239\158\131", Unit = "\238\136\159", Value = "\239\162\159", Variable = "\239\148\170"}
  local function _1_(_, vimitem)
    vimitem.kind = icons[vimitem.kind]
    return vimitem
  end
  local function _2_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    else
      return fallback()
    end
  end
  local function _4_(fallback)
    local function has_word_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return ((col ~= 0) and (((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s") == nil))
    end
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expandable() then
      return luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    elseif has_word_before() then
      return cmp.complete()
    else
      return fallback()
    end
  end
  local function _6_(args)
    return (require("luasnip")).lsp_expand(args.body)
  end
  return cmp.setup({formatting = {fields = {"kind", "abbr"}, format = _1_}, mapping = {["<C-C>"] = cmp.mapping.abort(), ["<C-E>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}), ["<C-N>"] = cmp.mapping.select_next_item(), ["<C-P>"] = cmp.mapping.select_prev_item(), ["<C-Y>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}), ["<CR>"] = cmp.mapping.confirm(), ["<Down>"] = cmp.mapping.select_next_item(), ["<S-Tab>"] = cmp.mapping(_2_, {"i", "s"}), ["<Tab>"] = cmp.mapping(_4_, {"i", "s"}), ["<Up>"] = cmp.mapping.select_prev_item()}, snippet = {expand = _6_}, sources = cmp.config.sources({{name = "nvim_lua"}, {name = "nvim_lsp"}, {name = "luasnip"}}, {{name = "path"}, {name = "buffer"}}), view = {entries = {name = "custom", selection_order = "near_cursor"}}})
end
local lazy_spec
local function _7_()
  return (require("luasnip.loaders.from_vscode")).lazy_load()
end
lazy_spec = {{config = config, "hrsh7th/nvim-cmp"}, {event = "BufRead", dependencies = "hrsh7th/nvim-cmp", "hrsh7th/cmp-buffer"}, {event = "LspAttach", dependencies = "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp"}, {ft = "lua", dependencies = "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {event = "BufRead", dependencies = "hrsh7th/nvim-cmp", "hrsh7th/cmp-path"}, {event = "BufRead", dependencies = {config = _7_, dependencies = "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip"}, "saadparwaiz1/cmp_luasnip"}}
local function setup()
  vim.g.omni_sql_no_default_maps = 1
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {setup = setup}
