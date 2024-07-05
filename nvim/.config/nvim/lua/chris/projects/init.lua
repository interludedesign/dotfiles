local Project = {
  cwd = "",
  config = {},
}

local counter = require("chris.projects.counter")
local tasks = require("chris.projects.tasks")
local stories = require("chris.projects.story")
local file = require("chris.projects.file")

function Project.setup()
  Project.cwd = vim.fn.expand('%:p:h')
  Project.config = file.read_lua(Project.cwd .. '/.project.lua')
  counter:setup(Project.cwd .. '/.counter')

  return self
end

function Project.create_story_from_task()
  if Project.cwd == "" then
    print("Error: Setup not initialized. Call Project.setup() first.")
    return
  end

  counter:increment()

  local task = tasks:setup(
    Project.get_content_under_cursor(), Project.generate_id()
  )

  if task.id == nil then
    print("Error: Unable to parse task")
    return
  end

  local story = stories:setup(task, Project.generate_id())
  local story_content = story:render()
  local story_filename = string.format("%s/%s.md", Project.cwd .. '/stories', Project.generate_id())

  Project.set_content_under_cursor(task:render())
  file.create(story_filename, story_content)
  counter:write()
end

function Project.generate_id()
  local prefix = Project.config.prefix or "UNKNOWN"

  return string.format("%s-%04d", prefix, counter.current_index)
end

function Project.get_content_under_cursor()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

  return vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
end

function Project.set_content_under_cursor(content)
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

  vim.api.nvim_buf_set_lines(0, row - 1, row, true, {content})
  vim.api.nvim_command('w')
end

return Project
