local M = {}

function M.insert_date()
  local date = os.date("%Y-%m-%d")
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos[2]) .. date .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #date })
end

function M.insert_time()
  local date = os.date("%Y-%m-%d")
  local hour = tonumber(os.date("%H"))
  local min = os.date("%M")
  local ampm = hour >= 12 and "pm" or "am"
  local hour12 = hour % 12
  if hour12 == 0 then hour12 = 12 end
  local time_str = string.format("%s - %d:%s%s", date, hour12, min, ampm)
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos[2]) .. time_str .. line:sub(pos[2] + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + #time_str })
end

function M.setup()
  vim.api.nvim_create_user_command("Date", function()
    M.insert_date()
  end, { desc = "Insert current date (YYYY-MM-DD)" })

  vim.api.nvim_create_user_command("Time", function()
    M.insert_time()
  end, { desc = "Insert current date and time (YYYY-MM-DD - H:MMam/pm)" })
end

return M
