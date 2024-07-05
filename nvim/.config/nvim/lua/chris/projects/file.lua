local File = {}

-- Read file and return lua chunk
function File.read_lua(filename)
  if vim.fn.filereadable(filename) == 1 then
    local lua_chunk = dofile(filename)

    return lua_chunk
  else
    print("Warning: Unable to open lua file")

    return {}
  end
end

function File.create(filename, content)
  local file = io.open(filename, "w")

  if file then
    file:write(content)
    file:close()
    vim.cmd("edit " .. filename)
  else
    print("Error: Unable to open file for writing")
  end
end

return File
