local function map_args(maps, _3fopts, _3fdescf, _3fdesc, _3fkeys)
  do
    local ty_8_auto = type(maps)
    assert((ty_8_auto == "table"), "`maps`is not table")
  end
  local opts
  if (nil ~= _3fopts) then
    opts = _3fopts
  else
    opts = {}
  end
  do
    local ty_8_auto = type(opts)
    assert((ty_8_auto == "table"), "`opts`is not table")
  end
  do
    local ty_8_auto = type(_3fdescf)
    assert(((ty_8_auto == "nil") or (ty_8_auto == "function")), "`?descf`is not nil or function")
  end
  local descf
  if (nil ~= _3fdescf) then
    local function _2_(acc, desc)
      local desc0 = _3fdescf(acc, desc)
      do
        local ty_8_auto = type(desc0)
        assert((ty_8_auto == "string"), "`desc`is not string")
      end
      return desc0
    end
    descf = _2_
  else
    local function _3_(acc, desc)
      if ("" ~= acc) then
        return (acc .. " " .. desc:gsub("^%u", string.lower))
      else
        return desc
      end
    end
    descf = _3_
  end
  local desc
  if (nil ~= _3fdesc) then
    desc = _3fdesc
  else
    desc = ""
  end
  do
    local ty_8_auto = type(desc)
    assert((ty_8_auto == "string"), "`desc`is not string")
  end
  local keys
  if (nil ~= _3fkeys) then
    keys = _3fkeys
  else
    keys = ""
  end
  do
    local ty_8_auto = type(keys)
    assert((ty_8_auto == "string"), "`keys`is not string")
  end
  local function mkargs(keys0, cmd, desc0)
    do
      local ty_8_auto = type(keys0)
      assert((ty_8_auto == "string"), "`keys`is not string")
    end
    do
      local ty_8_auto = type(cmd)
      assert(((ty_8_auto == "string") or (ty_8_auto == "function")), "`cmd`is not string or function")
    end
    do
      local ty_8_auto = type(desc0)
      assert((ty_8_auto == "string"), "`desc`is not string")
    end
    local mode
    local _9_
    do
      local t_8_ = opts
      if (nil ~= t_8_) then
        t_8_ = (t_8_).mode
      else
      end
      _9_ = t_8_
    end
    if (nil ~= _9_) then
      local t_11_ = opts
      if (nil ~= t_11_) then
        t_11_ = (t_11_).mode
      else
      end
      mode = t_11_
    else
      mode = "n"
    end
    do
      local ty_8_auto = type(mode)
      assert((ty_8_auto == "string"), "`mode`is not string")
    end
    local keys1
    local function _19_()
      local _15_
      do
        local t_14_ = opts
        if (nil ~= t_14_) then
          t_14_ = (t_14_).prefix
        else
        end
        _15_ = t_14_
      end
      if (nil ~= _15_) then
        local t_17_ = opts
        if (nil ~= t_17_) then
          t_17_ = (t_17_).prefix
        else
        end
        return t_17_
      else
        return ""
      end
    end
    keys1 = (_19_() .. keys0)
    do
      local ty_8_auto = type(keys1)
      assert((ty_8_auto == "string"), "`keys`is not string")
    end
    local buffer
    do
      local t_20_ = opts
      if (nil ~= t_20_) then
        t_20_ = (t_20_).buffer
      else
      end
      buffer = t_20_
    end
    do
      local ty_8_auto = type(buffer)
      assert(((ty_8_auto == "nil") or (ty_8_auto == "number")), "`buffer`is not nil or number")
    end
    local noremap
    local _23_
    do
      local t_22_ = opts
      if (nil ~= t_22_) then
        t_22_ = (t_22_).noremap
      else
      end
      _23_ = t_22_
    end
    if (nil ~= _23_) then
      local t_25_ = opts
      if (nil ~= t_25_) then
        t_25_ = (t_25_).noremap
      else
      end
      noremap = t_25_
    else
      noremap = true
    end
    do
      local ty_8_auto = type(noremap)
      assert((ty_8_auto == "boolean"), "`noremap`is not boolean")
    end
    local nowait
    do
      local t_28_ = opts
      if (nil ~= t_28_) then
        t_28_ = (t_28_).nowait
      else
      end
      nowait = t_28_
    end
    do
      local ty_8_auto = type(nowait)
      assert(((ty_8_auto == "nil") or (ty_8_auto == "boolean")), "`nowait`is not nil or boolean")
    end
    local silent
    local _31_
    do
      local t_30_ = opts
      if (nil ~= t_30_) then
        t_30_ = (t_30_).silent
      else
      end
      _31_ = t_30_
    end
    if (nil ~= _31_) then
      local t_33_ = opts
      if (nil ~= t_33_) then
        t_33_ = (t_33_).silent
      else
      end
      silent = t_33_
    else
      silent = true
    end
    do
      local ty_8_auto = type(silent)
      assert((ty_8_auto == "boolean"), "`silent`is not boolean")
    end
    return {mode, keys1, cmd, {desc = desc0, noremap = noremap, nowait = nowait, silent = silent}}, buffer
  end
  do
    local gname
    do
      local t_36_ = maps
      if (nil ~= t_36_) then
        t_36_ = (t_36_).name
      else
      end
      gname = t_36_
    end
    if gname then
      desc = descf(desc, gname)
    else
    end
  end
  local function _39_()
    for key, val in pairs(maps) do
      local keys0 = (keys .. key)
      local _40_ = {key, val}
      if ((_G.type(_40_) == "table") and ((_40_)[1] == "name") and true) then
        local _ = (_40_)[2]
      elseif ((_G.type(_40_) == "table") and true and ((_G.type((_40_)[2]) == "table") and (nil ~= ((_40_)[2])[1]) and (nil ~= ((_40_)[2])[2]))) then
        local _ = (_40_)[1]
        local cmd = ((_40_)[2])[1]
        local desc_2b = ((_40_)[2])[2]
        local desc0 = descf(desc, desc_2b)
        coroutine.yield(mkargs(keys0, cmd, desc0))
      elseif true then
        local _ = _40_
        for args, buffer in map_args(val, opts, descf, desc, keys0) do
          coroutine.yield(args, buffer)
        end
      else
      end
    end
    return nil
  end
  return coroutine.wrap(_39_)
end
local function map(maps, _3fopts, _3fdescf)
  do
    local ty_8_auto = type(maps)
    assert((ty_8_auto == "table"), "`maps`is not table")
  end
  local opts
  if (nil ~= _3fopts) then
    opts = _3fopts
  else
    opts = {}
  end
  do
    local ty_8_auto = type(opts)
    assert((ty_8_auto == "table"), "`opts`is not table")
  end
  do
    local ty_8_auto = type(_3fdescf)
    assert(((ty_8_auto == "nil") or (ty_8_auto == "function")), "`?descf`is not nil or function")
  end
  local bkmap = vim.api.nvim_buf_set_keymap
  local kmap = vim.api.nvim_set_keymap
  local ok_3f, which_key = pcall(require, "which-key")
  if ok_3f then
    return which_key.register(maps, opts)
  else
    for args, buf in map_args(maps, opts) do
      if (nil ~= buf) then
        bkmap(buf, unpack(args))
      else
        kmap(unpack(args))
      end
    end
    return nil
  end
end
local function init()
  map({["<Leader>k"] = {"<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic show from line"}, ["[d"] = {"<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic go to previous"}, ["]d"] = {"<Cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic go to next"}, ["<Leader>,"] = {"<Cmd>setl spell!<CR>", "Toggle local spelling"}, ["<Leader>."] = {"<Cmd>setl list!<CR>", "Toggle local listing"}})
  return map({["<Leader>y"] = {"\"+y", "CTRL-C-like yank to clipboard"}}, {mode = "v"})
end
return {init = init, map_args = map_args, map = map}
