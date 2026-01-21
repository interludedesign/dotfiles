local M = {}

function M.insert_date()
  local date = os.date("%Y-%m-%d")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos[2]) .. date .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #date })
end

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    M.insert_date()
  end, { desc = "Insert current date (YYYY-MM-DD)" })
end

return M
