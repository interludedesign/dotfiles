local s = require("utils.string_decorators")

local buffer = {}

-- Return true / false if current bufname contains the given string
function buffer.does_bufname_contain(str)
  local bufname = a.nvim_buf_get_name(0)

  if (s.escape(bufname)):find(s.escape(str)) then
    return true
  end

  return false
end

return buffer
