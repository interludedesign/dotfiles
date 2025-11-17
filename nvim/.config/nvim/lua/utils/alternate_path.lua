local s = require("utils.string_decorators")

local alternate_path = {}

function alternate_path.open(path, vim_command)
  path = path or vim.api.nvim_buf_get_name(0)
  local result = alternate_path.find(path)

  if s.is_empty(result) then
    return string.format("No alternate file for %s exists!", path)
  else
    vim.fn["execute"](vim_command .. " " .. result)
  end
end

function alternate_path.find(path)
  path = path or vim.api.nvim_buf_get_name(0)
  local command = string.format("! alt %s", path)
  return vim.fn["system"](command)
end

return alternate_path
