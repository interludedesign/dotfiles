local string_decorators = {}

function string_decorators.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function string_decorators.escape(str)
  return string.gsub(str, "-", "")
end

function string_decorators.is_empty(str)
  if str == nil or string.len(str) < 1 then
    return true
  else
    return false
  end
end

return string_decorators
