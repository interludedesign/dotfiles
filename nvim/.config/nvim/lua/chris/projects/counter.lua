local Counter = {
  filename = "",
  current_index = 0,
}

function Counter:setup(filename)
  self.filename = filename
  self:read()
end

function Counter:read()
  local file = io.open(self.filename, "r")

  if not file then
    print("Error: Unable to open counter file for reading")
    return
  end

  local content = file:read("*all")

  self.current_index = tonumber(content)
  file:close()
end

function Counter:write()
  local file = io.open(self.filename, "w")

  if not file then
    print("Error: Unable to open counter file for writing")
    return
  end

  file:write(self.current_index)
  file:close()
end

function Counter:increment()
  self.current_index = self.current_index + 1
end

return Counter
