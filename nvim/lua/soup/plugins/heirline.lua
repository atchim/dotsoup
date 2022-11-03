local M = {}
M.init = function()
  local api = vim.api
  local tbldx = vim.tbl_deep_extend
  local _local_1_ = require("heirline.conditions")
  local active_3f = _local_1_["is_active"]
  local w_25_3c_3f = _local_1_["width_percent_below"]
  local _local_2_ = require("heirline.utils")
  local get_hl = _local_2_["get_highlight"]
  local insert = _local_2_["insert"]
  local mkbufls = _local_2_["make_buflist"]
  local hl = {comment = get_hl("Comment"), const = get_hl("Constant"), dir = get_hl("Directory"), err = get_hl("DiagnosticError"), hint = get_hl("DiagnosticHint"), info = get_hl("DiagnosticInfo"), normal = get_hl("Normal"), num = get_hl("Number"), preproc = get_hl("Preproc"), search = get_hl("Search"), special = get_hl("Special"), status = get_hl("StatusLine"), string = get_hl("String"), tabline = get_hl("TabLine"), tablinesel = get_hl("TabLineSel"), title = get_hl("Title"), ty = get_hl("Type"), warn = get_hl("DiagnosticWarn"), winbar = get_hl("Winbar"), winbarnc = get_hl("WinbarNC")}
  local align = {provider = "%="}
  local space = {provider = " "}
  local statusln
  do
    local file
    local function _3_(self)
      local function _4_()
        if (vim.bo.fenc ~= "") then
          return vim.bo.fenc
        else
          return nil
        end
      end
      self.enc = (_4_() or vim.o.enc)
      return nil
    end
    local function _6_(self)
      return self.enc
    end
    local function _7_(self)
      self.fmt = vim.bo.fileformat
      return nil
    end
    local function _8_(self)
      local _9_ = self.fmt
      if (_9_ == "dos") then
        return "\238\152\169"
      elseif (_9_ == "mac") then
        return "\239\140\130"
      elseif (_9_ == "unix") then
        return "\239\133\188"
      else
        return nil
      end
    end
    file = {{init = _3_, provider = _6_, hl = {fg = hl.comment.fg}}, space, {init = _7_, provider = _8_, hl = {fg = hl.ty.fg}}}
    local git
    local function _11_(self)
      local head = (vim.b.gitsigns_head or ghead or vim.g.gitsigns_head)
      if head then
        self.head = head
        return true
      else
        return nil
      end
    end
    local function _13_(self)
      return ("\239\144\152" .. " " .. self.head .. " ")
    end
    git = {condition = _11_, provider = _13_, hl = {fg = hl.ty.fg}}
    local ruler
    do
      local proto
      local function _14_(self)
        if not self.once then
          api.nvim_create_autocmd("CursorMoved", {pattern = "*:*o", command = "redrawstatus"})
          self.once = true
          return nil
        else
          return nil
        end
      end
      proto = {init = _14_}
      local ln = {provider = "\238\130\161%l", hl = {fg = hl.num.fg}}
      local col = {provider = "\238\130\163%c", hl = {fg = hl.const.fg}}
      ruler = insert(proto, ln, space, col)
    end
    local scroll
    local function _16_(self)
      local line = (api.nvim_win_get_cursor(0))[1]
      local lines = api.nvim_buf_line_count(0)
      local i = math.floor((((line / lines) * (#self.bar - 1)) + 1))
      return self.bar[i]
    end
    scroll = {static = {bar = {"\226\150\136", "\226\150\135", "\226\150\134", "\226\150\133", "\226\150\132", "\226\150\131", "\226\150\130", "\226\150\129"}}, provider = _16_}
    local vimode
    local function _17_(self)
      self.mode = vim.fn.mode(1)
      if not self.once then
        api.nvim_create_autocmd("ModeChanged", {pattern = "*:*o", command = "redrawstatus"})
        self.once = true
        return nil
      else
        return nil
      end
    end
    local function _19_(self)
      return ("%-0.3( \238\152\171 %)%-5.5(" .. self.modes[self.mode] .. " %)")
    end
    local function _20_(self)
      return {fg = self.colors[(self.mode):sub(1, 1)], reverse = true}
    end
    vimode = {static = {colors = {["\19"] = hl.special.fg, ["\22"] = hl.search.bg, ["!"] = hl.err.fg, c = hl.preproc.fg, i = hl.string.fg, n = hl.normal.fg, r = hl.warn.fg, R = hl.hint.fg, s = hl.special.fg, S = hl.special.fg, t = hl.ty.fg, v = hl.search.bg, V = hl.search.bg}, modes = {n = "N", no = "N?", nov = "NV?", noV = "NV_?", ["no\22"] = "NV#?", niI = "N>I", niR = "N>R", niV = "N>V", nt = "N@T", ntT = "N>T", v = "V", vs = "V<S", V = "V_", Vs = "V_<S", ["\22"] = "V#", ["\22s"] = "V#<S", s = "S", S = "S_", ["\19"] = "S#", i = "I", ic = "IC", ix = "IX", R = "R", Rc = "RC", Rx = "RX", Rv = "RV", Rvc = "RVC", Rvx = "RVX", c = "CMD", cv = "EX", r = "<CR>", rm = "...", ["r?"] = "?", ["!"] = "!", t = "T"}}, init = _17_, provider = _19_, hl = _20_, update = "ModeChanged"}
    local _21_
    do
      local proto_24_auto
      local function _22_(self_25_auto)
        do
          local t_23_ = _G.vim.bo
          if (nil ~= t_23_) then
            t_23_ = (t_23_)[0]
          else
          end
          if (nil ~= t_23_) then
            t_23_ = (t_23_).buftype
          else
          end
          self_25_auto.type = t_23_
        end
        self_25_auto.name = api.nvim_buf_get_name(0)
        return nil
      end
      proto_24_auto = {init = _22_}
      local flags_26_auto
      local function _26_(self_25_auto)
        local bo_27_auto = _G.vim.bo[0]
        return (not bo_27_auto.modifiable or bo_27_auto.readonly)
      end
      local function _27_(self_25_auto)
        local t_28_ = _G.vim.bo
        if (nil ~= t_28_) then
          t_28_ = (t_28_)[0]
        else
        end
        if (nil ~= t_28_) then
          t_28_ = (t_28_).modified
        else
        end
        return t_28_
      end
      local function _31_(self_25_auto)
        return (self_25_auto.type ~= "terminal")
      end
      flags_26_auto = tbldx("force", {{condition = _26_, hl = {fg = hl.err.fg}, provider = "\239\128\163 "}, {condition = _27_, hl = {fg = hl.string.fg}, provider = "\226\158\149 "}}, {condition = _31_})
      local name_28_auto
      local function _32_(self_25_auto)
        return (self_25_auto.type ~= "terminal")
      end
      local function _33_(self_25_auto)
        local _35_
        do
          local t_34_ = hl
          if (nil ~= t_34_) then
            local _36_
            if self_25_auto.noname then
              _36_ = "comment"
            else
              _36_ = "ty"
            end
            t_34_ = (t_34_)[_36_]
          else
          end
          if (nil ~= t_34_) then
            t_34_ = (t_34_).fg
          else
          end
          _35_ = t_34_
        end
        return {fg = _35_}
      end
      local function _40_(self_25_auto)
        local name_28_auto0 = _G.vim.fn.fnamemodify(self_25_auto.name, ":.")
        local noname_29_auto = (name_28_auto0 == "")
        self_25_auto.noname = noname_29_auto
        if noname_29_auto then
          return "[No Name]"
        else
          if w_25_3c_3f(#name_28_auto0, 0.25) then
            return name_28_auto0
          else
            return _G.vim.fn.pathshorten(name_28_auto0)
          end
        end
      end
      local function _46_()
        local proto_5_auto
        local function _43_(self_6_auto)
          local name_7_auto = api.nvim_buf_get_name(0)
          local __8_auto, __8_auto0, cwd_9_auto, pid_10_auto, cmd_11_auto = name_7_auto:find("term://(.+)//(.+):(.+)")
          self_6_auto.pid = pid_10_auto
          self_6_auto.cmd = cmd_11_auto
          return nil
        end
        proto_5_auto = {init = _43_}
        local pid_10_auto
        local function _44_(self_6_auto)
          return ("\239\138\146 " .. self_6_auto.pid)
        end
        pid_10_auto = {hl = {fg = hl.num.fg}, provider = _44_}
        local cmd_11_auto
        local function _45_(self_6_auto)
          local cmd_11_auto0 = self_6_auto.cmd
          return ("\239\132\160 " .. cmd_11_auto0)
        end
        cmd_11_auto = {hl = {fg = hl.ty.fg}, provider = _45_}
        return insert(proto_5_auto, space, pid_10_auto, space, cmd_11_auto)
      end
      name_28_auto = tbldx("force", {{condition = _32_, hl = _33_, provider = _40_}, _46_()}, {fallthrough = false})
      local icon_43_auto
      local function _47_(self_25_auto)
        return {fg = self_25_auto.icon_color}
      end
      local function _48_(self_25_auto)
        local ft_44_auto
        if (self_25_auto.type == "terminal") then
          ft_44_auto = "terminal"
        else
          local t_49_ = _G.vim.bo
          if (nil ~= t_49_) then
            t_49_ = (t_49_)[0]
          else
          end
          if (nil ~= t_49_) then
            t_49_ = (t_49_).filetype
          else
          end
          ft_44_auto = t_49_
        end
        self_25_auto.icon, self_25_auto.icon_color = (require("nvim-web-devicons")).get_icon_color_by_filetype(ft_44_auto, {default = true})
        return nil
      end
      local function _53_(self_25_auto)
        return self_25_auto.icon
      end
      icon_43_auto = {hl = _47_, init = _48_, provider = _53_}
      _21_ = insert(proto_24_auto, icon_43_auto, space, flags_26_auto, name_28_auto)
    end
    statusln = {hl = hl.status, unpack({vimode, space, git, _21_, align, file, space, ruler, space, scroll, space})}
  end
  local winbar
  local function _54_(_)
    if active_3f() then
      return hl.winbar
    else
      return tbldx("force", hl.winbarnc, {force = true})
    end
  end
  local function _88_()
    local proto_24_auto
    local function _56_(self_25_auto)
      do
        local t_57_ = _G.vim.bo
        if (nil ~= t_57_) then
          t_57_ = (t_57_)[0]
        else
        end
        if (nil ~= t_57_) then
          t_57_ = (t_57_).buftype
        else
        end
        self_25_auto.type = t_57_
      end
      self_25_auto.name = api.nvim_buf_get_name(0)
      return nil
    end
    proto_24_auto = {init = _56_}
    local flags_26_auto
    local function _60_(self_25_auto)
      local bo_27_auto = _G.vim.bo[0]
      return (not bo_27_auto.modifiable or bo_27_auto.readonly)
    end
    local function _61_(self_25_auto)
      local t_62_ = _G.vim.bo
      if (nil ~= t_62_) then
        t_62_ = (t_62_)[0]
      else
      end
      if (nil ~= t_62_) then
        t_62_ = (t_62_).modified
      else
      end
      return t_62_
    end
    local function _65_(self_25_auto)
      return (self_25_auto.type ~= "terminal")
    end
    flags_26_auto = tbldx("force", {{condition = _60_, hl = {fg = hl.err.fg}, provider = "\239\128\163 "}, {condition = _61_, hl = {fg = hl.string.fg}, provider = "\226\158\149 "}}, {condition = _65_})
    local name_28_auto
    local function _66_(self_25_auto)
      return (self_25_auto.type ~= "terminal")
    end
    local function _67_(self_25_auto)
      local _69_
      do
        local t_68_ = hl
        if (nil ~= t_68_) then
          local _70_
          if self_25_auto.noname then
            _70_ = "comment"
          else
            _70_ = "ty"
          end
          t_68_ = (t_68_)[_70_]
        else
        end
        if (nil ~= t_68_) then
          t_68_ = (t_68_).fg
        else
        end
        _69_ = t_68_
      end
      return {fg = _69_}
    end
    local function _74_(self_25_auto)
      local name_28_auto0 = _G.vim.fn.fnamemodify(self_25_auto.name, ":.")
      local noname_29_auto = (name_28_auto0 == "")
      self_25_auto.noname = noname_29_auto
      if noname_29_auto then
        return "[No Name]"
      else
        if w_25_3c_3f(#name_28_auto0, 0.25) then
          return name_28_auto0
        else
          return _G.vim.fn.pathshorten(name_28_auto0)
        end
      end
    end
    local function _80_()
      local proto_5_auto
      local function _77_(self_6_auto)
        local name_7_auto = api.nvim_buf_get_name(0)
        local __8_auto, __8_auto0, cwd_9_auto, pid_10_auto, cmd_11_auto = name_7_auto:find("term://(.+)//(.+):(.+)")
        self_6_auto.pid = pid_10_auto
        self_6_auto.cmd = cmd_11_auto
        return nil
      end
      proto_5_auto = {init = _77_}
      local pid_10_auto
      local function _78_(self_6_auto)
        return ("\239\138\146 " .. self_6_auto.pid)
      end
      pid_10_auto = {hl = {fg = hl.num.fg}, provider = _78_}
      local cmd_11_auto
      local function _79_(self_6_auto)
        local cmd_11_auto0 = self_6_auto.cmd
        return ("\239\132\160 " .. cmd_11_auto0)
      end
      cmd_11_auto = {hl = {fg = hl.ty.fg}, provider = _79_}
      return insert(proto_5_auto, space, pid_10_auto, space, cmd_11_auto)
    end
    name_28_auto = tbldx("force", {{condition = _66_, hl = _67_, provider = _74_}, _80_()}, {fallthrough = false})
    local icon_43_auto
    local function _81_(self_25_auto)
      return {fg = self_25_auto.icon_color}
    end
    local function _82_(self_25_auto)
      local ft_44_auto
      if (self_25_auto.type == "terminal") then
        ft_44_auto = "terminal"
      else
        local t_83_ = _G.vim.bo
        if (nil ~= t_83_) then
          t_83_ = (t_83_)[0]
        else
        end
        if (nil ~= t_83_) then
          t_83_ = (t_83_).filetype
        else
        end
        ft_44_auto = t_83_
      end
      self_25_auto.icon, self_25_auto.icon_color = (require("nvim-web-devicons")).get_icon_color_by_filetype(ft_44_auto, {default = true})
      return nil
    end
    local function _87_(self_25_auto)
      return self_25_auto.icon
    end
    icon_43_auto = {hl = _81_, init = _82_, provider = _87_}
    return insert(proto_24_auto, icon_43_auto, space, flags_26_auto, name_28_auto)
  end
  winbar = {hl = _54_, unpack({space, _88_()})}
  local bufln
  do
    local proto
    local function _89_(self)
      self.name = api.nvim_buf_get_name(self.bufnr)
      do
        local t_90_ = _G.vim.bo
        if (nil ~= t_90_) then
          t_90_ = (t_90_)[self.bufnr]
        else
        end
        if (nil ~= t_90_) then
          t_90_ = (t_90_).buftype
        else
        end
        self.type = t_90_
      end
      return nil
    end
    local function _93_(self)
      if (self.is_active or self.is_visible) then
        return hl.tablinesel
      else
        return tbldx("force", hl.tabline, {force = true})
      end
    end
    local function _95_(self)
      return self.bufnr
    end
    local function _96_(_, minwid, _0, button)
      local _97_ = button
      if (_97_ == "l") then
        return api.nvim_win_set_buf(0, minwid)
      elseif (_97_ == "r") then
        return api.nvim_buf_delete(minwid, {force = false})
      else
        return nil
      end
    end
    proto = {init = _89_, hl = _93_, on_click = {minwid = _95_, callback = _96_, name = "bufln_click_cb"}}
    local cur
    local function _99_(self)
      return self.is_active
    end
    cur = {condition = _99_, provider = "\226\143\181 ", hl = {fg = hl.special.fg}}
    local nr
    local function _100_(self)
      return self.bufnr
    end
    local function _101_(self)
      local _102_
      if (self.is_active or self.is_visible) then
        _102_ = hl.tablinesel
      else
        _102_ = hl.tabline
      end
      return {fg = (_102_).fg}
    end
    nr = {provider = _100_, hl = _101_}
    local diag
    do
      local proto0
      local function _104_(self)
        return vim.diagnostic.get(self.bufnr)
      end
      local function _105_(self, severity)
        return (0 < #vim.diagnostic.get(self.bufnr, {severity = vim.diagnostic.severity[severity]}))
      end
      proto0 = {condition = _104_, static = {has = _105_}}
      local sign
      local function _106_(severity)
        return ((vim.fn.sign_getdefined(("DiagnosticSign" .. severity)))[1]).text
      end
      sign = _106_
      local mksign
      local function _107_(key, signsufx, hl_group)
        local function _108_(self)
          return self:has(key)
        end
        local function _109_(self)
          return self.sign
        end
        local _111_
        do
          local t_110_ = hl
          if (nil ~= t_110_) then
            t_110_ = (t_110_)[hl_group]
          else
          end
          if (nil ~= t_110_) then
            t_110_ = (t_110_).fg
          else
          end
          _111_ = t_110_
        end
        return {condition = _108_, static = {sign = sign(signsufx)}, provider = _109_, hl = {fg = _111_}}
      end
      mksign = _107_
      local err = mksign("ERROR", "Error", "err")
      local warn = mksign("WARN", "Warn", "warn")
      local info = mksign("INFO", "Info", "info")
      local hint = mksign("HINT", "Hint", "hint")
      diag = insert(proto0, err, warn, info, hint)
    end
    local buf_2a
    do
      local proto_24_auto
      local function _114_(self_25_auto)
        do
          local t_115_ = _G.vim.bo
          if (nil ~= t_115_) then
            t_115_ = (t_115_)[(self_25_auto).bufnr]
          else
          end
          if (nil ~= t_115_) then
            t_115_ = (t_115_).buftype
          else
          end
          self_25_auto.type = t_115_
        end
        self_25_auto.name = api.nvim_buf_get_name((self_25_auto).bufnr)
        return nil
      end
      proto_24_auto = {init = _114_}
      local flags_26_auto
      local function _118_(self_25_auto)
        local bo_27_auto = _G.vim.bo[(self_25_auto).bufnr]
        return (not bo_27_auto.modifiable or bo_27_auto.readonly)
      end
      local function _119_(self_25_auto)
        local t_120_ = _G.vim.bo
        if (nil ~= t_120_) then
          t_120_ = (t_120_)[(self_25_auto).bufnr]
        else
        end
        if (nil ~= t_120_) then
          t_120_ = (t_120_).modified
        else
        end
        return t_120_
      end
      local function _123_(self_25_auto)
        return (self_25_auto.type ~= "terminal")
      end
      flags_26_auto = tbldx("force", {{condition = _118_, hl = {fg = hl.err.fg}, provider = "\239\128\163 "}, {condition = _119_, hl = {fg = hl.string.fg}, provider = "\226\158\149 "}}, {condition = _123_})
      local name_28_auto
      local function _124_(self_25_auto)
        return (self_25_auto.type ~= "terminal")
      end
      local function _125_(self_25_auto)
        local _127_
        do
          local t_126_ = hl
          if (nil ~= t_126_) then
            local _128_
            if self_25_auto.noname then
              _128_ = "comment"
            else
              _128_ = "ty"
            end
            t_126_ = (t_126_)[_128_]
          else
          end
          if (nil ~= t_126_) then
            t_126_ = (t_126_).fg
          else
          end
          _127_ = t_126_
        end
        return {fg = _127_}
      end
      local function _132_(self_25_auto)
        local name_28_auto0 = _G.vim.fn.fnamemodify(self_25_auto.name, ":.")
        local noname_29_auto = (name_28_auto0 == "")
        self_25_auto.noname = noname_29_auto
        if noname_29_auto then
          return "[No Name]"
        else
          return _G.vim.fn.fnamemodify(name_28_auto0, ":t")
        end
      end
      local function _137_()
        local proto_5_auto
        local function _134_(self_6_auto)
          local name_7_auto = api.nvim_buf_get_name((self_6_auto).bufnr)
          local __8_auto, __8_auto0, cwd_9_auto, pid_10_auto, cmd_11_auto = name_7_auto:find("term://(.+)//(.+):(.+)")
          self_6_auto.pid = pid_10_auto
          self_6_auto.cmd = cmd_11_auto
          return nil
        end
        proto_5_auto = {init = _134_}
        local pid_10_auto
        local function _135_(self_6_auto)
          return ("\239\138\146 " .. self_6_auto.pid)
        end
        pid_10_auto = {hl = {fg = hl.num.fg}, provider = _135_}
        local cmd_11_auto
        local function _136_(self_6_auto)
          local cmd_11_auto0 = _G.vim.fn.fnamemodify(self_6_auto.cmd, ":t")
          return ("\239\132\160 " .. cmd_11_auto0)
        end
        cmd_11_auto = {hl = {fg = hl.ty.fg}, provider = _136_}
        return insert(proto_5_auto, space, pid_10_auto, space, cmd_11_auto)
      end
      name_28_auto = tbldx("force", {{condition = _124_, hl = _125_, provider = _132_}, _137_()}, {fallthrough = false})
      local icon_43_auto
      local function _138_(self_25_auto)
        return {fg = self_25_auto.icon_color}
      end
      local function _139_(self_25_auto)
        local ft_44_auto
        if (self_25_auto.type == "terminal") then
          ft_44_auto = "terminal"
        else
          local t_140_ = _G.vim.bo
          if (nil ~= t_140_) then
            t_140_ = (t_140_)[(self_25_auto).bufnr]
          else
          end
          if (nil ~= t_140_) then
            t_140_ = (t_140_).filetype
          else
          end
          ft_44_auto = t_140_
        end
        self_25_auto.icon, self_25_auto.icon_color = (require("nvim-web-devicons")).get_icon_color_by_filetype(ft_44_auto, {default = true})
        return nil
      end
      local function _144_(self_25_auto)
        return self_25_auto.icon
      end
      icon_43_auto = {hl = _138_, init = _139_, provider = _144_}
      buf_2a = insert(proto_24_auto, icon_43_auto, space, flags_26_auto, name_28_auto)
    end
    bufln = mkbufls(insert(proto, space, cur, nr, space, diag, buf_2a, space))
  end
  do end (require("heirline")).setup(statusln, winbar, bufln)
  vim.opt.showtabline = 2
  return nil
end
M.config = function()
  do end (require("soup.plugins.heirline")).init()
  local api = vim.api
  local group = api.nvim_create_augroup("soup_plugin_heirline", {})
  local function _145_()
    do end (require("soup.plugins.heirline")).init()
    return (require("heirline")).reset_highlights()
  end
  api.nvim_create_autocmd("ColorScheme", {group = group, desc = ("Updates colors for the status line and the window bar on color" .. " scheme change."), callback = _145_})
  local function _146_()
    if (require("heirline.conditions")).buffer_matches({buftype = {"nofile", "prompt", "quickfix"}, filetype = {"neo-tree", "packer"}}) then
      vim.opt_local.winbar = nil
      return nil
    else
      return nil
    end
  end
  return api.nvim_create_autocmd("User", {group = group, pattern = "HeirlineInitWinbar", desc = "Sets whether the window bar is enabled.", callback = _146_})
end
return M
