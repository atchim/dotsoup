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
  local function _3_()
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
  return _3_
end
return {split = split}
