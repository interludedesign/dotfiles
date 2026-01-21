local M = {}

-- Normalize filename: trim whitespace and add .md extension if missing
function M.normalize_filename(filename)
  if not filename or filename == "" then
    return nil
  end
  
  -- Trim whitespace
  filename = vim.trim(filename)
  
  if filename == "" then
    return nil
  end
  
  -- Add .md extension if not present
  if not filename:match("%.md$") then
    filename = filename .. ".md"
  end
  
  return filename
end

-- Create a new doc file in ~/docs and open it
function M.create_doc(filename)
  local normalized = M.normalize_filename(filename)
  
  if not normalized then
    vim.notify("Please provide a filename", vim.log.levels.WARN)
    return false
  end
  
  local docs_dir = vim.fn.expand("~/docs")
  local filepath = docs_dir .. "/" .. normalized
  
  -- Check if file already exists
  local stat = vim.loop.fs_stat(filepath)
  if stat then
    vim.notify("Opening existing file: " .. normalized, vim.log.levels.INFO)
    vim.cmd.edit(filepath)
    return true
  end
  
  -- Create the file
  local file = io.open(filepath, "w")
  if not file then
    vim.notify("Failed to create file: " .. normalized, vim.log.levels.ERROR)
    return false
  end
  
  file:close()
  vim.notify("Created new doc: " .. normalized, vim.log.levels.INFO)
  vim.cmd.edit(filepath)
  return true
end

return M
