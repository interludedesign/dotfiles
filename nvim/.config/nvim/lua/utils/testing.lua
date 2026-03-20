local a = require("utils.alternate_path")

local testing = {}

function testing.run_go_in_tmux()
  vim.api.nvim_command("write")

  local cmd = string.format("go run main.go\n")
  require("harpoon.tmux").sendCommand("%0", "clear\n")
  require("harpoon.tmux").sendCommand("%0", cmd)
end

function testing.run_spec_in_tmux()
  vim.api.nvim_command("write")
  local file = vim.api.nvim_buf_get_name(0)

  -- If the file is not a spec file, look for its alternate_path and use that instead
  local start_pos, _ = string.find(file, "_spec")
  if not start_pos then
    file = a.find()
  end

  local cmd = string.format("spec %s\n", file)
  require("harpoon.tmux").sendCommand("%0", "clear\n")
  require("harpoon.tmux").sendCommand("%0", cmd)
end

function testing.dotnet_test_to_clipboard()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local namespace = nil
  local classname = nil

  for _, line in ipairs(lines) do
    if not namespace then
      -- matches both block-scoped and file-scoped namespaces
      local ns = line:match("^%s*namespace%s+([%w%.]+)")
      if ns then
        namespace = ns
      end
    end
    if not classname then
      local cls = line:match("[^%w]class%s+([%w_]+)")
        or line:match("^class%s+([%w_]+)")
      if cls then
        classname = cls
      end
    end
    if namespace and classname then
      break
    end
  end

  if not classname then
    vim.notify("Could not determine class name from current file", vim.log.levels.WARN)
    return
  end

  local filter = namespace and (namespace .. "." .. classname) or classname
  local cmd = string.format('dotnet test --filter "FullyQualifiedName~%s"', filter)

  vim.fn.setreg("+", cmd)
  vim.notify("Copied: " .. cmd, vim.log.levels.INFO)
end

return testing
