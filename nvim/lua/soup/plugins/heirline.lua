local function config()
  do
    local _let_1_ = require("soup.plugins.heirline")
    local statusline = _let_1_["statusline"]
    local _let_2_ = require("heirline")
    local setup = _let_2_["setup"]
    setup(statusline())
  end
  local api = vim.api
  local group = api.nvim_create_augroup("soup_plugin_heirline", {})
  local function _3_()
    local _let_4_ = require("soup.plugins.heirline")
    local statusline = _let_4_["statusline"]
    local _let_5_ = require("heirline")
    local reset_highlights = _let_5_["reset_highlights"]
    local setup = _let_5_["setup"]
    setup(statusline())
    return reset_highlights()
  end
  return api.nvim_create_autocmd("ColorScheme", {group = group, desc = "Update colors for the status line on color scheme change.", callback = _3_})
end
local function statusline()
  local api = vim.api
  local bo = vim.bo
  local f = vim.fn
  local o = vim.o
  local _local_6_ = require("heirline.conditions")
  local active_3f = _local_6_["is_active"]
  local wpb = _local_6_["width_percent_below"]
  local _local_7_ = require("heirline.utils")
  local get_hi = _local_7_["get_highlight"]
  local insert = _local_7_["insert"]
  local pcod = _local_7_["pick_child_on_condition"]
  local _local_8_ = require("nvim-web-devicons")
  local get_icon = _local_8_["get_icon_color"]
  local hi = {dir = get_hi("Directory"), err = get_hi("DiagnosticError"), hint = get_hi("DiagnosticHint"), normal = get_hi("Normal"), search = get_hi("Search"), special = get_hi("Special"), statement = get_hi("Statement"), status = get_hi("StatusLine"), statusnc = get_hi("StatusLineNC"), string = get_hi("String"), type = get_hi("Type"), warn = get_hi("DiagnosticWarn")}
  local align = {provider = "%="}
  local space = {provider = " "}
  local buf
  local function _9_(self)
    self.name = api.nvim_buf_get_name(0)
    return nil
  end
  buf = {init = _9_}
  local buf_icon
  local function _10_(self)
    return {fg = self.icon_color}
  end
  local function _11_(self)
    local name = self.name
    local ext = f.fnamemodify(name, ":e")
    self.icon, self.icon_color = get_icon(name, ext, {default = true})
    return nil
  end
  local function _12_(self)
    if self.icon then
      return self.icon
    else
      return nil
    end
  end
  buf_icon = {hl = _10_, init = _11_, provider = _12_}
  local buf_name
  local function _14_(self)
    return not ("" == self.name)
  end
  local function _15_(self)
    local name = f.fnamemodify(self.name, ":.")
    if not wpb(#name, 0.5) then
      name = f.pathshorten(name)
    else
    end
    return name
  end
  buf_name = {condition = _14_, space, {hl = {fg = hi.dir.fg, style = hi.dir.style}, provider = _15_}}
  local buf_flags
  local function _17_(_)
    return not bo.modifiable
  end
  local function _18_(_)
    return bo.modified
  end
  buf_flags = {{condition = _17_, space, {hl = {fg = hi.err.fg, style = "bold"}, provider = "\239\128\163"}}, {condition = _18_, space, {hl = {fg = hi.warn.fg, style = "bold"}, provider = "+"}}}
  local buf0 = insert(buf, buf_icon, buf_flags, buf_name)
  local file
  local function _19_(self)
    local function _20_()
      if not ("" == bo.fenc) then
        return bo.fenc
      else
        return nil
      end
    end
    self.enc = (_20_() or o.enc)
    return nil
  end
  local function _21_(self)
    if not (self.enc == "utf-8") then
      return (self.enc):upper()
    else
      return nil
    end
  end
  local function _23_(self)
    self.fmt = bo.fileformat
    return nil
  end
  local function _24_(self)
    if not ("unix" == self.fmt) then
      return (self.fmt):upper()
    else
      return nil
    end
  end
  file = {{init = _19_, provider = _21_}, space, {init = _23_, provider = _24_}}
  local ruler = {provider = "%l:%c"}
  local scroll
  local function _26_(self)
    local line = (api.nvim_win_get_cursor(0))[1]
    local lines = api.nvim_buf_line_count(0)
    local i = math.floor((((line / lines) * (#self.bar - 1)) + 1))
    return self.bar[i]
  end
  scroll = {provider = _26_, static = {bar = {"\226\150\136", "\226\150\135", "\226\150\134", "\226\150\133", "\226\150\132", "\226\150\131", "\226\150\130", "\226\150\129"}}}
  local vimode
  local function _27_(self)
    return {fg = self.colors[(self.mode):sub(1, 1)], style = "bold,reverse"}
  end
  local function _28_(self)
    self.mode = f.mode(1)
    return nil
  end
  local function _29_(self)
    return (" \238\152\171 %-3.3(" .. self.modes[self.mode] .. "%) ")
  end
  vimode = {hl = _27_, init = _28_, provider = _29_, static = {colors = {c = hi.statement.fg, i = hi.string.fg, n = hi.normal.fg, r = hi.hint.fg, R = hi.warn.fg, s = hi.special.fg, S = hi.special.fg, ["\19"] = hi.special.fg, t = hi.type.fg, v = hi.search.bg, V = hi.search.bg, ["\22"] = hi.search.bg, ["!"] = hi.err.fg}, modes = {c = "C", cv = "CV", i = "I", ic = "IC", ix = "IX", n = "N", niI = "NI", niR = "NR", niV = "NV", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?", nt = "NT", r = "...", rm = "M", ["r?"] = "?", R = "R", Rc = "RC", Rv = "RV", Rvc = "RVC", Rvx = "RVX", Rx = "RX", s = "S", S = "S_", ["\19"] = "^S", t = "T", v = "V", vs = "VS", V = "V_", Vs = "V_S", ["\22"] = "^V", ["\22s"] = "^VS", ["!"] = "!"}}}
  local def = {vimode, space, buf0, align, file, space, ruler, space, scroll, space}
  local nc
  local function _30_(_)
    return not active_3f()
  end
  nc = {condition = _30_, hl = {force = true, unpack(hi.statusnc)}, unpack({space, buf0, align, file, space, ruler, space, scroll, space})}
  local statusline0
  local function _31_(_)
    if active_3f() then
      return hi.status
    else
      return hi.statusnc
    end
  end
  statusline0 = {hl = _31_, init = pcod, nc, def}
  return statusline0
end
return {config = config, statusline = statusline}
