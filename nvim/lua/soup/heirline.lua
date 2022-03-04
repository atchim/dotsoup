local M = {}

M.config = function()
  local api = vim.api
  local bo = vim.bo
  local cond = require'heirline.conditions'
  local fn = vim.fn
  local utils = require'heirline.utils'
  local get_hl = utils.get_highlight
  local get_icon = require'nvim-web-devicons'.get_icon_color
  local is_active = cond.is_active
  local o = vim.o

  local hls = {
    diffch = get_hl'diffChanged',
    diffrm = get_hl'diffRemoved',
    diffsub = get_hl'diffSubname',
    dir = get_hl'Directory',
    errmsg = get_hl'ErrorMsg',
    normal = get_hl'Normal',
    search = get_hl'Search',
    special = get_hl'Special',
    statement = get_hl'Statement',
    status = get_hl'StatusLine',
    statusnc = get_hl'StatusLineNC',
    string = get_hl'String',
    type = get_hl'Type',
  }

  local align = {provider = '%='}
  local space = {provider = ' '}

  local buf = {
    init = function(self)
      self.name = api.nvim_buf_get_name(0)
    end,
  }

  local buf_icon = {
    hl = function(self)
      return {fg = self.icon_color}
    end,

    init = function(self)
      local name = self.name
      local ext = fn.fnamemodify(name, ':e')
      self.icon, self.icon_color = get_icon(name, ext, {default = true})
    end,

    provider = function(self)
      if self.icon then
        return self.icon
      end
    end,
  }

  local buf_name = {
    space,

    {
      hl = {
        fg = hls.dir.fg,
        style = hls.dir.style,
      },

      provider = function(self)
        local name = fn.fnamemodify(self.name, ':.')
        if not cond.width_percent_below(#name, 0.5) then
          name = fn.pathshorten(name)
        end
        return name
      end,
    },

    condition = function(self)
      return self.name ~= ''
    end,
  }

  local buf_flags = {
    {
      space,
      {hl = {fg = hls.diffrm.fg, style = 'bold'}, provider = ''},
      condition = function() return not bo.modifiable end,
    },

    {
      space,
      {hl = {fg = hls.diffch.fg, style = 'bold'}, provider = '+'},
      condition = function() return bo.modified end,
    },
  }

  buf = utils.insert(buf, buf_icon, buf_flags, buf_name)

  local file = {
    {
      init = function(self)
        self.enc = (bo.fenc ~= '' and bo.fenc) or o.enc
      end,

      provider = function(self)
        if self.enc ~= 'utf-8' then
          return self.enc:upper()
        end
      end,
    },

    space,

    {
      init = function(self) self.fmt = bo.fileformat end,

      provider = function(self)
        if self.fmt ~= 'unix' then
          return self.fmt:upper()
        end
      end
    },
  }

  local ruler = {provider = '%l:%c'}

  local scroll = {
    provider = function(self)
        local line = api.nvim_win_get_cursor(0)[1]
        local lines = api.nvim_buf_line_count(0)
        local i = math.floor(line / lines * (#self.bar - 1)) + 1
        return self.bar[i]
    end,

    static = {
      bar = {'█', '▇', '▆', '▅', '▄', '▃', '▂', '▁'},
    },
  }

  local vimode = {
    hl = function(self)
      return {fg = self.colors[self.mode:sub(1, 1)], style = 'bold,reverse'}
    end,

    init = function(self) self.mode = fn.mode(1) end,

    provider = function(self)
      return '  %-3.3('..self.modes[self.mode]..'%) '
    end,

    static = {
      colors = {
        c = hls.statement.fg,
        i = hls.string.fg,
        n = hls.normal.fg,
        r = hls.diffsub.fg,
        R = hls.diffch.fg,
        s = hls.special.fg,
        S = hls.special.fg,
        [''] = hls.special.fg,
        t = hls.type.fg,
        v = hls.search.bg,
        V = hls.search.bg,
        [''] = hls.search.bg,
        ['!'] = hls.errmsg.fg,
      },

      modes = {
        c = 'C',
        cv = 'CV',
        i = 'I',
        ic = 'IC',
        ix = 'IX',
        n = 'N',
        niI = 'NI',
        niR = 'NR',
        niV = 'NV',
        no = 'N?',
        nov = 'N?',
        noV = 'N?',
        ['no'] = 'N?',
        nt = 'NT',
        r = '...',
        rm = 'M',
        ['r?'] = '?',
        R = 'R',
        Rc = 'RC',
        Rv = 'RV',
        Rvc = 'RVC',
        Rvx = 'RVX',
        Rx = 'RX',
        s = 'S',
        S = 'S_',
        [''] = '^S',
        t = 'T',
        v = 'V',
        vs = 'VS',
        V = 'V_',
        Vs = 'V_S',
        [''] = '^V',
        ['s'] = '^VS',
        ['!'] = '!',
      },
    },
  }

  local def = {vimode, space, buf, align, file, ruler, space, scroll, space}

  local nc = {
    space, buf, align, file, ruler, space, scroll, space,
    condition = function() return not is_active() end,
    hl = {unpack(hls.statusnc), force = true},
  }

  local statusline = {
    nc, def,

    hl = function()
      local hl
      if is_active() then hl = hls.status
      else hl = hls.statusnc
      end
      return hl
    end,

    init = utils.pick_child_on_condition,
  }

  require'heirline'.setup(statusline)
end

return M
