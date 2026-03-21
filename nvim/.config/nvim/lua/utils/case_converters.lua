local case_converters = {}

local function detect_case(word)
  if word:find("_") then
    if word == word:upper() then
      return "screaming_snake"
    end
    return "snake"
  elseif word:find("-") then
    return "kebab"
  elseif word:match("^%l") and word:find("%u") then
    return "camel"
  elseif word:match("^%u") and word:find("%u", 2) and not word:find("[_%-]") then
    return "pascal"
  elseif word == word:upper() then
    return "upper"
  else
    return "unknown"
  end
end

local function split_into_words(word, case)
  local words = {}
  if case == "snake" or case == "screaming_snake" then
    for part in word:lower():gmatch("[^_]+") do
      table.insert(words, part)
    end
  elseif case == "kebab" then
    for part in word:lower():gmatch("[^%-]+") do
      table.insert(words, part)
    end
  elseif case == "camel" or case == "pascal" then
    -- Split on uppercase boundaries
    local result = word:gsub("(%u+)(%u%l)", "%1_%2"):gsub("(%l)(%u)", "%1_%2")
    for part in result:lower():gmatch("[^_]+") do
      table.insert(words, part)
    end
  else
    table.insert(words, word:lower())
  end
  return words
end

local function words_to_pascal(words)
  local result = ""
  for _, w in ipairs(words) do
    result = result .. w:sub(1, 1):upper() .. w:sub(2)
  end
  return result
end

local function words_to_camel(words)
  local result = ""
  for i, w in ipairs(words) do
    if i == 1 then
      result = w:lower()
    else
      result = result .. w:sub(1, 1):upper() .. w:sub(2)
    end
  end
  return result
end

function case_converters.to_camel()
  local word = vim.fn.expand('<cword>')
  local case = detect_case(word)
  local words = split_into_words(word, case)
  local camel = words_to_camel(words)
  vim.cmd('normal! ciw' .. camel)
end

function case_converters.to_pascal()
  local word = vim.fn.expand('<cword>')
  local case = detect_case(word)
  local words = split_into_words(word, case)
  local pascal = words_to_pascal(words)
  vim.cmd('normal! ciw' .. pascal)
end

function case_converters.snake_to_pascal()
  local word = vim.fn.expand('<cword>')
  local pascal = word:gsub("_(%l)", function(c)
    return c:upper()
  end):gsub("^%l", string.upper)
  vim.cmd('normal! ciw' .. pascal)
end

vim.keymap.set('n', '<leader>tc', case_converters.snake_to_pascal, { desc = "Convert snake_case to PascalCase" })

return case_converters
