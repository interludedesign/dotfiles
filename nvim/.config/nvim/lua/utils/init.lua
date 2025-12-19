local utils = {}

utils.floating_window = require("utils.floating_window")
utils.testing = require("utils.testing")
utils.string_decorators = require("utils.string_decorators")
utils.buffer = require("utils.buffer")
utils.alternate_path = require("utils.alternate_path")
utils.testing = require("utils.testing")
utils.git = require("utils.git")
utils.case_converters = require("utils.case_converters")

function utils.SmartOpen()
  local target = vim.fn.expand('<cfile>')
  
  if target:match('^https?://') or target:match('%.com$') then
    -- Add protocol if missing
    if not target:match('^https?://') then
      target = 'https://' .. target
    end
    vim.fn.system(string.format('open "%s"', target))
    return
  end
  
  local full_path = vim.fn.fnamemodify(vim.fn.expand(target), ':p')
  
  if vim.fn.filereadable(full_path) == 1 or vim.fn.isdirectory(full_path) == 1 then
    vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
  else
    print('File not found: ' .. full_path)
  end
end

return utils
