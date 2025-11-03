local case_converters = {}

function case_converters.snake_to_pascal()
  local word = vim.fn.expand('<cword>')

  -- Convert to PascalCase
  local pascal = word:gsub("_(%l)", function(c)
    return c:upper()
  end):gsub("^%l", string.upper)

  -- Replace the word under the cursor
  vim.cmd('normal! ciw' .. pascal)
end

-- Map it to <leader>tc
vim.keymap.set('n', '<leader>tc', case_converters.snake_to_pascal, { desc = "Convert snake_case to PascalCase" })

return case_converters
