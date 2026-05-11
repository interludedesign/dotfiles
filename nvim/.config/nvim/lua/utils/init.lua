local utils = {}

utils.floating_window = require("utils.floating_window")
utils.testing = require("utils.testing")
utils.string_decorators = require("utils.string_decorators")
utils.buffer = require("utils.buffer")
utils.alternate_path = require("utils.alternate_path")
utils.testing = require("utils.testing")
utils.git = require("utils.git")
utils.case_converters = require("utils.case_converters")
utils.date = require("utils.date")

function utils.SmartOpen()
  -- Check if cursor is within a markdown link [text](url) on the current line
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1  -- convert to 1-indexed

  local target = nil
  local search_pos = 1
  while true do
    local s, e, link_url = line:find('%[.-%]%((.-)%)', search_pos)
    if not s then break end
    if col >= s and col <= e then
      target = link_url
      break
    end
    search_pos = e + 1
  end

  -- Fall back to WORD under cursor (includes special chars like :)
  if not target then
    target = vim.fn.expand('<cWORD>')
  end
  
  if target:match('^https?://') or target:match('%.com$') then
    -- Add protocol if missing
    if not target:match('^https?://') then
      target = 'https://' .. target
    end
    
    -- Detect OS and use appropriate command
    local open_cmd
    if vim.fn.has('mac') == 1 then
      open_cmd = 'open'
    elseif vim.fn.has('unix') == 1 then
      open_cmd = 'xdg-open'
    elseif vim.fn.has('win32') == 1 then
      open_cmd = 'start'
    else
      print('Unsupported OS for opening URLs')
      return
    end
    
    -- Run in background to avoid blocking and handle errors
    vim.fn.jobstart({ open_cmd, target }, { detach = true })
    print('Opening: ' .. target)
    return
  end
  
  -- Extract file path and line number (e.g., "file.rb:175")
  local file_path, line_num = target:match('^(.+):(%d+)$')
  if not file_path then
    file_path = target
    line_num = nil
  end
  
  local full_path = vim.fn.fnamemodify(vim.fn.expand(file_path), ':p')
  
  if vim.fn.filereadable(full_path) == 1 or vim.fn.isdirectory(full_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
    if line_num then
      vim.cmd(line_num)
    end
  else
    print('File not found: ' .. full_path)
  end
end

return utils
