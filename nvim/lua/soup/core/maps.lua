local function map_args(maps, _3fopts, _3fdescf, _3fdesc, _3fkeys)
  local descf
  if (nil == _3fdescf) then
    local function _1_(acc, desc)
      if ("" == acc) then
        return desc
      else
        return (acc .. " " .. desc:gsub("^%u", string.lower))
      end
    end
    descf = _1_
  else
    descf = _3fdescf
  end
  local desc
  if (nil ~= _3fdesc) then
    desc = _3fdesc
  else
    desc = ""
  end
  local keys
  if (nil ~= _3fkeys) then
    keys = _3fkeys
  else
    keys = ""
  end
  local function mkargs(keys0, cmd, desc0)
    local mode
    local _7_
    do
      local t_6_ = _3fopts
      if (nil ~= t_6_) then
        t_6_ = (t_6_).mode
      else
      end
      _7_ = t_6_
    end
    if (nil ~= _7_) then
      local t_9_ = _3fopts
      if (nil ~= t_9_) then
        t_9_ = (t_9_).mode
      else
      end
      mode = t_9_
    else
      mode = "n"
    end
    local keys1
    local function _17_()
      local _13_
      do
        local t_12_ = _3fopts
        if (nil ~= t_12_) then
          t_12_ = (t_12_).prefix
        else
        end
        _13_ = t_12_
      end
      if (nil ~= _13_) then
        local t_15_ = _3fopts
        if (nil ~= t_15_) then
          t_15_ = (t_15_).prefix
        else
        end
        return t_15_
      else
        return ""
      end
    end
    keys1 = (_17_() .. keys0)
    local buffer
    do
      local t_18_ = _3fopts
      if (nil ~= t_18_) then
        t_18_ = (t_18_).buffer
      else
      end
      buffer = t_18_
    end
    local noremap
    local _21_
    do
      local t_20_ = _3fopts
      if (nil ~= t_20_) then
        t_20_ = (t_20_).noremap
      else
      end
      _21_ = t_20_
    end
    if (nil ~= _21_) then
      local t_23_ = _3fopts
      if (nil ~= t_23_) then
        t_23_ = (t_23_).noremap
      else
      end
      noremap = t_23_
    else
      noremap = true
    end
    local nowait
    do
      local t_26_ = _3fopts
      if (nil ~= t_26_) then
        t_26_ = (t_26_).nowait
      else
      end
      nowait = t_26_
    end
    local silent
    local _29_
    do
      local t_28_ = _3fopts
      if (nil ~= t_28_) then
        t_28_ = (t_28_).silent
      else
      end
      _29_ = t_28_
    end
    if (nil ~= _29_) then
      local t_31_ = _3fopts
      if (nil ~= t_31_) then
        t_31_ = (t_31_).silent
      else
      end
      silent = t_31_
    else
      silent = true
    end
    return {mode, keys1, cmd, {desc = desc0, noremap = noremap, nowait = nowait, silent = silent}}, buffer
  end
  do
    local gname
    do
      local t_34_ = maps
      if (nil ~= t_34_) then
        t_34_ = (t_34_).name
      else
      end
      gname = t_34_
    end
    if gname then
      desc = descf(desc, gname)
    else
    end
  end
  local function _37_()
    for key, val in pairs(maps) do
      local keys0 = (keys .. key)
      local _38_ = {key, val}
      if ((_G.type(_38_) == "table") and ((_38_)[1] == "name") and true) then
        local _ = (_38_)[2]
      elseif ((_G.type(_38_) == "table") and true and ((_G.type((_38_)[2]) == "table") and (nil ~= ((_38_)[2])[1]) and (nil ~= ((_38_)[2])[2]))) then
        local _ = (_38_)[1]
        local cmd = ((_38_)[2])[1]
        local desc_2b = ((_38_)[2])[2]
        local desc0 = descf(desc, desc_2b)
        coroutine.yield(mkargs(keys0, cmd, desc0))
      elseif true then
        local _ = _38_
        for args, buffer in map_args(val, _3fopts, descf, desc, keys0) do
          coroutine.yield(args, buffer)
        end
      else
      end
    end
    return nil
  end
  return coroutine.wrap(_37_)
end
local function map(maps, _3fopts, _3fdescf)
  local bkmap = vim.api.nvim_buf_set_keymap
  local kmap = vim.api.nvim_set_keymap
  local ok_3f, which_key = pcall(require, "which-key")
  if ok_3f then
    return which_key.register(maps, _3fopts)
  else
    for args, buf in map_args(maps, _3fopts, _3fdescf) do
      if (nil == buf) then
        kmap(unpack(args))
      else
        bkmap(buf, unpack(args))
      end
    end
    return nil
  end
end
local function init()
  map({["<Leader>k"] = {"<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic show from line"}, ["[d"] = {"<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic go to previous"}, ["]d"] = {"<Cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic go to next"}, ["<Leader>t"] = {name = "Toggle", l = {"<Cmd>setlocal list!<CR>", "Local listing"}, L = {"<Cmd>set list!<CR>", "Global listing"}, s = {"<Cmd>setlocal spell!<CR>", "Local spelling"}, S = {"<Cmd>set spell!<CR>", "Global spelling"}}})
  map({["<Leader>y"] = {"\"+y", "CTRL-C-like yank to clipboard"}}, {mode = "v"})
  return map({["<Leader>p"] = {"\"_dP", "Register-safe paste"}}, {mode = "x"})
end
return {init = init, map_args = map_args, map = map}
