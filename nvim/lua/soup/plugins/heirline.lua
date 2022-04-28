local function config()
  do end (require("heirline")).setup((require("soup.plugins.heirline")).statusline())
  local api = vim.api
  local group = api.nvim_create_augroup("soup_plugin_heirline", {})
  local function _1_()
    local _let_2_ = require("soup.plugins.heirline")
    local statusline = _let_2_["statusline"]
    local _let_3_ = require("heirline")
    local reset_highlights = _let_3_["reset_highlights"]
    local setup = _let_3_["setup"]
    setup(statusline())
    return reset_highlights()
  end
  return api.nvim_create_autocmd("ColorScheme", {group = group, desc = "Update colors for the status line on color scheme change.", callback = _1_})
end
local function statusline()
  local api = vim.api
  local bo = vim.bo
  local f = vim.fn
  local o = vim.o
  local _local_4_ = require("heirline.conditions")
  local active_3f = _local_4_["is_active"]
  local wpb = _local_4_["width_percent_below"]
  local _local_5_ = require("heirline.utils")
  local get_hl = _local_5_["get_highlight"]
  local insert = _local_5_["insert"]
  local pcod = _local_5_["pick_child_on_condition"]
  local _local_6_ = require("nvim-web-devicons")
  local get_icon = _local_6_["get_icon_color"]
  local hl = {dir = get_hl("Directory"), err = get_hl("DiagnosticError"), hint = get_hl("DiagnosticHint"), normal = get_hl("Normal"), search = get_hl("Search"), special = get_hl("Special"), statement = get_hl("Statement"), status = get_hl("StatusLine"), statusnc = get_hl("StatusLineNC"), string = get_hl("String"), type = get_hl("Type"), warn = get_hl("DiagnosticWarn")}
  local align = {provider = "%="}
  local space = {provider = " "}
  local buf
  local function _7_(self)
    self.name = api.nvim_buf_get_name(0)
    return nil
  end
  buf = {init = _7_}
  local buf_icon
  local function _8_(self)
    return {fg = self.icon_color}
  end
  local function _9_(self)
    local name = self.name
    local ext = f.fnamemodify(name, ":e")
    self.icon, self.icon_color = get_icon(name, ext, {default = true})
    return nil
  end
  local function _10_(self)
    if self.icon then
      return self.icon
    else
      return nil
    end
  end
  buf_icon = {hl = _8_, init = _9_, provider = _10_}
  local buf_name
  local function _12_(self)
    return not ("" == self.name)
  end
  local function _13_(self)
    local name = f.fnamemodify(self.name, ":.")
    if not wpb(#name, 0.5) then
      name = f.pathshorten(name)
    else
    end
    return name
  end
  buf_name = {condition = _12_, space, {hl = {fg = hl.dir.fg, bold = true}, provider = _13_}}
  local buf_flags
  local function _15_(_)
    return not bo.modifiable
  end
  local function _16_(_)
    return bo.modified
  end
  buf_flags = {{condition = _15_, space, {hl = {fg = hl.err.fg, bold = true}, provider = "\239\128\163"}}, {condition = _16_, space, {hl = {fg = hl.warn.fg, bold = true}, provider = "+"}}}
  local buf0 = insert(buf, buf_icon, buf_flags, buf_name)
  local file
  local function _17_(self)
    local function _18_()
      if not ("" == bo.fenc) then
        return bo.fenc
      else
        return nil
      end
    end
    self.enc = (_18_() or o.enc)
    return nil
  end
  local function _19_(self)
    if not (self.enc == "utf-8") then
      return (self.enc):upper()
    else
      return nil
    end
  end
  local function _21_(self)
    self.fmt = bo.fileformat
    return nil
  end
  local function _22_(self)
    if not ("unix" == self.fmt) then
      return (self.fmt):upper()
    else
      return nil
    end
  end
  file = {{init = _17_, provider = _19_}, space, {init = _21_, provider = _22_}}
  local ruler = {provider = "%l:%c"}
  local scroll
  local function _24_(self)
    local line = (api.nvim_win_get_cursor(0))[1]
    local lines = api.nvim_buf_line_count(0)
    local i = math.floor((((line / lines) * (#self.bar - 1)) + 1))
    return self.bar[i]
  end
  scroll = {provider = _24_, static = {bar = {"\226\150\136", "\226\150\135", "\226\150\134", "\226\150\133", "\226\150\132", "\226\150\131", "\226\150\130", "\226\150\129"}}}
  local vimode
  local function _25_(self)
    return {fg = self.colors[(self.mode):sub(1, 1)], bold = true, reverse = true}
  end
  local function _26_(self)
    self.mode = f.mode(1)
    return nil
  end
  local function _27_(self)
    return (" \238\152\171 %-3.3(" .. self.modes[self.mode] .. "%) ")
  end
  vimode = {hl = _25_, init = _26_, provider = _27_, static = {colors = {c = hl.statement.fg, i = hl.string.fg, n = hl.normal.fg, r = hl.hint.fg, R = hl.warn.fg, s = hl.special.fg, S = hl.special.fg, ["\19"] = hl.special.fg, t = hl.type.fg, v = hl.search.bg, V = hl.search.bg, ["\22"] = hl.search.bg, ["!"] = hl.err.fg}, modes = {c = "C", cv = "CV", i = "I", ic = "IC", ix = "IX", n = "N", niI = "NI", niR = "NR", niV = "NV", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?", nt = "NT", r = "...", rm = "M", ["r?"] = "?", R = "R", Rc = "RC", Rv = "RV", Rvc = "RVC", Rvx = "RVX", Rx = "RX", s = "S", S = "S_", ["\19"] = "^S", t = "T", v = "V", vs = "VS", V = "V_", Vs = "V_S", ["\22"] = "^V", ["\22s"] = "^VS", ["!"] = "!"}}}
  local def = {vimode, space, buf0, align, file, space, ruler, space, scroll, space}
  local nc
  local function _28_(_)
    return not active_3f()
  end
  nc = {condition = _28_, hl = {force = true, unpack(hl.statusnc)}, unpack({space, buf0, align, file, space, ruler, space, scroll, space})}
  local statusline0
  local function _29_(_)
    if active_3f() then
      return hl.status
    else
      return hl.statusnc
    end
  end
  statusline0 = {hl = _29_, init = pcod, nc, def}
  return statusline0
end
return {config = config, statusline = statusline}
