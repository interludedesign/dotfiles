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
  -- Get the entire WORD under cursor (includes special chars like :)
  local target = vim.fn.expand('<cWORD>')
  
  if target:match('^https?://') or target:match('%.com$') then
    -- Add protocol if missing
    if not target:match('^https?://') then
      target = 'https://' .. target
    end
    vim.fn.system(string.format('open "%s"', target))
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
