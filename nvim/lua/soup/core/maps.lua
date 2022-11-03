local M = {}
M.map_args = function(maps, _3fopts, _3fdescf, _3fdesc, _3fkeys)
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
  do
    local val_6_auto = _3fdesc
    if (nil ~= val_6_auto) then
      desc = val_6_auto
    else
      desc = ""
    end
  end
  local keys
  do
    local val_6_auto = _3fkeys
    if (nil ~= val_6_auto) then
      keys = val_6_auto
    else
      keys = ""
    end
  end
  local function mkargs(keys0, cmd, desc0)
    local mode
    do
      local val_6_auto
      do
        local t_6_ = _3fopts
        if (nil ~= t_6_) then
          t_6_ = (t_6_).mode
        else
        end
        val_6_auto = t_6_
      end
      if (nil ~= val_6_auto) then
        mode = val_6_auto
      else
        mode = "n"
      end
    end
    local keys1
    local function _11_()
      local val_6_auto
      do
        local t_9_ = _3fopts
        if (nil ~= t_9_) then
          t_9_ = (t_9_).prefix
        else
        end
        val_6_auto = t_9_
      end
      if (nil ~= val_6_auto) then
        return val_6_auto
      else
        return ""
      end
    end
    keys1 = (_11_() .. keys0)
    local buffer
    do
      local t_13_ = _3fopts
      if (nil ~= t_13_) then
        t_13_ = (t_13_).buffer
      else
      end
      buffer = t_13_
    end
    local noremap
    do
      local val_6_auto
      do
        local t_15_ = _3fopts
        if (nil ~= t_15_) then
          t_15_ = (t_15_).noremap
        else
        end
        val_6_auto = t_15_
      end
      if (nil ~= val_6_auto) then
        noremap = val_6_auto
      else
        noremap = true
      end
    end
    local nowait
    do
      local t_18_ = _3fopts
      if (nil ~= t_18_) then
        t_18_ = (t_18_).nowait
      else
      end
      nowait = t_18_
    end
    local silent
    do
      local val_6_auto
      do
        local t_20_ = _3fopts
        if (nil ~= t_20_) then
          t_20_ = (t_20_).silent
        else
        end
        val_6_auto = t_20_
      end
      if (nil ~= val_6_auto) then
        silent = val_6_auto
      else
        silent = true
      end
    end
    return {mode, keys1, cmd, {desc = desc0, noremap = noremap, nowait = nowait, silent = silent}}, buffer
  end
  do
    local gname
    do
      local t_23_ = maps
      if (nil ~= t_23_) then
        t_23_ = (t_23_).name
      else
      end
      gname = t_23_
    end
    if gname then
      desc = descf(desc, gname)
    else
    end
  end
  local function _26_()
    for key, val in pairs(maps) do
      local keys0 = (keys .. key)
      local _27_ = {key, val}
      if ((_G.type(_27_) == "table") and ((_27_)[1] == "name") and true) then
        local _ = (_27_)[2]
      elseif ((_G.type(_27_) == "table") and true and ((_G.type((_27_)[2]) == "table") and (nil ~= ((_27_)[2])[1]) and (nil ~= ((_27_)[2])[2]))) then
        local _ = (_27_)[1]
        local cmd = ((_27_)[2])[1]
        local desc_2b = ((_27_)[2])[2]
        local desc0 = descf(desc, desc_2b)
        coroutine.yield(mkargs(keys0, cmd, desc0))
      elseif true then
        local _ = _27_
        for args, buffer in M.map_args(val, _3fopts, descf, desc, keys0) do
          coroutine.yield(args, buffer)
        end
      else
      end
    end
    return nil
  end
  return coroutine.wrap(_26_)
end
M.map = function(maps, _3fopts, _3fdescf)
  local bkmap = vim.api.nvim_buf_set_keymap
  local kmap = vim.api.nvim_set_keymap
  local ok_3f, which_key = pcall(require, "which-key")
  if ok_3f then
    return which_key.register(maps, _3fopts)
  else
    for args, buf in M.map_args(maps, _3fopts, _3fdescf) do
      if (nil == buf) then
        kmap(unpack(args))
      else
        bkmap(buf, unpack(args))
      end
    end
    return nil
  end
end
M.init = function()
  M.map({["<Leader>k"] = {"<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic show from line"}, ["[d"] = {"<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Diagnostic go to previous"}, ["]d"] = {"<Cmd>lua vim.diagnostic.goto_next()<CR>", "Diagnostic go to next"}, ["<Leader>t"] = {name = "Toggle", l = {"<Cmd>setlocal list!<CR>", "Local listing"}, s = {"<Cmd>setlocal spell!<CR>", "Local spelling"}}})
  M.map({["<Leader>y"] = {"\"+y", "CTRL-C-like yank to clipboard"}}, {mode = "v"})
  return M.map({["<Leader>p"] = {"\"_dP", "Register-safe paste"}}, {mode = "x"})
end
return M
