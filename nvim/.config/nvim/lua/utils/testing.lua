local a = require("utils.alternate_path")

local testing = {}

function testing.run_go_in_tmux()
  vim.api.nvim_command('write')

  local cmd = string.format("go run main.go\n")
  require("harpoon.tmux").sendCommand("%0", "clear\n")
  require("harpoon.tmux").sendCommand("%0", cmd)
end

function testing.run_spec_in_tmux()
  vim.api.nvim_command('write')
  local file = vim.api.nvim_buf_get_name(0)

  -- If the file is not a spec file, look for its alternate_path and use that instead
  local start_pos, _ = string.find(file, "_spec")
  if not start_pos then
    file = a.alternate_path()
  end

  local cmd = string.format("spec %s\n", file)
  require("harpoon.tmux").sendCommand("%0", "clear\n")
  require("harpoon.tmux").sendCommand("%0", cmd)
end

return testing
