local M = {}

local example_query = vim.treesitter.query.parse(
  "ruby",
    [[
      (call
        method: (identifier) @method (#eq? @method "it")
      (do_block
        (body_statement) @body)
      )
    ]]
)

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "ruby", {})
  local tree = parser:parse()[1]
  return tree:root()
end

M.create_folds = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local root = get_root(bufnr)

  for id, node in example_query:iter_captures(root, bufnr, 0, -1) do
    local name = example_query.captures[id]

    if name == "body" then
      local start_row, _, end_row, _ = node:range()
      local cmd = string.format('%s,%sfold', start_row + 1, end_row + 1)

      vim.cmd(cmd)
    end
  end
end

return M
