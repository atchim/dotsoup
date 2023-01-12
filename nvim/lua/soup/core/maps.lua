local labels = {}
local function map_args(maps, _3fopts, descf, _3fdesc, _3flhs)
  local function mkargs(lhs, rhs, desc)
    local mode
    local _2_
    do
      local t_1_ = _3fopts
      if (nil ~= t_1_) then
        t_1_ = (t_1_).mode
      else
      end
      _2_ = t_1_
    end
    if (nil ~= _2_) then
      local t_4_ = _3fopts
      if (nil ~= t_4_) then
        t_4_ = (t_4_).mode
      else
      end
      mode = t_4_
    else
      mode = "n"
    end
    local pfx
    do
      local t_7_ = _3fopts
      if (nil ~= t_7_) then
        t_7_ = (t_7_).prefix
      else
      end
      pfx = t_7_
    end
    local lhs0
    if pfx then
      lhs0 = (pfx .. lhs)
    else
      lhs0 = lhs
    end
    local buffer
    do
      local t_10_ = _3fopts
      if (nil ~= t_10_) then
        t_10_ = (t_10_).buffer
      else
      end
      buffer = t_10_
    end
    local noremap
    do
      local t_12_ = _3fopts
      if (nil ~= t_12_) then
        t_12_ = (t_12_).noremap
      else
      end
      noremap = t_12_
    end
    local nowait
    do
      local t_14_ = _3fopts
      if (nil ~= t_14_) then
        t_14_ = (t_14_).nowait
      else
      end
      nowait = t_14_
    end
    local silent
    local _17_
    do
      local t_16_ = _3fopts
      if (nil ~= t_16_) then
        t_16_ = (t_16_).silent
      else
      end
      _17_ = t_16_
    end
    if (nil ~= _17_) then
      local t_19_ = _3fopts
      if (nil ~= t_19_) then
        t_19_ = (t_19_).silent
      else
      end
      silent = t_19_
    else
      silent = true
    end
    return {mode, lhs0, rhs, {buffer = buffer, desc = desc, noremap = noremap, nowait = nowait, silent = silent}}
  end
  local desc
  if (nil ~= _3fdesc) then
    desc = _3fdesc
  else
    desc = ""
  end
  local labels0 = {}
  local lhs
  if (nil ~= _3flhs) then
    lhs = _3flhs
  else
    lhs = ""
  end
  local _3fname
  do
    local t_24_ = maps
    if (nil ~= t_24_) then
      t_24_ = (t_24_).name
    else
    end
    _3fname = t_24_
  end
  if _3fname then
    desc = descf(desc, _3fname)
  else
  end
  local function _27_()
    for key, val in pairs(maps) do
      local lhs0 = (lhs .. key)
      local _28_ = {key, val}
      if ((_G.type(_28_) == "table") and ((_28_)[1] == "name") and (nil ~= (_28_)[2])) then
        local name = (_28_)[2]
        labels0.name = name
      elseif ((_G.type(_28_) == "table") and true and ((_G.type((_28_)[2]) == "table") and (nil ~= ((_28_)[2])[1]) and (nil ~= ((_28_)[2])[2]))) then
        local _ = (_28_)[1]
        local rhs = ((_28_)[2])[1]
        local desc_2a = ((_28_)[2])[2]
        local desc0 = descf(desc, desc_2a)
        do end (labels0)[key] = desc_2a
        coroutine.yield(mkargs(lhs0, rhs, desc0))
      else
        local function _29_()
          local _ = (_28_)[1]
          local s = ((_28_)[2])[1]
          local function _30_()
            local ty_9_auto = type(s)
            return (ty_9_auto == "string")
          end
          return _30_()
        end
        if (((_G.type(_28_) == "table") and true and ((_G.type((_28_)[2]) == "table") and (nil ~= ((_28_)[2])[1]))) and _29_()) then
          local _ = (_28_)[1]
          local s = ((_28_)[2])[1]
          labels0[key] = s
        else
          local function _31_()
            local _ = (_28_)[1]
            local s = (_28_)[2]
            local function _32_()
              local ty_9_auto = type(s)
              return (ty_9_auto == "string")
            end
            return _32_()
          end
          if (((_G.type(_28_) == "table") and true and (nil ~= (_28_)[2])) and _31_()) then
            local _ = (_28_)[1]
            local s = (_28_)[2]
            labels0[key] = s
          else
            local function _33_()
              local _ = (_28_)[1]
              local t = (_28_)[2]
              local function _34_()
                local ty_9_auto = type(t)
                return (ty_9_auto == "table")
              end
              return _34_()
            end
            if (((_G.type(_28_) == "table") and true and (nil ~= (_28_)[2])) and _33_()) then
              local _ = (_28_)[1]
              local t = (_28_)[2]
              local iter, labels_2a = map_args(val, _3fopts, descf, desc, lhs0)
              do end (labels0)[key] = labels_2a
              for args in iter do
                coroutine.yield(args)
              end
            else
            end
          end
        end
      end
    end
    return nil
  end
  return coroutine.wrap(_27_), {labels0, _3fopts}
end
local function map_21(maps, _3fopts, _3fdescf)
  local ok_3f, which_key = pcall(require, "which-key")
  if ok_3f then
    return which_key.register(maps, _3fopts)
  else
    local descf
    if (nil ~= _3fdescf) then
      descf = _3fdescf
    else
      local function _36_(acc, desc)
        if ("" == acc) then
          return desc
        else
          return (acc .. " " .. desc:gsub("^%u", string.lower))
        end
      end
      descf = _36_
    end
    local iter, labels_2a = map_args(maps, _3fopts, descf)
    local kmap = vim.keymap.set
    table.insert(labels, labels_2a)
    for args in iter do
      kmap(unpack(args))
    end
    return nil
  end
end
local function init()
  local function _40_()
    local f = vim.fn
    local _41_
    if (f.empty(f.filter(f.getwininfo(), "v:val.quickfix")) == 1) then
      _41_ = "copen"
    else
      _41_ = "cclose"
    end
    return vim.cmd[_41_]()
  end
  map_21({["<Leader>"] = {c = {name = "Quickfix", ["<CR>"] = {"<Cmd>copen<CR>", "Open"}, c = {_40_, "Toggle"}, j = {"<Cmd>cbelow<CR>", "Go to next below"}, k = {"<Cmd>cabove<CR>", "Go to next above"}, n = {"<Cmd>cnext<CR>", "Go to next"}, p = {"<Cmd>cprevious<CR>", "Go to previous"}}, k = {"<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic show from line"}, t = {name = "Toggle", l = {"<Cmd>setlocal list!<CR>", "Local listing"}, s = {"<Cmd>setlocal spell!<CR>", "Local spelling"}}}, ["[d"] = {"<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic go to previous"}, ["]d"] = {"<Cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic go to next"}})
  map_21({["<Leader>y"] = {"\"+y", "CTRL-C-like yank to clipboard"}}, {mode = {"n", "v"}})
  return map_21({["<Leader>p"] = {"\"_dP", "Register-safe paste"}}, {mode = "x"})
end
return {init = init, labels = labels, map = map_21}
