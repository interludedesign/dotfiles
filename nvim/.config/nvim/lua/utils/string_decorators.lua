local string_decorators = {}

function string_decorators.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function string_decorators.escape(str)
  return string.gsub(str, "-", "")
end

return string_decorators
