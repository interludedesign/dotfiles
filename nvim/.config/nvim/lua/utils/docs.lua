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

-- Extract header text from a markdown header line
-- Returns header text without # symbols, or nil if not a header
function M.extract_header_from_line(line)
  if not line or line == "" then
    return nil
  end
  
  -- Match markdown headers: # Header, ## Header, etc.
  local header_text = line:match("^#+%s+(.+)$")
  if header_text then
    return vim.trim(header_text)
  end
  
  return nil
end

-- Get the visual selection as a table of lines with start and end positions
function M.get_visual_selection()
  -- Get the start and end of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  
  if start_line == 0 or end_line == 0 then
    return nil, nil, nil
  end
  
  -- Get the actual selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  return lines, start_line, end_line
end

-- Create a wiki-style link
function M.create_wiki_link(header_text)
  return "[[" .. header_text .. "]]"
end

-- Extract a markdown section to a new file
function M.extract_section()
  -- Get visual selection
  local lines, start_line, end_line = M.get_visual_selection()
  
  if not lines or #lines == 0 then
    vim.notify("No selection found", vim.log.levels.WARN)
    return false
  end
  
  -- Extract header from first line
  local header_text = M.extract_header_from_line(lines[1])
  
  if not header_text then
    vim.notify("Selection must start with a markdown header (# Header)", vim.log.levels.WARN)
    return false
  end
  
  -- Get current file's directory
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    vim.notify("Current buffer must be saved to a file first", vim.log.levels.WARN)
    return false
  end
  
  local current_dir = vim.fn.fnamemodify(current_file, ":h")
  
  -- Create filename from header text
  local filename = M.normalize_filename(header_text)
  if not filename then
    vim.notify("Could not create filename from header", vim.log.levels.ERROR)
    return false
  end
  
  local filepath = current_dir .. "/" .. filename
  
  -- Check if file already exists
  local stat = vim.loop.fs_stat(filepath)
  if stat then
    vim.notify("File already exists: " .. filename, vim.log.levels.WARN)
    return false
  end
  
  -- Prepare content (all lines except the first header)
  local content_lines = {}
  for i = 2, #lines do
    table.insert(content_lines, lines[i])
  end
  local content = table.concat(content_lines, "\n")
  
  -- Create the file
  local file = io.open(filepath, "w")
  if not file then
    vim.notify("Failed to create file: " .. filename, vim.log.levels.ERROR)
    return false
  end
  
  file:write(content)
  file:close()
  
  -- Replace selection with wiki link
  local wiki_link = M.create_wiki_link(header_text)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, {wiki_link})
  
  -- Open the newly created file
  vim.cmd.edit(filepath)
  
  vim.notify("Extracted section to: " .. filename, vim.log.levels.INFO)
  return true
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
