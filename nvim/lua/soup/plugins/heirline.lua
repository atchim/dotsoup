local function config()
  do end (require("soup.plugins.heirline")).setup()
  local api = vim.api
  local group = api.nvim_create_augroup("soup_plugin_heirline", {})
  local function _1_()
    do end (require("soup.plugins.heirline")).setup()
    return (require("heirline")).reset_highlights()
  end
  api.nvim_create_autocmd("ColorScheme", {group = group, desc = ("Updates colors for the status line and the window bar on color" .. " scheme change."), callback = _1_})
  local function _2_(args)
    if (require("heirline.conditions")).buffer_matches({buftype = {"nofile", "prompt", "quickfix"}, filetype = {"neo-tree", "packer"}}) then
      vim.opt_local.winbar = nil
      return nil
    else
      return nil
    end
  end
  return api.nvim_create_autocmd("User", {group = group, pattern = "HeirlineInitWinbar", desc = "Sets whether the window bar is enabled.", callback = _2_})
end
local function setup()
  local api = vim.api
  local bo = vim.bo
  local f = vim.fn
  local o = vim.o
  local _local_4_ = require("heirline.conditions")
  local active_3f = _local_4_["is_active"]
  local w_25_3c_3f = _local_4_["width_percent_below"]
  local _local_5_ = require("heirline.utils")
  local get_hl = _local_5_["get_highlight"]
  local insert = _local_5_["insert"]
  local _local_6_ = require("nvim-web-devicons")
  local get_icon = _local_6_["get_icon_color"]
  local hl = {err = get_hl("DiagnosticError"), hint = get_hl("DiagnosticHint"), normal = get_hl("Normal"), search = get_hl("Search"), special = get_hl("Special"), statement = get_hl("Statement"), status = get_hl("StatusLine"), statusnc = get_hl("StatusLineNC"), string = get_hl("String"), title = get_hl("Title"), type = get_hl("Type"), warn = get_hl("DiagnosticWarn"), winbar = get_hl("WinBar"), winbarnc = get_hl("WinBarNC")}
  local align = {provider = "%="}
  local space = {provider = " "}
  local buf_init
  local function _7_(self)
    self.name = api.nvim_buf_get_name(0)
    return nil
  end
  buf_init = {init = _7_}
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
    if not w_25_3c_3f(#name, 0.5) then
      name = f.pathshorten(name)
    else
    end
    return name
  end
  buf_name = {condition = _12_, space, {hl = {fg = hl.title.fg, bold = true}, provider = _13_}}
  local buf_flags
  local function _15_(_)
    return not bo.modifiable
  end
  local function _16_(_)
    return bo.modified
  end
  buf_flags = {{condition = _15_, space, {hl = {fg = hl.err.fg, bold = true}, provider = "\239\128\163"}}, {condition = _16_, space, {hl = {fg = hl.warn.fg, bold = true}, provider = "[+]"}}}
  local buf = insert(buf_init, buf_icon, buf_flags, buf_name)
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
  local function _20_(self)
    if not (self.enc == "utf-8") then
      return (self.enc):upper()
    else
      return nil
    end
  end
  local function _22_(self)
    self.fmt = bo.fileformat
    return nil
  end
  local function _23_(self)
    if not ("unix" == self.fmt) then
      return (self.fmt):upper()
    else
      return nil
    end
  end
  file = {{init = _17_, provider = _20_}, space, {init = _22_, provider = _23_}}
  local ruler = {provider = "%l:%c"}
  local scroll
  local function _25_(self)
    local line = (api.nvim_win_get_cursor(0))[1]
    local lines = api.nvim_buf_line_count(0)
    local i = math.floor((((line / lines) * (#self.bar - 1)) + 1))
    return self.bar[i]
  end
  scroll = {provider = _25_, static = {bar = {"\226\150\136", "\226\150\135", "\226\150\134", "\226\150\133", "\226\150\132", "\226\150\131", "\226\150\130", "\226\150\129"}}}
  local vimode
  local function _26_(self)
    return {fg = self.colors[(self.mode):sub(1, 1)], bold = true, reverse = true}
  end
  local function _27_(self)
    self.mode = f.mode(1)
    return nil
  end
  local function _28_(self)
    return ("%-0.3( \238\152\171 %)%-3.4(" .. self.modes[self.mode] .. " %)")
  end
  vimode = {hl = _26_, init = _27_, provider = _28_, static = {colors = {c = hl.statement.fg, i = hl.string.fg, n = hl.normal.fg, r = hl.hint.fg, R = hl.warn.fg, s = hl.special.fg, S = hl.special.fg, ["\19"] = hl.special.fg, t = hl.type.fg, v = hl.search.bg, V = hl.search.bg, ["\22"] = hl.search.bg, ["!"] = hl.err.fg}, modes = {c = "C", cv = "CV", i = "I", ic = "IC", ix = "IX", n = "N", niI = "NI", niR = "NR", niV = "NV", no = "N?", nov = "N?", noV = "N?", ["no\22"] = "N?", nt = "NT", r = "...", rm = "M", ["r?"] = "?", R = "R", Rc = "RC", Rv = "RV", Rvc = "RVC", Rvx = "RVX", Rx = "RX", s = "S", S = "S_", ["\19"] = "^S", t = "T", v = "V", vs = "VS", V = "V_", Vs = "V_S", ["\22"] = "^V", ["\22s"] = "^VS", ["!"] = "!"}}, update = "ModeChanged"}
  local def = {vimode, space, buf, align, file, space, ruler, space, scroll, space}
  local nc
  local function _29_(_)
    return not active_3f()
  end
  nc = {condition = _29_, hl = {force = true, unpack(hl.statusnc)}, unpack({space, buf, align, file, space, ruler, space, scroll, space})}
  local statusline
  local function _30_(_)
    if active_3f() then
      return hl.status
    else
      return hl.statusnc
    end
  end
  statusline = {hl = _30_, fallthrough = false, unpack({nc, def})}
  local def0 = {space, buf}
  local nc0
  local function _32_(_)
    return not active_3f()
  end
  nc0 = {condition = _32_, hl = {force = true, unpack(hl.winbarnc)}, unpack({space, buf})}
  local winbar
  local function _33_(_)
    if active_3f() then
      return hl.winbar
    else
      return hl.winbarnc
    end
  end
  winbar = {hl = _33_, fallthrough = false, unpack({nc0, def0})}
  return (require("heirline")).setup(statusline, winbar)
end
return {config = config, setup = setup}
