local function fetch_colors()
  local _let_1_ = require("heirline.utils")
  local hl = _let_1_["get_highlight"]
  local comment_2a = hl("Comment")
  local constant = hl("Constant")
  local error = hl("DiagnosticError")
  local hint = hl("DiagnosticHint")
  local identifier = hl("Identifier")
  local info = hl("DiagnosticInfo")
  local normal = hl("Normal")
  local search = hl("Search")
  local special = hl("Special")
  local statement = hl("Statement")
  local statusline = hl("StatusLine")
  local string = hl("String")
  local tabline = hl("TabLine")
  local tablinesel = hl("TabLineSel")
  local type = hl("Type")
  local warn = hl("DiagnosticWarn")
  local winbar_2a = hl("WinBar")
  local winbarnc = hl("WinBarNC")
  return {n = normal.fg, no = comment_2a.fg, nov = comment_2a.fg, noV = comment_2a.fg, ["no\22"] = comment_2a.fg, niI = normal.fg, niR = normal.fg, niV = normal.fg, nt = normal.fg, ntT = normal.fg, v = search.fg, vs = search.fg, V = search.fg, Vs = search.fg, ["\22"] = search.fg, ["\22s"] = search.fg, s = hint.fg, S = hint.fg, ["\19"] = hint.fg, i = string.fg, ic = string.fg, ix = string.fg, R = special.fg, Rc = special.fg, Rx = special.fg, Rv = special.fg, Rvc = special.fg, Rvx = special.fg, c = statement.fg, cv = error.fg, r = identifier.fg, rm = identifier.fg, ["r?"] = identifier.fg, ["!"] = error.fg, t = type.fg, buflocked = error.fg, bufmod = hint.fg, diagnerr = error.fg, diagnwarn = warn.fg, diagninfo = info.fg, diagnhint = hint.fg, filecn = constant.fg, fileenc = special.fg, filefmt = string.fg, fileln = warn.fg, githead = type.fg, scroll = error.fg, statuslinebg = statusline.bg, statuslinefg = statusline.fg, tablinebg = tabline.bg, tablinefg = tabline.fg, tablineselbg = tablinesel.bg, tablineselfg = tablinesel.fg, termcmd = type.fg, termcwd = special.fg, termpid = identifier.fg, winbarbg = winbar_2a.bg, winbarfg = winbar_2a.fg, winbarncbg = winbarnc.bg, winbarncfg = winbarnc.fg}
end
local function config()
  local function setup_lines()
    local api = vim.api
    local devicons = require("nvim-web-devicons")
    local heirline_conditions = require("heirline.conditions")
    local heirline_utils = require("heirline.utils")
    local L_2a_normal, L_2a_comment, L_2a_linenr = nil, nil, nil
    do
      local convert = require("ccc.utils.convert")
      local _let_2_ = require("ccc.utils.parse")
      local hex = _let_2_["hex"]
      local _let_3_ = require("ccc.output.hex")
      local str = _let_3_["str"]
      local hex__3ergb
      local function _4_(hexcolor)
        local _, _0, r, g, b = hexcolor:find("^#(%x%x)(%x%x)(%x%x)$")
        local rgb = {r, g, b}
        local rgb0
        do
          local tbl_17_auto = {}
          local i_18_auto = #tbl_17_auto
          for _1, c in ipairs(rgb) do
            local val_19_auto = hex(c)
            if (nil ~= val_19_auto) then
              i_18_auto = (i_18_auto + 1)
              do end (tbl_17_auto)[i_18_auto] = val_19_auto
            else
            end
          end
          rgb0 = tbl_17_auto
        end
        return rgb0
      end
      hex__3ergb = _4_
      local L_2a
      local function _6_(L_2a0, hexcolor)
        local rgb = hex__3ergb(hexcolor)
        local lab = convert.rgb2lab(rgb)
        local lab0 = {L_2a0, unpack(lab, 2)}
        local rgb0 = convert.lab2rgb(lab0)
        local hex0 = str(rgb0)
        return hex0
      end
      L_2a = _6_
      local hl = heirline_utils.get_highlight
      local hl_L_2a
      local function _7_(group)
        return (convert.rgb2lab(hex__3ergb(("#%x"):format(hl(group).fg))))[1]
      end
      hl_L_2a = _7_
      local L_2a_normal0 = hl_L_2a("Normal")
      local L_2a_comment0 = hl_L_2a("Comment")
      local L_2a_linenr0 = hl_L_2a("LineNr")
      local function _8_(...)
        return L_2a(L_2a_normal0, ...)
      end
      local function _9_(...)
        return L_2a(L_2a_comment0, ...)
      end
      local function _10_(...)
        return L_2a(L_2a_linenr0, ...)
      end
      L_2a_normal, L_2a_comment, L_2a_linenr = _8_, _9_, _10_
    end
    local space = {provider = " "}
    local function _11_(self_3_auto)
      return {fg = self_3_auto.mode, reverse = true}
    end
    local function _12_(self_3_auto)
      self_3_auto.mode = vim.fn.mode(1)
      if not self_3_auto["init?"] then
        do
          local group_4_auto = api.nvim_create_augroup("soup_plugin_heirline_statusln_init", {})
          api.nvim_create_autocmd("ModeChanged", {command = "redrawstatus", group = group_4_auto, pattern = "*:*o"})
        end
        self_3_auto["init?"] = true
        return nil
      else
        return nil
      end
    end
    local function _14_(self_3_auto)
      local function _15_()
        local t_16_ = self_3_auto.aliases
        if (nil ~= t_16_) then
          t_16_ = (t_16_)[self_3_auto.mode]
        else
        end
        return t_16_
      end
      return (" \238\152\171 %-4.4(" .. (_15_() or self_3_auto.mode) .. "%) \226\150\146")
    end
    local _18_
    do
      local proto_5_auto
      local function _19_(self_6_auto)
        local head_7_auto = (vim.b.gitsigns_head or vim.g.gitsigns_head)
        if head_7_auto then
          self_6_auto.head = head_7_auto
          return true
        else
          return nil
        end
      end
      proto_5_auto = {condition = _19_}
      local head_7_auto
      local function _21_(self_6_auto)
        return (" \239\144\152 " .. self_6_auto.head .. " \226\150\146")
      end
      head_7_auto = {hl = {fg = "githead", reverse = true}, provider = _21_}
      local _let_22_ = heirline_utils
      local insert_8_auto = _let_22_["insert"]
      _18_ = insert_8_auto(proto_5_auto, head_7_auto, space)
    end
    local _23_
    do
      local _let_24_ = heirline_conditions
      local w_25_3c_3f_38_auto = _let_24_["width_percent_below"]
      local _let_25_ = heirline_utils
      local clone_41_auto = _let_25_["clone"]
      local insert_45_auto = _let_25_["insert"]
      local proto_46_auto
      local function _26_(self_39_auto)
        local bufty_47_auto = vim.bo.buftype
        local ft_51_auto
        if (bufty_47_auto == term_54_auto) then
          ft_51_auto = term_54_auto
        else
          ft_51_auto = vim.bo.filetype
        end
        local locked_3f_55_auto
        do
          local bo_56_auto = vim.bo[0]
          locked_3f_55_auto = (not bo_56_auto.modifiable or bo_56_auto.readonly)
        end
        local mod_3f_57_auto = vim.bo.modified
        local term_54_auto = "terminal"
        local _let_28_ = devicons
        local icon_color_by_ft_48_auto = _let_28_["get_icon_color_by_filetype"]
        local icon_49_auto, color_50_auto = icon_color_by_ft_48_auto(ft_51_auto, {default = true})
        local active_3f_52_auto = nil
        local name_42_auto = api.nvim_buf_get_name(0)
        self_39_auto["locked?"] = locked_3f_55_auto
        self_39_auto["mod?"] = mod_3f_57_auto
        self_39_auto.bufty = bufty_47_auto
        self_39_auto.icon = icon_49_auto
        self_39_auto["icon-color"] = L_2a_normal(color_50_auto)
        self_39_auto.name = name_42_auto
        return nil
      end
      proto_46_auto = {init = _26_}
      local flags_59_auto
      local _29_
      do
        local locked_60_auto
        local function _30_(self_39_auto)
          return self_39_auto["locked?"]
        end
        locked_60_auto = {condition = _30_, hl = {fg = "buflocked", reverse = true}, provider = " \239\128\163"}
        local mod_63_auto
        local function _31_(self_39_auto)
          return self_39_auto["mod?"]
        end
        mod_63_auto = {condition = _31_, hl = {fg = "bufmod", reverse = true}, provider = "\226\158\149"}
        local function _32_(self_39_auto)
          return self_39_auto["mod?"]
        end
        local function _33_(self_39_auto)
          if self_39_auto["locked?"] then
            return {bg = "buflocked", fg = "bufmod"}
          else
            return {bg = "bufmod"}
          end
        end
        local function _35_(self_39_auto)
          if self_39_auto["locked?"] then
            return "\226\150\146"
          else
            return " "
          end
        end
        _29_ = {locked_60_auto, {condition = _32_, hl = _33_, provider = _35_}, mod_63_auto}
      end
      local function _37_(self_39_auto)
        return (self_39_auto.bufty ~= "terminal")
      end
      flags_59_auto = clone_41_auto(_29_, {condition = _37_})
      local icon_49_auto
      local function _38_(self_39_auto)
        return {fg = self_39_auto["icon-color"], reverse = true}
      end
      local function _39_(self_39_auto)
        return self_39_auto.icon
      end
      icon_49_auto = {hl = _38_, provider = _39_}
      local ty_40_auto
      local _40_
      do
        local _let_41_ = heirline_utils
        local insert_12_auto = _let_41_["insert"]
        local proto_13_auto
        local function _42_(self_14_auto)
          return (self_14_auto.bufty == "terminal")
        end
        local function _43_(self_14_auto)
          local name_15_auto = api.nvim_buf_get_name(0)
          local __16_auto, __16_auto0, cwd_17_auto, pid_18_auto, cmd_19_auto = name_15_auto:find("term://(.+)//(.+):(.+)")
          do
            self_14_auto.cwd = cwd_17_auto
            self_14_auto["showcwd?"] = (vim.fn.expand(cwd_17_auto) ~= vim.fn.getcwd(0, 0))
            self_14_auto.pid = pid_18_auto
          end
          self_14_auto.cmd = cmd_19_auto
          return nil
        end
        proto_13_auto = {condition = _42_, init = _43_}
        local icon_space_21_auto
        local function _44_(self_14_auto)
          return {fg = self_14_auto["icon-color"], reverse = true}
        end
        icon_space_21_auto = {hl = _44_, provider = " "}
        local cmd_19_auto
        local function _45_(self_14_auto)
          return {fg = "termcmd", reverse = true}
        end
        local function _46_(self_14_auto)
          local cmd_19_auto0 = self_14_auto.cmd
          return ("\239\132\160 " .. cmd_19_auto0 .. " \226\150\146")
        end
        cmd_19_auto = {hl = _45_, provider = _46_}
        local cwd_3f_25_auto = nil
        local _7cpid_3f_26_auto = nil
        local pid_3f_27_auto = nil
        local _7ccmd_28_auto = space
        do
          local cwdproto_29_auto
          local function _47_(self_14_auto)
            return self_14_auto["showcwd?"]
          end
          cwdproto_29_auto = {condition = _47_}
          local icon_7ccwd_30_auto
          local function _48_(self_14_auto)
            return {bg = self_14_auto["icon-color"], fg = "termcwd"}
          end
          icon_7ccwd_30_auto = {hl = _48_, provider = "\226\150\146"}
          local cwd_17_auto
          local function _49_(self_14_auto)
            return ("\238\151\190 " .. vim.fn.fnamemodify(self_14_auto.cwd, ":."))
          end
          cwd_17_auto = {hl = {fg = "termcwd", reverse = true}, provider = _49_}
          cwd_3f_25_auto = insert_12_auto(cwdproto_29_auto, icon_7ccwd_30_auto, cwd_17_auto)
          local function _50_(self_14_auto)
            local _51_
            if self_14_auto["showcwd?"] then
              _51_ = "termcwd"
            else
              _51_ = self_14_auto["icon-color"]
            end
            return {bg = _51_, fg = "termpid"}
          end
          _7cpid_3f_26_auto = {hl = _50_, provider = "\226\150\146"}
          local function _53_(self_14_auto)
            return ("\239\138\146 " .. self_14_auto.pid)
          end
          pid_3f_27_auto = {hl = {fg = "termpid", reverse = true}, provider = _53_}
          _7ccmd_28_auto = {hl = {bg = "termpid", fg = "termcmd"}, provider = "\226\150\146"}
        end
        local function _54_()
          local tbl_17_auto = {}
          local i_18_auto = #tbl_17_auto
          for __5_auto, v_6_auto in next, {proto_13_auto, icon_space_21_auto, cwd_3f_25_auto, _7cpid_3f_26_auto, pid_3f_27_auto, _7ccmd_28_auto, cmd_19_auto} do
            local val_19_auto = v_6_auto
            if (nil ~= val_19_auto) then
              i_18_auto = (i_18_auto + 1)
              do end (tbl_17_auto)[i_18_auto] = val_19_auto
            else
            end
          end
          return tbl_17_auto
        end
        _40_ = insert_12_auto(unpack(_54_()))
      end
      local function _56_(self_39_auto)
        return {fg = self_39_auto["icon-color"], reverse = true}
      end
      local function _57_(self_39_auto)
        local name_42_auto = vim.fn.fnamemodify(self_39_auto.name, ":.")
        local function _58_()
          if w_25_3c_3f_38_auto(#name_42_auto, 0.25) then
            return name_42_auto
          else
            return vim.fn.pathshorten(name_42_auto)
          end
        end
        return (" " .. _58_() .. " \226\150\146")
      end
      ty_40_auto = clone_41_auto({_40_, {hl = _56_, provider = _57_}}, {fallthrough = false})
      local flags_7cicon_3f_66_auto = nil
      local function _59_(self_39_auto)
        if ((self_39_auto.bufty ~= "terminal") and self_39_auto["mod?"]) then
          return {bg = "bufmod", fg = self_39_auto["icon-color"]}
        elseif ((self_39_auto.bufty ~= "terminal") and self_39_auto["locked?"]) then
          return {bg = "buflocked", fg = self_39_auto["icon-color"]}
        else
          return {bg = self_39_auto["icon-color"]}
        end
      end
      local function _61_(self_39_auto)
        if ((self_39_auto.bufty ~= "terminal") and (self_39_auto["locked?"] or self_39_auto["mod?"])) then
          return "\226\150\146"
        else
          return " "
        end
      end
      flags_7cicon_3f_66_auto = {hl = _59_, provider = _61_}
      local function _63_()
        local tbl_17_auto = {}
        local i_18_auto = #tbl_17_auto
        for __5_auto, v_6_auto in next, {proto_46_auto, flags_59_auto, flags_7cicon_3f_66_auto, icon_49_auto, ty_40_auto} do
          local val_19_auto = v_6_auto
          if (nil ~= val_19_auto) then
            i_18_auto = (i_18_auto + 1)
            do end (tbl_17_auto)[i_18_auto] = val_19_auto
          else
          end
        end
        return tbl_17_auto
      end
      _23_ = insert_45_auto(unpack(_63_()))
    end
    local function _65_(self_80_auto)
      local function _66_()
        if (vim.bo.fenc ~= "") then
          return vim.bo.fenc
        else
          return nil
        end
      end
      self_80_auto.enc = (_66_() or vim.o.enc)
      return nil
    end
    local function _68_(self_80_auto)
      return (" " .. (self_80_auto.enc):upper())
    end
    local function _69_(self_80_auto)
      self_80_auto.fmt = vim.bo.fileformat
      return nil
    end
    local function _70_(self_80_auto)
      local _71_ = self_80_auto.fmt
      if (_71_ == "dos") then
        return "\238\152\169"
      elseif (_71_ == "mac") then
        return "\239\140\130"
      elseif (_71_ == "unix") then
        return "\239\133\188"
      else
        return nil
      end
    end
    local function _75_()
      local proto_81_auto
      local function _73_(self_80_auto)
        if not self_80_auto.once then
          api.nvim_create_autocmd("CursorMoved", {command = "redrawstatus", pattern = "*:*o"})
          self_80_auto.once = true
          return nil
        else
          return nil
        end
      end
      proto_81_auto = {init = _73_}
      local ln_82_auto = {hl = {fg = "fileln", reverse = true}, provider = " \238\130\161%l"}
      local ln_7ccol_83_auto = {hl = {bg = "fileln", fg = "filecn"}, provider = "\226\150\146"}
      local col_84_auto = {hl = {fg = "filecn", reverse = true}, provider = "\238\130\163%c \226\150\146"}
      return heirline_utils.insert(proto_81_auto, ln_82_auto, ln_7ccol_83_auto, col_84_auto)
    end
    local function _76_(self_85_auto)
      local line_86_auto = (api.nvim_win_get_cursor(0))[1]
      local lines_87_auto = api.nvim_buf_line_count(0)
      local i_88_auto = math.floor((((line_86_auto / lines_87_auto) * (#self_85_auto.bar - 1)) + 1))
      return (self_85_auto.bar)[i_88_auto]
    end
    local _77_
    do
      local _let_78_ = heirline_conditions
      local active_3f_96_auto = _let_78_["is_active"]
      local _let_79_ = heirline_utils
      local clone_97_auto = _let_79_["clone"]
      local function _105_()
        local _let_80_ = heirline_conditions
        local w_25_3c_3f_38_auto = _let_80_["width_percent_below"]
        local _let_81_ = heirline_utils
        local clone_41_auto = _let_81_["clone"]
        local insert_45_auto = _let_81_["insert"]
        local proto_46_auto
        local function _82_(self_39_auto)
          local bufty_47_auto = vim.bo.buftype
          local ft_51_auto
          if (bufty_47_auto == term_54_auto) then
            ft_51_auto = term_54_auto
          else
            ft_51_auto = vim.bo.filetype
          end
          local locked_3f_55_auto
          do
            local bo_56_auto = vim.bo[0]
            locked_3f_55_auto = (not bo_56_auto.modifiable or bo_56_auto.readonly)
          end
          local mod_3f_57_auto = vim.bo.modified
          local term_54_auto = "terminal"
          local _let_84_ = devicons
          local icon_color_by_ft_48_auto = _let_84_["get_icon_color_by_filetype"]
          local icon_49_auto, color_50_auto = icon_color_by_ft_48_auto(ft_51_auto, {default = true})
          local active_3f_52_auto = heirline_conditions.is_active
          local name_42_auto = api.nvim_buf_get_name(0)
          self_39_auto["locked?"] = locked_3f_55_auto
          self_39_auto["mod?"] = mod_3f_57_auto
          self_39_auto.bufty = bufty_47_auto
          self_39_auto.icon = icon_49_auto
          if active_3f_52_auto() then
            self_39_auto["icon-color"] = L_2a_normal(color_50_auto)
          else
            self_39_auto["icon-color"] = L_2a_comment(color_50_auto)
          end
          self_39_auto.name = name_42_auto
          return nil
        end
        proto_46_auto = {init = _82_}
        local flags_59_auto
        local _86_
        do
          local locked_60_auto
          local function _87_(self_39_auto)
            return self_39_auto["locked?"]
          end
          locked_60_auto = {condition = _87_, hl = {fg = "buflocked", reverse = false}, provider = "\239\128\163"}
          local mod_63_auto
          local function _88_(self_39_auto)
            return self_39_auto["mod?"]
          end
          mod_63_auto = {condition = _88_, hl = {fg = "bufmod", reverse = false}, provider = "\226\158\149"}
          local function _89_(self_39_auto)
            return self_39_auto["mod?"]
          end
          _86_ = {locked_60_auto, {condition = _89_, provider = " "}, mod_63_auto}
        end
        local function _90_(self_39_auto)
          return (self_39_auto.bufty ~= "terminal")
        end
        flags_59_auto = clone_41_auto(_86_, {condition = _90_})
        local icon_49_auto
        local function _91_(self_39_auto)
          return {fg = self_39_auto["icon-color"], reverse = false}
        end
        local function _92_(self_39_auto)
          return self_39_auto.icon
        end
        icon_49_auto = {hl = _91_, provider = _92_}
        local ty_40_auto
        local _93_
        do
          local _let_94_ = heirline_utils
          local insert_12_auto = _let_94_["insert"]
          local proto_13_auto
          local function _95_(self_14_auto)
            return (self_14_auto.bufty == "terminal")
          end
          local function _96_(self_14_auto)
            local name_15_auto = api.nvim_buf_get_name(0)
            local __16_auto, __16_auto0, cwd_17_auto, pid_18_auto, cmd_19_auto = name_15_auto:find("term://(.+)//(.+):(.+)")
            self_14_auto.cmd = cmd_19_auto
            return nil
          end
          proto_13_auto = {condition = _95_, init = _96_}
          local icon_space_21_auto
          local function _97_(self_14_auto)
            return {fg = self_14_auto["icon-color"], reverse = false}
          end
          icon_space_21_auto = {hl = _97_, provider = " "}
          local cmd_19_auto
          local function _98_(self_14_auto)
            return {fg = self_14_auto["icon-color"], reverse = false}
          end
          local function _99_(self_14_auto)
            local cmd_19_auto0 = self_14_auto.cmd
            return cmd_19_auto0
          end
          cmd_19_auto = {hl = _98_, provider = _99_}
          local cwd_3f_25_auto = nil
          local _7cpid_3f_26_auto = nil
          local pid_3f_27_auto = nil
          local _7ccmd_28_auto = space
          local function _100_()
            local tbl_17_auto = {}
            local i_18_auto = #tbl_17_auto
            for __5_auto, v_6_auto in next, {proto_13_auto, icon_space_21_auto, cwd_3f_25_auto, _7cpid_3f_26_auto, pid_3f_27_auto, _7ccmd_28_auto, cmd_19_auto} do
              local val_19_auto = v_6_auto
              if (nil ~= val_19_auto) then
                i_18_auto = (i_18_auto + 1)
                do end (tbl_17_auto)[i_18_auto] = val_19_auto
              else
              end
            end
            return tbl_17_auto
          end
          _93_ = insert_12_auto(unpack(_100_()))
        end
        local function _102_(self_39_auto)
          return {fg = self_39_auto["icon-color"], reverse = false}
        end
        local function _103_(self_39_auto)
          local name_42_auto = vim.fn.fnamemodify(self_39_auto.name, ":.")
          local function _104_()
            if w_25_3c_3f_38_auto(#name_42_auto, 0.25) then
              return name_42_auto
            else
              return vim.fn.pathshorten(name_42_auto)
            end
          end
          return (" " .. _104_())
        end
        ty_40_auto = clone_41_auto({_93_, {hl = _102_, provider = _103_}}, {fallthrough = false})
        local flags_7cicon_3f_66_auto = nil
        local function _106_()
          local tbl_17_auto = {}
          local i_18_auto = #tbl_17_auto
          for __5_auto, v_6_auto in next, {proto_46_auto, flags_59_auto, flags_7cicon_3f_66_auto, icon_49_auto, ty_40_auto} do
            local val_19_auto = v_6_auto
            if (nil ~= val_19_auto) then
              i_18_auto = (i_18_auto + 1)
              do end (tbl_17_auto)[i_18_auto] = val_19_auto
            else
            end
          end
          return tbl_17_auto
        end
        return insert_45_auto(unpack(_106_()))
      end
      local function _108_(_self_98_auto)
        if active_3f_96_auto() then
          return {bg = "winbarbg", bold = true, fg = "winbarfg"}
        else
          return {bg = "winbarncbg", bold = true, fg = "winbarncfg"}
        end
      end
      _77_ = clone_97_auto({space, _105_()}, {hl = _108_})
    end
    local function _118_()
      local proto_90_auto
      local function _110_(self_91_auto)
        if self_91_auto.is_active then
          return {bg = "tablineselbg", bold = true, fg = "tablineselfg"}
        else
          return {bg = "tablinebg", bold = true, fg = "tablinefg"}
        end
      end
      local function _112_(self_91_auto)
        self_91_auto.name = api.nvim_buf_get_name(self_91_auto.bufnr)
        self_91_auto.type = (vim.bo[self_91_auto.bufnr]).buftype
        return nil
      end
      local function _113_(__92_auto, minwid_93_auto, __92_auto0, button_94_auto)
        local _114_ = button_94_auto
        if (_114_ == "l") then
          return api.nvim_win_set_buf(0, minwid_93_auto)
        elseif (_114_ == "r") then
          return api.nvim_buf_delete(minwid_93_auto, {force = false})
        else
          return nil
        end
      end
      local function _116_(self_91_auto)
        return self_91_auto.bufnr
      end
      proto_90_auto = {hl = _110_, init = _112_, on_click = {callback = _113_, minwid = _116_, name = "bufln_click_cb"}}
      local nr_95_auto
      local function _117_(self_91_auto)
        return self_91_auto.bufnr
      end
      nr_95_auto = {provider = _117_}
      local _119_
      do
        local proto_68_auto
        local function _120_(self_72_auto)
          return vim.diagnostic.get(self_72_auto.bufnr)
        end
        local function _121_(self_72_auto, severity_73_auto)
          return (0 < #vim.diagnostic.get(self_72_auto.bufnr, {severity = vim.diagnostic.severity[severity_73_auto]}))
        end
        proto_68_auto = {condition = _120_, static = {has = _121_}}
        local sign_74_auto
        local function _122_(severity_73_auto)
          return ((vim.fn.sign_getdefined(("DiagnosticSign" .. severity_73_auto)))[1]).text
        end
        sign_74_auto = _122_
        local mksign_69_auto
        local function _123_(key_75_auto, signsufx_76_auto, hl_77_auto)
          local function _124_(self_72_auto)
            return self_72_auto:has(key_75_auto)
          end
          local function _125_(self_72_auto)
            return self_72_auto.sign
          end
          return {condition = _124_, hl = {fg = hl_77_auto}, provider = _125_, static = {sign = sign_74_auto(signsufx_76_auto)}}
        end
        mksign_69_auto = _123_
        local err_78_auto = mksign_69_auto("ERROR", "Error", "diagnerr")
        local warn_79_auto = mksign_69_auto("WARN", "Warn", "diagnwarn")
        local info_70_auto = mksign_69_auto("INFO", "Info", "diagninfo")
        local hint_71_auto = mksign_69_auto("HINT", "Hint", "diagnhint")
        _119_ = heirline_utils.insert(proto_68_auto, err_78_auto, warn_79_auto, info_70_auto, hint_71_auto)
      end
      local _126_
      do
        local _let_127_ = heirline_conditions
        local w_25_3c_3f_38_auto = _let_127_["width_percent_below"]
        local _let_128_ = heirline_utils
        local clone_41_auto = _let_128_["clone"]
        local insert_45_auto = _let_128_["insert"]
        local proto_46_auto
        local function _129_(self_39_auto)
          local bufty_47_auto = (vim.bo[(self_39_auto).bufnr]).buftype
          local ft_51_auto
          if (bufty_47_auto == term_54_auto) then
            ft_51_auto = term_54_auto
          else
            ft_51_auto = (vim.bo[(self_39_auto).bufnr]).filetype
          end
          local locked_3f_55_auto
          do
            local bo_56_auto = vim.bo[(self_39_auto).bufnr]
            locked_3f_55_auto = (not bo_56_auto.modifiable or bo_56_auto.readonly)
          end
          local mod_3f_57_auto = (vim.bo[(self_39_auto).bufnr]).modified
          local term_54_auto = "terminal"
          local _let_131_ = devicons
          local icon_color_by_ft_48_auto = _let_131_["get_icon_color_by_filetype"]
          local icon_49_auto, color_50_auto = icon_color_by_ft_48_auto(ft_51_auto, {default = true})
          local active_3f_52_auto = nil
          local name_42_auto = api.nvim_buf_get_name((self_39_auto).bufnr)
          self_39_auto["locked?"] = locked_3f_55_auto
          self_39_auto["mod?"] = mod_3f_57_auto
          self_39_auto.bufty = bufty_47_auto
          self_39_auto.icon = icon_49_auto
          if self_39_auto.is_active then
            self_39_auto["icon-color"] = L_2a_normal(color_50_auto)
          elseif self_39_auto.is_visible then
            self_39_auto["icon-color"] = L_2a_comment(color_50_auto)
          else
            self_39_auto["icon-color"] = L_2a_linenr(color_50_auto)
          end
          self_39_auto.name = name_42_auto
          return nil
        end
        proto_46_auto = {init = _129_}
        local flags_59_auto
        local _133_
        do
          local locked_60_auto
          local function _134_(self_39_auto)
            return self_39_auto["locked?"]
          end
          locked_60_auto = {condition = _134_, hl = {fg = "buflocked", reverse = false}, provider = "\239\128\163"}
          local mod_63_auto
          local function _135_(self_39_auto)
            return self_39_auto["mod?"]
          end
          mod_63_auto = {condition = _135_, hl = {fg = "bufmod", reverse = false}, provider = "\226\158\149"}
          local function _136_(self_39_auto)
            return self_39_auto["mod?"]
          end
          _133_ = {locked_60_auto, {condition = _136_, provider = " "}, mod_63_auto}
        end
        local function _137_(self_39_auto)
          return (self_39_auto.bufty ~= "terminal")
        end
        flags_59_auto = clone_41_auto(_133_, {condition = _137_})
        local icon_49_auto
        local function _138_(self_39_auto)
          return {fg = self_39_auto["icon-color"], reverse = false}
        end
        local function _139_(self_39_auto)
          return self_39_auto.icon
        end
        icon_49_auto = {hl = _138_, provider = _139_}
        local ty_40_auto
        local _140_
        do
          local _let_141_ = heirline_utils
          local insert_12_auto = _let_141_["insert"]
          local proto_13_auto
          local function _142_(self_14_auto)
            return (self_14_auto.bufty == "terminal")
          end
          local function _143_(self_14_auto)
            local name_15_auto = api.nvim_buf_get_name((self_14_auto).bufnr)
            local __16_auto, __16_auto0, cwd_17_auto, pid_18_auto, cmd_19_auto = name_15_auto:find("term://(.+)//(.+):(.+)")
            self_14_auto.cmd = cmd_19_auto
            return nil
          end
          proto_13_auto = {condition = _142_, init = _143_}
          local icon_space_21_auto
          local function _144_(self_14_auto)
            return {fg = self_14_auto["icon-color"], reverse = false}
          end
          icon_space_21_auto = {hl = _144_, provider = " "}
          local cmd_19_auto
          local function _145_(self_14_auto)
            return {fg = self_14_auto["icon-color"], reverse = false}
          end
          local function _146_(self_14_auto)
            local cmd_19_auto0 = vim.fn.fnamemodify(self_14_auto.cmd, ":t")
            return cmd_19_auto0
          end
          cmd_19_auto = {hl = _145_, provider = _146_}
          local cwd_3f_25_auto = nil
          local _7cpid_3f_26_auto = nil
          local pid_3f_27_auto = nil
          local _7ccmd_28_auto = space
          local function _147_()
            local tbl_17_auto = {}
            local i_18_auto = #tbl_17_auto
            for __5_auto, v_6_auto in next, {proto_13_auto, icon_space_21_auto, cwd_3f_25_auto, _7cpid_3f_26_auto, pid_3f_27_auto, _7ccmd_28_auto, cmd_19_auto} do
              local val_19_auto = v_6_auto
              if (nil ~= val_19_auto) then
                i_18_auto = (i_18_auto + 1)
                do end (tbl_17_auto)[i_18_auto] = val_19_auto
              else
              end
            end
            return tbl_17_auto
          end
          _140_ = insert_12_auto(unpack(_147_()))
        end
        local function _149_(self_39_auto)
          return {fg = self_39_auto["icon-color"], reverse = false}
        end
        local function _150_(self_39_auto)
          local name_42_auto = vim.fn.fnamemodify(self_39_auto.name, ":.")
          return (" " .. vim.fn.fnamemodify(name_42_auto, ":t"))
        end
        ty_40_auto = clone_41_auto({_140_, {hl = _149_, provider = _150_}}, {fallthrough = false})
        local flags_7cicon_3f_66_auto = nil
        local function _151_()
          local tbl_17_auto = {}
          local i_18_auto = #tbl_17_auto
          for __5_auto, v_6_auto in next, {proto_46_auto, flags_59_auto, flags_7cicon_3f_66_auto, icon_49_auto, ty_40_auto} do
            local val_19_auto = v_6_auto
            if (nil ~= val_19_auto) then
              i_18_auto = (i_18_auto + 1)
              do end (tbl_17_auto)[i_18_auto] = val_19_auto
            else
            end
          end
          return tbl_17_auto
        end
        _126_ = insert_45_auto(unpack(_151_()))
      end
      return heirline_utils.insert(proto_90_auto, space, nr_95_auto, space, _119_, _126_, space)
    end
    do end (require("heirline")).setup({statusline = heirline_utils.insert({hl = {bg = "statuslinebg", bold = true, fg = "statuslinefg"}}, {hl = _11_, init = _12_, provider = _14_, static = {aliases = {["\19"] = "^S", ["\22"] = "^V", ["\22s"] = "^Vs", ["no\22"] = "no^V"}}, update = "ModeChanged"}, space, _18_, _23_, {provider = "%="}, {{hl = {fg = "fileenc", reverse = true}, init = _65_, provider = _68_}, {hl = {bg = "fileenc", fg = "filefmt"}, provider = "\226\150\146"}, {hl = {fg = "filefmt", reverse = true}, init = _69_, provider = _70_}, {hl = {bg = "filefmt", fg = "fileln"}, provider = "\226\150\146"}, _75_()}, space, {hl = {fg = "scroll"}, provider = _76_, static = {bar = {"\226\150\136", "\226\150\135", "\226\150\134", "\226\150\133", "\226\150\132", "\226\150\131", "\226\150\130", "\226\150\129"}}}), winbar = _77_, tabline = heirline_utils.make_buflist(_118_())})
    vim.opt.showtabline = 2
    return nil
  end
  local colors = (require("soup.ui.heirline")).fetch_colors()
  local api = vim.api
  local group = api.nvim_create_augroup("soup_ui_heirline", {clear = true})
  do end (require("heirline")).load_colors(colors)
  setup_lines()
  local function _153_()
    local colors0 = (require("soup.ui.heirline")).fetch_colors()
    return (require("heirline.utils")).on_colorscheme(colors0)
  end
  api.nvim_create_autocmd("ColorScheme", {desc = "Defines highlight colors for Heirline.", group = group, callback = _153_})
  local function _154_()
    if (require("heirline.conditions")).buffer_matches({buftype = {"nofile", "prompt", "quickfix"}, filetype = {"neo-tree", "packer"}}) then
      vim.opt_local.winbar = nil
      return nil
    else
      return nil
    end
  end
  return api.nvim_create_autocmd("User", {desc = "Sets whether the window bar is enabled.", group = group, pattern = "HeirlineInitWinbar", callback = _154_})
end
local lazy_spec = {event = "UIEnter", config = config, dependencies = {"atchim/sopa.nvim", "kyazdani42/nvim-web-devicons", "uga-rosa/ccc.nvim"}, "rebelot/heirline.nvim"}
local function setup()
  return (require("soup")).push_lazy_spec(lazy_spec)
end
return {fetch_colors = fetch_colors, setup = setup}
