local Story = {
  id = nil,
  title = "",
  completed = false,
}

function Story:setup(task, id)
  self.id = id
  self.title = task.description
  self.completed = task.checked

  return self
end

function Story:render()
  local storyContent = [[
## Description

## Tasks

## Acceptance Criteria
]]

  return  "# " .. self.id .. "\n" .. self.title .. "\n\n" .. storyContent
end

return Story
