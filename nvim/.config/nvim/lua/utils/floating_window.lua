local floating_window = {}

--- Show a Lua table or text in a syntax-highlighted floating window.
--- @param content any The content to display. If it's a table, it will be pretty-printed using `vim.inspect`.
--- @param filetype string The filetype to use for syntax highlighting (e.g., "lua", "json").
function floating_window.show(content, filetype)
  -- Convert the content to a string if it's a table
  local output = type(content) == "table" and vim.inspect(content) or tostring(content)

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set the content of the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))

  -- Get the dimensions of the Neovim window
  local width = vim.opt.columns:get()
  local height = vim.opt.lines:get()
  local win_width = math.floor(width * 0.8)
  local win_height = math.floor(height * 0.8)
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  -- Open the floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Set the filetype for syntax highlighting
  vim.bo[buf].filetype = filetype

  -- Make the floating window closable with <q>
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

return floating_window
