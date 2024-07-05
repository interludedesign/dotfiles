-- Task is todo with a checkbox and description
-- ie [] Task description

local Task = {
  id = nil,
  checked = false,
  description = "",
}

function Task:setup(task_string, id)
  self.id = id
  local task = Task:parse(task_string)

  if task then
    self.checked = task.checked
    self.description = task.description
  end

  return self
end

function Task:parse(task_string)
  local checkbox_pattern = "^%[%s?([%sx]?)%]"
  local checkbox = task_string:match(checkbox_pattern)

  if not checkbox then
    print("No checkbox found")
    return nil
  end

  local checked = (checkbox == "x")
  local description = task_string:gsub(checkbox_pattern, "", 1):match("^%s*(.-)%s*$")

  return { checked = checked, description = description }
end

function Task:render()
  local checkbox = self.checked and "[x]" or "[]"
  local rendered_string = string.format("%s [[%s]] %s", checkbox, self.id, self.description)

  return rendered_string
end

return Task
