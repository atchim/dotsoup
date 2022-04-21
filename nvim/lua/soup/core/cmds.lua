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
local function comp(lead, line, pos)
  local args
  do
    local _let_9_ = vim.fn.matchstrpos(line, "S\\%[oup] *\\zs.*")
    local _ = _let_9_[1]
    local start = _let_9_[2]
    local _0 = _let_9_[3]
    local _local_10_ = require("soup.utils")
    local split = _local_10_["split"]
    local tbl_15_auto = {}
    local i_16_auto = #tbl_15_auto
    for start0, _end in split(line, "%s+", (1 + start)) do
      local val_17_auto
      if ((start0 < pos) and (_end < pos)) then
        val_17_auto = line:sub(start0, _end)
      else
        val_17_auto = nil
      end
      if (nil ~= val_17_auto) then
        i_16_auto = (i_16_auto + 1)
        do end (tbl_15_auto)[i_16_auto] = val_17_auto
      else
      end
    end
    args = tbl_15_auto
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
    local function _14_()
      local tbl_15_auto = {}
      local i_16_auto = #tbl_15_auto
      for arg_2a, _ in pairs(subcmd) do
        local val_17_auto
        do
          local start, _0 = arg_2a:find(lead0, 1, true)
          if (nil ~= start) then
            val_17_auto = arg_2a
          else
            val_17_auto = nil
          end
        end
        if (nil ~= val_17_auto) then
          i_16_auto = (i_16_auto + 1)
          do end (tbl_15_auto)[i_16_auto] = val_17_auto
        else
        end
      end
      return tbl_15_auto
    end
    return vim.fn.sort(_14_())
  end
end
local function init()
  local function _18_(repl)
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
  vim.api.nvim_create_user_command("Soup", _18_, {complete = comp, count = 0, desc = "Soup commands.", nargs = "+"})
  return (require("soup.core.maps")).map({["[b"] = {"<Cmd>Soup buf prev<CR>", "Buffer previous"}, ["]b"] = {"<Cmd>Soup buf next<CR>", "Buffer next"}, gb = {"<Cmd>Soup buf goto<CR>", "Buffer goto"}, gB = {"<Cmd>Soup buf del<CR>", "Buffer delete"}})
end
return {init = init}
