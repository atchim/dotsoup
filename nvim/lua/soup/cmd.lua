local cmds
local function _1_()
  return pcall(vim.api.nvim_buf_delete, vim.v.count, {})
end
local function _2_()
  return pcall(vim.api.nvim_set_current_buf, vim.v.count)
end
local function _3_()
  local function _4_()
    local n_2_auto = vim.v.count
    if (0 == n_2_auto) then
      return 1
    else
      return n_2_auto
    end
  end
  return vim.cmd(("bnext " .. _4_()))
end
local function _6_()
  local function _7_()
    local n_2_auto = vim.v.count
    if (0 == n_2_auto) then
      return 1
    else
      return n_2_auto
    end
  end
  return vim.cmd(("bprevious " .. _7_()))
end
cmds = {buf = {del = _1_, ["goto"] = _2_, next = _3_, prev = _6_}}
local function split(s, _3fsep, _3fi)
  local len = #s
  local sep
  if (nil ~= _3fsep) then
    sep = _3fsep
  else
    sep = "%s+"
  end
  local offset
  if (nil ~= _3fi) then
    offset = _3fi
  else
    offset = 1
  end
  local exhausted_3f = false
  local function _11_()
    local start, _end = nil, nil
    do
      local start0, _end0 = s:find(sep, offset)
      if (1 == start0) then
        offset = (1 + _end0)
        start, _end = s:find(sep, offset)
      else
        start, _end = start0, _end0
      end
    end
    if exhausted_3f then
      return nil
    elseif (nil ~= start) then
      local old_offset = offset
      exhausted_3f = (len == _end)
      offset = (1 + _end)
      return old_offset, (start - 1)
    else
      exhausted_3f = true
      return offset, len
    end
  end
  return _11_
end
local function comp(lead, line, pos)
  local args
  do
    local _let_14_ = vim.fn.matchstrpos(line, "S\\%[oup] *\\zs.*")
    local _ = _let_14_[1]
    local start = _let_14_[2]
    local _0 = _let_14_[3]
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for start0, _end in split(line, "%s+", (1 + start)) do
      local val_19_auto
      if ((start0 < pos) and (_end < pos)) then
        val_19_auto = line:sub(start0, _end)
      else
        val_19_auto = nil
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    args = tbl_17_auto
  end
  local subcmd, broken_3f = nil, nil
  do
    local subcmd0 = cmds
    local broken_3f0 = false
    for _, arg_2a in ipairs(args) do
      if broken_3f0 then break end
      local item = (subcmd0)[arg_2a]
      if ("table" == type(item)) then
        subcmd0 = item
      else
        broken_3f0 = true
      end
    end
    subcmd, broken_3f = subcmd0, broken_3f0
  end
  if broken_3f then
    return {}
  else
    local lead0 = lead:sub(1, pos)
    local function _18_()
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for arg_2a, _ in pairs(subcmd) do
        local val_19_auto
        do
          local start, _0 = arg_2a:find(lead0, 1, true)
          if (nil ~= start) then
            val_19_auto = arg_2a
          else
            val_19_auto = nil
          end
        end
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      return tbl_17_auto
    end
    return vim.fn.sort(_18_())
  end
end
local function setup()
  local function _22_(repl)
    local cmd
    do
      local cmd0 = cmds
      for _, farg in ipairs(repl.fargs) do
        local subcmd = (cmd0)[farg]
        if (nil ~= subcmd) then
          cmd0 = subcmd
        else
          error(("invalid subcommand: " .. farg))
        end
      end
      cmd = cmd0
    end
    if ("function" == type(cmd)) then
      return cmd(repl)
    else
      return error("missing subcommand")
    end
  end
  vim.api.nvim_create_user_command("Soup", _22_, {complete = comp, count = 0, desc = "Soup commands.", nargs = "+"})
  local map = vim.keymap.set
  map("n", "[b", "<Cmd>Soup buf prev<CR>", {desc = "Buffer previous"})
  map("n", "]b", "<Cmd>Soup buf next<CR>", {desc = "Buffer next"})
  map("n", "gb", "<Cmd>Soup buf goto<CR>", {desc = "Buffer goto"})
  return map("n", "gB", "<Cmd>Soup buf del<CR>", {desc = "Buffer delete"})
end
return {setup = setup}
