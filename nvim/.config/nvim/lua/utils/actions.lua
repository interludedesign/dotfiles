local M = {}

-- Number of days from today to default the target due date to.
local DUE_OFFSET_DAYS = 10

-- Expand an action snippet at the cursor.
-- Format: "- [ ] Action - <Person> - <start> - <due> - <description>"
-- The start date is today and the due date is DUE_OFFSET_DAYS days from now.
-- <Person> and <description> are left as snippet tabstops to fill in.
function M.insert_action()
  local today = os.date("%Y-%m-%d")
  local due = os.date("%Y-%m-%d", os.time() + DUE_OFFSET_DAYS * 24 * 60 * 60)
  local snippet = string.format("- [ ] Action - ${1:Person} - %s - %s - ${2:description}", today, due)
  vim.snippet.expand(snippet)
end

function M.setup()
  vim.api.nvim_create_user_command("Action", function()
    M.insert_action()
  end, { desc = "Insert an action snippet (start = today, due = today + 10 days)" })
end

return M
